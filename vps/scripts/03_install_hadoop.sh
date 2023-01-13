#!/bin/bash

# Install Hadoop

# Abort on any error
set -Eeuo pipefail

# Import utils
source /home/ubuntu/tpa/scripts/utils.sh
HADOOP_HOME=/usr/local/hadoop
HADOOP_VERSION="hadoop-3.3.4"

cd /usr/local

__log_info 'Remove previous Hadoop installation'
rm -fr "${HADOOP_HOME:?}" "${HADOOP_VERSION:?}"

__log_info 'Remove previous Hadoop data directory and recreate it'
rm -rf /var/hadoop
mkdir -p /var/hadoop
chown ubuntu:ubuntu -R /var/hadoop

if [[ ! -f "${HADOOP_VERSION}.tar.gz" ]]; then
    __log_info 'Download Hadoop (~615M)'
    wget --progress=dot:giga "https://dlcdn.apache.org/hadoop/common/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz"
fi

__log_info 'Untar Hadoop (~615M)'
tar zxf "${HADOOP_VERSION}.tar.gz"
ln -sf "${HADOOP_VERSION}" "${HADOOP_HOME}"
rm -f hadoop/etc/hadoop/*.cmd hadoop/sbin/*.cmd hadoop/bin/*.cmd

__log_info 'Setup passphraseless ssh'
rm -f /home/ubuntu/.ssh/id_rsa /home/ubuntu/.ssh/id_rsa.pub
ssh-keygen -t rsa -P '' -f /home/ubuntu/.ssh/id_rsa
cat /home/ubuntu/.ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys
chmod 0600 /home/ubuntu/.ssh/authorized_keys
ssh-keyscan -t ecdsa-sha2-nistp256 localhost > /home/ubuntu/.ssh/known_hosts
chown ubuntu:ubuntu  /home/ubuntu/.ssh/*

__log_info 'Update the Hadoop configuration'
cp -f /home/ubuntu/tpa/config/hadoop/* "${HADOOP_HOME}/etc/hadoop"

__log_info 'Give tpa group ownership over Hadoop'
chown ubuntu:ubuntu -R "${HADOOP_VERSION}"

if [[ -n "$(pgrep -f 'ResourceManager|NodeManager' || true)" ]]; then
    __log_info "Stop YARN"
    s
fi

if [[ -n "$(pgrep -f 'NameNode|DataNode|SecondaryNameNode' || true)" ]]; then
    __log_info "Stop HDFS"
    su -l ubuntu -c "stop-dfs.sh"
fi

__log_info 'Format the Hadoop Distributed FileSystem'
su -l ubuntu -c "yes | hdfs namenode -format"

__log_info 'Start HDFS'
su -l ubuntu -c "start-dfs.sh"

__log_info 'Wait max 30sec for the NameNode to exit safemode'
SAFEMODE='ON'
MAX_WAIT_TIME=30
for i in $( seq 1 ${MAX_WAIT_TIME} )
do
    if [[ "$(hdfs dfsadmin -safemode get)" = 'Safe mode is OFF' ]]; then
        SAFEMODE='OFF'
        break
    fi
    __log_info "Waiting for NameNode to exit safemode ${i}/${MAX_WAIT_TIME}"
    sleep 1
done

if [[ "${SAFEMODE}" = "ON" ]]; then
    __log_error 'NameNode did not exit safemode'
    exit 1
fi

__log_info 'Create HDFS ubuntu user home directory'
su -l ubuntu -c 'hadoop fs -mkdir -p /user/adamspd'

__log_info 'Start YARN'
su -l ubuntu -c 'start-yarn.sh'

__log_info 'Installed Hadoop with success'
