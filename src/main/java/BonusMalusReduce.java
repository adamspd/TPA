import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.Map;

public class BonusMalusReduce extends Reducer<Text, Text, Text, Text> {
    // La fonction REDUCE elle-même. Les arguments : la clef key (d'un type générique K), un Iterable de toutes les valeurs
    // qui sont associées à la clef en question et le contexte Hadoop (un handle qui nous permet de renvoyer le résultat à Hadoop).

    private final Map<String, Double> bonusMalusSum = new HashMap<>();
    private final Map<String, Integer> bonusMalusCount = new HashMap<>();
    private final Map<String, Double> emissionsSum = new HashMap<>();
    private final Map<String, Integer> emissionsCount = new HashMap<>();
    private double totalSum = 0.0;
    private int totalCount = 0;
    private final NumberFormat formatter = new DecimalFormat("#0.00");


    public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
        // Pour parcourir toutes les valeurs associées à la clef fournie.

        String brand = key.toString();

        for (Text value : values) {
            String[] fields = value.toString().split(",");
            double bonusMalusValue;
            double emissionsValue = 0;
            if (fields.length > 1) {
                if (fields[0] != null && !fields[0].isEmpty()) {
                    String bmv = fields[0];
                    // remove all non-digit characters except for -
                    bmv = bmv.replaceAll("[^\\d-]", "");
                    try {
                        bonusMalusValue = Double.parseDouble(bmv);
                    } catch (NumberFormatException e) {
                        bonusMalusValue = 0;
                    }

                    bonusMalusSum.put(brand, bonusMalusSum.getOrDefault(brand, 0.0) + bonusMalusValue);
                    bonusMalusCount.put(brand, bonusMalusCount.getOrDefault(brand, 0) + 1);
                    totalSum += bonusMalusValue;
                    totalCount++;
                }

                if (fields[1] != null && !fields[1].isEmpty()) {
                    emissionsValue = Double.parseDouble(fields[1]);
                    emissionsSum.put(brand, emissionsSum.getOrDefault(brand, 0.0) + emissionsValue);
                    emissionsCount.put(brand, emissionsCount.getOrDefault(brand, 0) + 1);
                }
            }
        }
    }

    @Override
    protected void cleanup(Context context) throws IOException, InterruptedException {
        //calculate the average bonus malus per car brand
        for (Map.Entry<String, Double> entry : bonusMalusSum.entrySet()) {
            String brand = entry.getKey();
            double sum = entry.getValue();
            int count = bonusMalusCount.get(brand);
            double average = sum / count;
            context.write(new Text(brand), new Text("Bonus Malus: " + formatter.format(average)));
        }
        //calculate the total average bonus malus
        double totalAverage = totalSum / totalCount;
        context.write(new Text("Total"), new Text(" Average Bonus Malus: " + formatter.format(totalAverage)));

        //calculate the average emissions per car brand
        for (Map.Entry<String, Double> entry : emissionsSum.entrySet()) {
            String brand = entry.getKey();
            double sum = entry.getValue();
            int count = emissionsCount.get(brand);
            double average = sum / count;
            context.write(new Text(brand), new Text("Average Emissions: " + formatter.format(average)));
        }
    }
}
