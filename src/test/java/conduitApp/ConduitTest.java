package conduitApp;

import com.intuit.karate.junit5.*;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

class ConduitTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

    // @Test
    // void testParallel() {
    //     Results results = Runner.path("classpath:conduitApp")
    //     // Results results = Runner.path("classpath:conduitApp/feature")
    //             // .outputCucumberJson(true)
    //             .parallel(5);
    //     assertEquals(0, results.getFailCount(), results.getErrorMessages());
    //     // generateReport(results.getReportDir());
    //     // assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    // }

    // public static void generateReport(String karateOutputPath) {
    // Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath),
    // new String[] { "json" }, true);
    // List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
    // jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
    // Configuration config = new Configuration(new File("target"), "conduitApp");
    // ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
    // reportBuilder.generateReports();
    // }
}
