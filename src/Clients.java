import oracle.kv.KVStore;

import java.util.List;
import java.util.Iterator;

import oracle.kv.KVStoreConfig;
import oracle.kv.KVStoreFactory;
import oracle.kv.FaultException;
import oracle.kv.StatementResult;
import oracle.kv.table.TableAPI;
import oracle.kv.table.Table;
import oracle.kv.table.Row;
import oracle.kv.table.PrimaryKey;
import oracle.kv.ConsistencyException;
import oracle.kv.RequestTimeoutException;

import java.lang.Integer;

import oracle.kv.table.TableIterator;
import oracle.kv.table.EnumValue;

import java.io.File;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import java.util.StringTokenizer;
import java.util.ArrayList;
import java.util.List;
import SqlUtils;

public class Clients {
    private final KVStore store;
    private final String dataPath = "/home/debian/tpa/files/csv/";
    private final String myFile = "Clients.csv";
    private final String tableClient = "CLIENT_SOPHIA2223_TPA_GROUPE_4";

    /**
     * Runs the DDL command line program.
     */
    public static void main(String[] args) {
        try {
            Clients client = new Clients(args);
            client.initClientTablesAndData(client);

            // marketing.getClientByKey("4231 HC 31");

            client.getClientRows();

        } catch (RuntimeException e) {
            e.printStackTrace();
        }
    }

    public Clients(String[] argv) {

        String storeName = "kvstore";
        String hostName = "localhost";
        String hostPort = "5000";

        final int nArgs = argv.length;
        int argc = 0;
        store = KVStoreFactory.getStore
                (new KVStoreConfig(storeName, hostName + ":" + hostPort));
    }


    /**
     * La méthode initClientTablesAndData permet :
     * - de supprimer les tables si elles existent
     * - de créer des tables
     * - Insérer des critères
     * - et charger les datas de marketing
     **/

    public void initClientTablesAndData(Clients client) {
    	SqlUtils.dropTable(tableClient, store);
        client.createTableClient();
        // immatriculations.insertImmRows();
        client.loadClientDataFromFile(dataPath + myFile);
    }

    /**
     * public void createTableClient()
     * Methode de création de la table Marketing.
     */

    public void createTableClient() {
        String statement = null;
        statement = "create table " + tableClient + " ("
        		+ "ID STRING,"
                + "AGE INTEGER,"
                + "SEXE STRING,"
                + "TAUX INTEGER,"
                + "SITUATION_FAMILIALE STRING,"
                + "NOMBRE_ENFANTS  INTEGER,"
                + "DEUXIEME_VOITURE BOOLEAN,"
                + "IMMATRICULATION STRING,"
                + "PRIMARY KEY(ID))";
        SqlUtils.executeDDL(statement, store);
    }

    /**
     * private void insertNewRowMarketing(String id, int age,
     * String sexe, int taux, String situationFamiliale, int nombreEnfants,
     * boolean deuxiemeVoiture)
     * Cette méthode insère une nouvelle ligne dans la table Marketing.
     */

    private void insertNewRowMarketing(
    		int age, String sexe, int taux, String situationFamiliale, 
    		int nombreEnfants, boolean deuxiemeVoiture, String immatriculation
    ) {
        StatementResult result = null;
        String statement = null;

        System.out.println("********************************** Dans : insertNewRowMarketing *********************************");

        try {

            TableAPI tableH = store.getTableAPI();
            // The name you give to getTable() must be identical
            // to the name that you gave the table when you created
            // the table using the CREATE TABLE DDL statement.
            Table tabClient = tableH.getTable(tableClient);
            // Get a Row instance
            Row clientRow = tabClient.createRow();
            // Now put all of the cells in the row. This does NOT actually write the data to
            // the store.

            // Generate uuid
            String uuid = java.util.UUID.randomUUID().toString();


            // Create one row
            clientRow.put("ID", uuid);
            clientRow.put("AGE", age);
            clientRow.put("SEXE", sexe);
            clientRow.put("TAUX", taux);
            clientRow.put("SITUATION_FAMILIALE", situationFamiliale);
            clientRow.put("NOMBRE_ENFANTS", nombreEnfants);
            clientRow.put("DEUXIEME_VOITURE", deuxiemeVoiture);
            clientRow.put("IMMATRICULATION", immatriculation);


            // Now write the table to the store.
            // "item" is the row's primary key. If we had not set that value,
            // this operation will throw an IllegalArgumentException.
            tableH.put(clientRow, null, null);

        } catch (IllegalArgumentException e) {
            System.out.println("Invalid statement:\n" + e.getMessage());
        } catch (FaultException e) {
            System.out.println("Statement couldn't be executed, please retry: " + e);
        }

    }

