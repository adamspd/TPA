import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import com.opencsv.CSVParser;

import java.io.IOException;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BonusMalusMap extends Mapper<Object, Text, Text, Text> {
    // generate a regex pattern to match the input -6 000€ 1
    private static final Pattern BONUS_MALUS_PATTERN = Pattern.compile("(-?\\+?\\d*\\s\\d*)€");
    String fixer = "-6 000€ 1";

    // La fonction MAP elle-même.
    protected void map(Object key, Text value, Context context) throws IOException, InterruptedException {
        // Un StringTokenizer va nous permettre de parcourir chacun des mots de la ligne qui est passée
        // à notre opération MAP.
        // Skip the first line

        CSVParser parser = new CSVParser();
        String[] fields = parser.parseLine(value.toString());
        String brand = fields[1];
        String bonusMalus = fields[2];
        String emissions = fields[3];
        // compile the pattern
        Matcher matcher = Pattern.compile("(\\+?)(\\d+\\s\\d+)€").matcher(bonusMalus);

        if (Objects.equals(bonusMalus, fixer)) {
            bonusMalus = "-6000";
            fields[2] = bonusMalus;
        } else if (matcher.find()) {
            // bonusMalus = group(1);
            bonusMalus = matcher.group(2);
            fields[2] = bonusMalus;
        } else {
            // remmove the + sign
            bonusMalus = bonusMalus.replaceAll("\\+", "");
            // remove the € sign
            bonusMalus = bonusMalus.replaceAll("€", "");
            // remove the in between spaces
            bonusMalus = bonusMalus.replaceAll("\\s", "");

        }

        if (Objects.equals(brand, "Marque / Modele")) {
            return;
        }
        context.write(new Text(brand), new Text(bonusMalus + "," + emissions));
    }
}
