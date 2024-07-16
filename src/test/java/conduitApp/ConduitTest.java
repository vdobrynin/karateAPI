package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.*;
import org.junit.jupiter.api.Test;
import org.apache.commons.io.FileUtils;

import static org.junit.jupiter.api.Assertions.*;

class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp")
                .outputCucumberJson(true) // // #28
                .parallel(5);
        generateReport(results.getReportDir()); // // #28
        assertTrue(results.getFailCount() == 0, results.getErrorMessages()); // // #28
        // assertEquals(0, results.getFailCount(), results.getErrorMessages()); // //
        // #28
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "conduitApp");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}