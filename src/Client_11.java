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

public class Clients_11 {
    private final KVStore store;
    private final String dataPath = "/home/ubuntu/tpa/files/csv/";
    private final String myFile = "Clients_11.csv";
    private final String tableClient = "CLIENT_SOPHIA2223_TPA_GROUPE_4";

    /**
     * Runs the DDL command line program.
     */
    public static void main(String[] args) {
        try {
            Clients_11 client = new Clients_11(args);
            client.initClientTablesAndData(client);

            // marketing.getClientByKey("4231 HC 31");

            // client.getClientRows();

        } catch (RuntimeException e) {
            e.printStackTrace();
        }
    }

    public Clients_11(String[] argv) {

        String storeName = "kvstore";
        String hostName = "localhost";
        String hostPort = "5000";

        final int nArgs = argv.length;
        int argc = 0;
        store = KVStoreFactory.getStore
                (new KVStoreConfig(storeName, hostName + ":" + hostPort));
    }

    /**
     * Affichage du résultat pour les commandes DDL (CREATE, ALTER, DROP)
     */

    private void displayResult(StatementResult result, String statement) {
        System.out.println("===========================");
        if (result.isSuccessful()) {
            System.out.println("Statement was successful:\n\t" +
                    statement);
            System.out.println("Results:\n\t" + result.getInfo());
        } else if (result.isCancelled()) {
            System.out.println("Statement was cancelled:\n\t" +
                    statement);
        } else {
            /**
             * statement was not successful: may be in error, or may still
             * be in progress.
             */
            if (result.isDone()) {
                System.out.println("Statement failed:\n\t" + statement);
                System.out.println("Problem:\n\t" +
                        result.getErrorMessage());
            } else {

                System.out.println("Statement in progress:\n\t" +
                        statement);
                System.out.println("Status:\n\t" + result.getInfo());
            }
        }
    }

    /**
     * public void executeDDL(String statement)
     * méthode générique pour exécuter les commandes DDL
     */
    public void executeDDL(String statement) {
        TableAPI tableAPI = store.getTableAPI();
        StatementResult result = null;

        System.out.println("****** Dans : executeDDL ********");
        try {
            /**
             * Add a table to the database.
             * Execute this statement asynchronously.
             */

            result = store.executeSync(statement);
            displayResult(result, statement);
        } catch (IllegalArgumentException e) {
            System.out.println("Invalid statement:\n" + e.getMessage());
        } catch (FaultException e) {
            System.out.println("Statement couldn't be executed, please retry: " + e);
        }
    }


    /**
     * La méthode initClientTablesAndData permet :
     * - de supprimer les tables si elles existent
     * - de créer des tables
     * - Insérer des critères
     * - et charger les datas de marketing
     **/

    public void initClientTablesAndData(Clients_11 client) {
        client.dropTable();
        client.createTableClient();
        // immatriculations.insertImmRows();
        client.loadClientDataFromFile(dataPath + myFile);
    }

