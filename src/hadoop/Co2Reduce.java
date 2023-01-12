import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;
import java.util.Iterator;

public class Co2Reduce extends Reducer<Text, Text, Text, Text> {
    // La fonction REDUCE elle-même. Les arguments: la clef key (d'un type générique K), un Iterable de toutes les valeurs
    // qui sont associées à la clef en question, et le contexte Hadoop (un handle qui nous permet de renvoyer le résultat à Hadoop).
    public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
        // Pour parcourir toutes les valeurs associées à la clef fournie.
        for (Text value : values) {
            context.write(key, value);
        }
    }
}
