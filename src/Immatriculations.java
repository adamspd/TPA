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

public class Immatriculations {
    private final KVStore store;
    private final String dataPath = "/home/PIERREDAVID/projet_tpa/data/";
    private final String myFile = "Immatriculations.csv";
    private final String tableImmatriculations = "IMMATRICULATIONS_SOPHIA2223_TPA_GROUPE_4";

    /**
     * Runs the DDL command line program.
     */
    public static void main(String[] args) {
        try {
            Immatriculations immatriculations = new Immatriculations(args);
            immatriculations.initImmatriculationsTablesAndData(immatriculations);

            immatriculations.getImmatriculationByKey(1);

            immatriculations.getImmatriculationRows();

        } catch (RuntimeException e) {
            e.printStackTrace();
        }
    }

    Immatriculations(String[] argv) {

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
            /*
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
            /*
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
    
    /*
		La méthode initImmatriculationsTablesAndData permet :
		- de supprimer les tables si elles existent
		- de créer des tables
		- Insérer des critères
		- et charger les immatriculations et les appréciations
	**/

    public void initImmatriculationsTablesAndData(Immatriculations immatriculations) {
        immatriculations.dropTableImmatriculations();
        immatriculations.createTableImmatriculations();
        // immatriculations.insertImmRows();
        immatriculations.loadImmatriculationsDataFromFile(dataPath + myFile);
    }

    /**
     * public void dropTableImmatriculations()
     * Methode de suppression de la table Immatriculations.
     */
    public void dropTableImmatriculations() {
        String statement = null;

        statement = "drop table " + tableImmatriculations;
        executeDDL(statement);
    }

    /**
     * public void createTableImmatriculations()
     * Methode de création de la table Immatriculations.
     */

    public void createTableImmatriculations() {
        String statement = null;
        statement = "create table " + tableImmatriculations + " ("
                + "IMMATRICULATION_ID INTEGER,"
                + "IMMATRICULATION STRING,"
                + "MARQUE STRING,"
                + "NOM STRING,"
                + "PUISSANCE INTEGER,"
                + "LONGUEUR  STRING,"
                + "NOMBRE_PLACE INTEGER,"
                + "NOMBRE_PORTE INTEGER,"
                + "COULEUR STRING,"
                + "OCCASION STRING,"
                + "PRIX INTEGER,"
                + "PRIMARY KEY(IMMATRICULATION_ID))";
        executeDDL(statement);
    }

    /**
     * private void insertNewRowImmatriculations(int immatriculationId, String immatriculation,
     * String marque, String nom, int puissance, String longueur,
     * int nombrePlace, int nombrePorte, String couleur,
     * String occasion, int prix)
     * Cette méthode insère une nouvelle ligne dans la table Immatriculations.
     */

    private void insertNewRowImmatriculations(int immatriculationId, String immatriculation,
                                              String marque, String nom, int puissance, String longueur,
                                              int nombrePlace, int nombrePorte, String couleur,
                                              String occasion, int prix) {
        StatementResult result = null;
        String statement = null;

        System.out.println("********************************** Dans : insertNewRowImmatriculations *********************************");

        try {

            TableAPI tableH = store.getTableAPI();
            // The name you give to getTable() must be identical
            // to the name that you gave the table when you created
            // the table using the CREATE TABLE DDL statement.
            Table tabImmatriculations = tableH.getTable(tableImmatriculations);
            // Get a Row instance
            Row immatriculationsRow = tabImmatriculations.createRow();
            // Now put all of the cells in the row.
            // This does NOT actually write the data to
            // the store.


            // Create one row
            immatriculationsRow.put("IMMATRICULATION_ID", immatriculationId);
            immatriculationsRow.put("IMMATRICULATION", immatriculation);
            immatriculationsRow.put("MARQUE", marque);
            immatriculationsRow.put("NOM", nom);
            immatriculationsRow.put("PUISSANCE", puissance);
            immatriculationsRow.put("LONGUEUR", longueur);
            immatriculationsRow.put("NOMBRE_PLACE", nombrePlace);
            immatriculationsRow.put("NOMBRE_PORTE", nombrePorte);
            immatriculationsRow.put("COULEUR", couleur);
            immatriculationsRow.put("OCCASION", occasion);
            immatriculationsRow.put("PRIX", prix);


            // Now write the table to the store.
            // "item" is the row's primary key. If we had not set that value,
            // this operation will throw an IllegalArgumentException.
            tableH.put(immatriculationsRow, null, null);

        } catch (IllegalArgumentException e) {
            System.out.println("Invalid statement:\n" + e.getMessage());
        } catch (FaultException e) {
            System.out.println("Statement couldn't be executed, please retry: " + e);
        }

    }

    /**
     * Void loadImmatriculationsDataFromFile(String immatriculationDataFileName)
     * cette methode permet de charger les immatriculations depuis le fichier
     * appelé immatriculation.csv
     * Pour chaque immatriculation chargée, la
     * méthode insertNewRowImmatriculations sera appelée
     */
    void loadImmatriculationsDataFromFile(String immatriculationDataFileName) {
        InputStreamReader ipsr;
        BufferedReader br = null;
        InputStream ips;

        // Variables pour stocker les données lues d'un fichier.
        String ligne;
        System.out.println("********************************** Dans : loadImmatriculationsDataFromFile *********************************");

        /* parcourir les lignes du fichier texte et découper chaque ligne */
        try {
            ips = new FileInputStream(immatriculationDataFileName);
            ipsr = new InputStreamReader(ips);
            br = new BufferedReader(ipsr);

            /* open text file to read data */

            // parcourir le fichier ligne par ligne et découper chaque ligne en
            // morceau séparé par le symbole ","
            while ((ligne = br.readLine()) != null) {
                ArrayList<String> immatriculationRecord = new ArrayList<String>();
                StringTokenizer val = new StringTokenizer(ligne, ",");
                while (val.hasMoreTokens()) {
                    immatriculationRecord.add(val.nextToken().toString());
                }
                int immatriculationId = Integer.parseInt(immatriculationRecord.get(0));
                String immatriculation = immatriculationRecord.get(1);
                String marque = immatriculationRecord.get(2);
                String nom = immatriculationRecord.get(3);
                int puissance = Integer.parseInt(immatriculationRecord.get(4));
                String longueur = immatriculationRecord.get(5);
                int nombrePlace = Integer.parseInt(immatriculationRecord.get(6));
                int nombrePorte = Integer.parseInt(immatriculationRecord.get(7));
                String couleur = immatriculationRecord.get(8);
                String occasion = immatriculationRecord.get(9);
                int prix = Integer.parseInt(immatriculationRecord.get(10));

                System.out.println("immatriculationId=" + immatriculationId + " immatriculation=" + immatriculation + " marque=" + marque
                        + " nom=" + nom + " puissance=" + puissance + " longueur=" + longueur
                        + " nombrePlace=" + nombrePlace + " nombrePorte=" + nombrePorte + " couleur=" + couleur
                        + " occasion=" + occasion + " prix=" + prix);

                // Rajouter l'immatriculation dans le KVStore
                this.insertNewRowImmatriculations(immatriculationId, immatriculation, marque, nom, puissance, longueur,
                        nombrePlace, nombrePorte, couleur, occasion, prix);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * private void displayImmatriculationRow (Row immatriculationRow)
     * Cette méthode d'afficher une ligne de la table immatriculation.
     */
    private void displayImmatriculationRow(Row immatriculationRow) {
        System.out.println("========== DANS : displayImmatriculationRow =================");

        Integer immatriculationId = immatriculationRow.get("IMMATRICULATION_ID").asInteger().get();
        String immatriculation = immatriculationRow.get("IMMATRICULATION").asString().get();
        String marque = immatriculationRow.get("MARQUE").asString().get();
        String nom = immatriculationRow.get("NOM").asString().get();
        Integer puissance = immatriculationRow.get("PUISSANCE").asInteger().get();
        String longueur = immatriculationRow.get("LONGUEUR").asString().get();
        Integer nombrePlace = immatriculationRow.get("NOMBRE_PLACE").asInteger().get();
        Integer nombrePorte = immatriculationRow.get("NOMBRE_PORTE").asInteger().get();
        String couleur = immatriculationRow.get("COULEUR").asString().get();
        String occasion = immatriculationRow.get("OCCASION").asString().get();
        Integer prix = immatriculationRow.get("PRIX").asInteger().get();

        System.out.println("Immatriculation Row:{immatriculationId=" + immatriculationId
                + " immatriculation=" + immatriculation + " marque=" + marque
                + " nom=" + nom + " puissance=" + puissance + " longueur=" + longueur
                + " nombrePlace=" + nombrePlace + " nombrePorte=" + nombrePorte + " couleur=" + couleur
                + " occasion=" + occasion + " prix=" + prix + "}");
    }

    /**
     * private void getImmatriculationByKey (int immatriculationId)
     * Cette méthode permet de charger une ligne de la table immatriculation
     * connaissant sa clé
     */
    public void getImmatriculationByKey(int immatriculationId) {
        StatementResult result = null;
        String statement = null;

        System.out.println("\n\n********************************** Dans : getImmatriculationByKey *********************************");

        try {
            TableAPI tableH = store.getTableAPI();
            // The name you give to getTable() must be identical
            // to the name that you gave the table when you created
            // the table using the CREATE TABLE DDL statement.
            Table tabImmatriculation = tableH.getTable(tableImmatriculations);
            PrimaryKey key = tabImmatriculation.createPrimaryKey();
            key.put("immatriculationId", immatriculationId);

            // Retrieve the row. This performs a store read operation.
            // Exception handling is skipped for this trivial example.
            Row row = tableH.get(key, null);

            // Now retrieve the individual fields from the row.
            displayImmatriculationRow(row);

        } catch (IllegalArgumentException e) {
            System.out.println("Invalid statement:\n" + e.getMessage());
        } catch (FaultException e) {
            System.out.println("Statement couldn't be executed, please retry: " + e);
        }

    }

    /**
     public void getImmatriculationRows()
     Cette méthode permet de charger toutes les lignes de la table immatriculation
     connaissant sa clé
     */
    public void getImmatriculationRows(){
        StatementResult result = null;
        String statement = null;
        System.out.println("******************************** LISTING DES CLIENTS ******************************************* ");

        try {
            TableAPI tableH = store.getTableAPI();
            // The name you give to getTable() must be identical
            // to the name that you gave the table when you created
            // the table using the CREATE TABLE DDL statement.
            Table tabImmatriculation = tableH.getTable(tableImmatriculations);
            PrimaryKey key = tabImmatriculation.createPrimaryKey();

            // Exception handling is omitted, but in production code
            // ConsistencyException, RequestTimeException, and FaultException
            // would have to be handle
            TableIterator<Row> iter = tableH.tableIterator(key, null, null);
            try {
                while (iter.hasNext()) {
                    Row immatriculationRow = iter.next();
                    displayImmatriculationRow(immatriculationRow);
                }
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            finally {
                if (iter != null) {
                    iter.close();
                }
            }
        }
        catch (IllegalArgumentException e) {
            System.out.println("Invalid statement:\n" + e.getMessage());
        }
        catch (FaultException e) {
            System.out.println("Statement couldn't be executed, please retry: " + e);
        }
    }
}