    /**
     * public void dropTableMarketing()
     * Methode de suppression de la table Marketing.
     */
    public void dropTable() {
        String statement = null;

        statement = "drop table " + tableClient;
        executeDDL(statement);
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
        executeDDL(statement);
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
                // clean age before parsing, if age is empty, set it to 0
                int age = -999;
                if (!clientRecord.get(0).equals("")) {
                    age = Integer.parseInt(clientRecord.get(0));
                }

                /**
                 * clean sexe before parsing, if sexe is empty, set it to "Not defined"
                 * if sexe is "Masculin", set it to "M",if sexe is "Feminin", set it to "F"
                 * if sexe is "Homme", set it to "M",if sexe is "Femme", set it to "F"
                 */

                String sexe = "Not defined";
                if (!clientRecord.get(1).equals("")) {
                    if (clientRecord.get(1).equals("Masculin")) {
                        sexe = "M";
                    } else if (clientRecord.get(1).equals("Feminin")) {
                        sexe = "F";
                    } else if (clientRecord.get(1).equals("Homme")) {
                        sexe = "M";
                    } else if (clientRecord.get(1).equals("Femme")) {
                        sexe = "F";
                    } else {
                        sexe = clientRecord.get(1);
                    }
                }
                int taux = -999;
                if (!clientRecord.get(2).equals("")) {
                    taux = Integer.parseInt(clientRecord.get(2));
                }
                /**
                 * if situationFamiliale is empty, set it to "Not defined"
                 * if situationFamiliale is "Célibataire", set it to "Celibataire"
                 * if situationFamiliale is "Marié(e)", set it to "Marie(e)"
                 * if situationFamiliale is "Divorcé(e)", set it to "Divorce(e)"
                 * if situationFamiliale is "Seul" or "Seule", set it to "Celibataire"
                 * if situationFamiliale is "Marié" or "Mariée", set it to "Marie(e)"
                 * if situationFamiliale is "Divorcé" or "Divorcée", set it to "Divorce(e)"
                 * if situationFamiliale is "Couple" and not "En couple" set it to "En couple"
                 */
                String situationFamiliale = "Not defined";
                if (!clientRecord.get(3).equals("")) {
                    if (clientRecord.get(3).equals("Célibataire")) {
                        situationFamiliale = "Celibataire";
                    } else if (clientRecord.get(3).equals("Marié(e)")) {
                        situationFamiliale = "Marie(e)";
                    } else if (clientRecord.get(3).equals("Divorcé(e)")) {
                        situationFamiliale = "Divorce(e)";
                    } else if (clientRecord.get(3).equals("Seul")) {
                        situationFamiliale = "Celibataire";
                    } else if (clientRecord.get(3).equals("Seule")) {
                        situationFamiliale = "Celibataire";
                    } else if (clientRecord.get(3).equals("Marié")) {
                        situationFamiliale = "Marie(e)";
                    } else if (clientRecord.get(3).equals("Mariée")) {
                        situationFamiliale = "Marie(e)";
                    } else if (clientRecord.get(3).equals("Divorcé")) {
                        situationFamiliale = "Divorce(e)";
                    } else if (clientRecord.get(3).equals("Divorcée")) {
                        situationFamiliale = "Divorce(e)";
                    } else if (clientRecord.get(3).equals("Couple")) {
                        situationFamiliale = "En couple";
                    } else {
                        situationFamiliale = clientRecord.get(3);
                    }
                }
                int nombreEnfants = -999;
                if (!clientRecord.get(4).equals("")) {
                    nombreEnfants = Integer.parseInt(clientRecord.get(4));
                }

                boolean deuxiemeVoiture = false;
                if (!clientRecord.get(5).equals("")) {
                    if (clientRecord.get(5).equals("true")) {
                        deuxiemeVoiture = true;
                    } else {
                        deuxiemeVoiture = false;
                    }
                }
                // if immatriculation is empty, set it to ""
                // replace in between spaces by "-"
                // don't add "-" at the beginning or at the end of the string
                String immatriculation = "Not defined";
                if (!clientRecord.get(6).equals("")) {
                    immatriculation = clientRecord.get(6).replaceAll("\\s+", "-");
                    if (immatriculation.startsWith("-")) {
                        immatriculation = immatriculation.substring(1);
                    }
                    if (immatriculation.endsWith("-")) {
                        immatriculation = immatriculation.substring(0, immatriculation.length() - 1);
                    }
                }

                System.out.println("age=" + age + " sexe=" + sexe + " taux=" + taux
                        + " situationFamiliale=" + situationFamiliale + " nombreEnfants=" + nombreEnfants
                        + " deuxiemeVoiture=" + deuxiemeVoiture + " immatriculation=" + immatriculation);

                // Rajouter marketing dans le KVStore
                this.insertNewRowClient(age, sexe, taux, situationFamiliale, nombreEnfants,
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
