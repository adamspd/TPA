import oracle.kv.StatementResult;
import oracle.kv.table.TableAPI;
import oracle.kv.FaultException;

public class SqlUtils {
    private SqlUtils() {}

    /**
     * Affichage du résultat pour les commandes DDL (CREATE, ALTER, DROP)
     */
	public static void displayResult(StatementResult result, String statement) {
        System.out.println("===========================");
        if (result.isSuccessful()) {
            System.out.println("Statement was successful:\n\t" + statement);
            System.out.println("Results:\n\t" + result.getInfo());
        } else if (result.isCancelled()) {
            System.out.println("Statement was cancelled:\n\t" + statement);
        } else {
            /**
             * statement was not successful: may be in error, or may still
             * be in progress.
             */
            if (result.isDone()) {
                System.out.println("Statement failed:\n\t" + statement);
                System.out.println("Problem:\n\t" + result.getErrorMessage());
            } else {

                System.out.println("Statement in progress:\n\t" + statement);
                System.out.println("Status:\n\t" + result.getInfo());
            }
        }
    }
	
	/**
     * public void executeDDL(String statement)
     * méthode générique pour exécuter les commandes DDL
     */
    public static void executeDDL(String statement, KVStore store) {
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
     * public void dropTable()
     * Methode de suppression d'une table.
     */
    public static void dropTable(String tableName, KVStore store) {
        String statement = null;

        statement = "drop table " + tableName;
        executeDDL(statement, store);
    }
}