    /**
     * void loadClientDataFromFile(String clientDataFileName)
     * cette methode permet de charger les data marketings depuis le fichier
     * appelé marketing.csv
     * Pour chaque ligne chargée, la
     * méthode insertNewRowmarketing sera appelée
     */
    void loadClientDataFromFile(String clientDataFileName) {
        InputStreamReader ipsr;
        BufferedReader br = null;
        InputStream ips;

        // Variables pour stocker les données lues d'un fichier.
        String ligne;
        System.out.println("********************************** Dans : loadClientDataFromFile *********************************");

        /* parcourir les lignes du fichier texte et découper chaque ligne */
        try {
            ips = new FileInputStream(clientDataFileName);
            ipsr = new InputStreamReader(ips);
            br = new BufferedReader(ipsr);

            /* open text file to read data */

            // parcourir le fichier ligne par ligne et découper chaque ligne en
            // morceau séparé par le symbole ","
            while ((ligne = br.readLine()) != null) {
                ArrayList<String> clientRecord = new ArrayList<String>();
                StringTokenizer val = new StringTokenizer(ligne, ",");
                while (val.hasMoreTokens()) {
                    clientRecord.add(val.nextToken().toString());
                }
                System.out.println("clientRecord : " + clientRecord.toString());
                // skip the first line
                if (clientRecord.get(0).equals("age")) {
                    continue;
                }
                int age = Integer.parseInt(clientRecord.get(0));
                String sexe = clientRecord.get(1);
                int taux = Integer.parseInt(clientRecord.get(2));
                String situationFamiliale = clientRecord.get(3);
                int nombreEnfants = Integer.parseInt(clientRecord.get(4));
                boolean deuxiemeVoiture = Boolean.parseBoolean(clientRecord.get(5));
                String immatriculation = clientRecord.get(6);

                System.out.println("age=" + age + " sexe=" + sexe + " taux=" + taux 
                + " situationFamiliale=" + situationFamiliale + " nombreEnfants=" + nombreEnfants 
                + " deuxiemeVoiture=" + deuxiemeVoiture + " immatriculation=" + immatriculation);

                // Rajouter marketing dans le KVStore
                this.insertNewRowMarketing(age, sexe, taux, situationFamiliale, nombreEnfants,
                        deuxiemeVoiture, immatriculation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * private void displayClientRow(Row clientRow)
     * Cette méthode d'afficher une ligne de la table marketing.
     */
    private void displayClientRow(Row clientRow) {
        System.out.println("========== DANS : displayClientRow =================");

        String id = clientRow.get("ID").asString().get();
        Integer age = clientRow.get("AGE").asInteger().get();
        String sexe = clientRow.get("SEXE").asString().get();
        Integer taux = clientRow.get("TAUX").asInteger().get();
        String situationFamiliale = clientRow.get("SITUATION_FAMILIALE").asString().get();
        Integer nombreEnfants = clientRow.get("NOMBRE_ENFANTS").asInteger().get();
        Boolean deuxiemeVoiture = clientRow.get("DEUXIEME_VOITURE").asBoolean().get();
        String immatriculation = clientRow.get("IMMATRICULATION").asString().get();

        System.out.println("Marketing Row:{id=" + id + " age=" + age
                + " sexe=" + sexe + " taux=" + taux + " situationFamiliale=" + situationFamiliale
                + " nombreEnfants=" + nombreEnfants + " deuxiemeVoiture=" + deuxiemeVoiture 
                + " immatriculation=" + immatriculation + "}");
    }

    /**
     * public void getClientByKey(String clientId)
     * Cette méthode permet de charger une ligne de la table marketing
     * connaissant sa clé
     */
    public void getClientByKey(String clientId) {
        StatementResult result = null;
        String statement = null;

        System.out.println("\n\n********************************** Dans : getClientByKey *********************************");

        try {
            TableAPI tableH = store.getTableAPI();
            // The name you give to getTable() must be identical
            // to the name that you gave the table when you created
            // the table using the CREATE TABLE DDL statement.
            Table tabClient = tableH.getTable(tableClient);
            PrimaryKey key = tabClient.createPrimaryKey();
            key.put("id", clientId);

            // Retrieve the row. This performs a store read operation.
            // Exception handling is skipped for this trivial example.
            Row row = tableH.get(key, null);

            // Now retrieve the individual fields from the row.
            displayClientRow(row);

        } catch (IllegalArgumentException e) {
            System.out.println("Invalid statement:\n" + e.getMessage());
        } catch (FaultException e) {
            System.out.println("Statement couldn't be executed, please retry: " + e);
        }

    }

    /**
     * public void getClientRows()
     * Cette méthode permet de charger toutes les lignes de la table marketing
     * connaissant sa clé
     */
    public void getClientRows() {
        StatementResult result = null;
        String statement = null;
        System.out.println("******************************** LISTING DES CLIENTS ******************************************* ");

        try {
            TableAPI tableH = store.getTableAPI();
            // The name you give to getTable() must be identical
            // to the name that you gave the table when you created
            // the table using the CREATE TABLE DDL statement.
            Table tabClient = tableH.getTable(tableClient);
            PrimaryKey key = tabClient.createPrimaryKey();

            // Exception handling is omitted, but in production code
            // ConsistencyException, RequestTimeException, and FaultException
            // would have to be handle
            TableIterator<Row> iter = tableH.tableIterator(key, null, null);
            try {
                while (iter.hasNext()) {
                    Row clientRow = iter.next();
                    displayClientRow(clientRow);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (iter != null) {
                    iter.close();
                }
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Invalid statement:\n" + e.getMessage());
        } catch (FaultException e) {
            System.out.println("Statement couldn't be executed, please retry: " + e);
        }
    }
}
