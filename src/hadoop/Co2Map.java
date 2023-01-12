import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Co2Map extends Mapper<Object, Text, Text, Text> {
    private static final Pattern BONUS_MALUS_PATTERN = Pattern.compile("(-?[0-9]+)€1");

    // La fonction MAP elle-même.
    protected void map(Object key, Text value, Context context) throws IOException, InterruptedException {
        // Un StringTokenizer va nous permettre de parcourir chacun des mots de la ligne qui est passée
        // à notre opération MAP.
        String[] fields = value.toString().split(";");
        String bonusMalus = fields[2];

        Matcher matcher = BONUS_MALUS_PATTERN.matcher(bonusMalus);
        if (matcher.matches()) {
            bonusMalus = matcher.group(1) + "€";
            fields[2] = bonusMalus;
        }

        String fixedLine = String.join(";", fields);
        context.write(new Text(key.toString()), new Text(fixedLine));
    }
}
