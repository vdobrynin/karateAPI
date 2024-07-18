package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbHandler {

    private static String connectionUrl = "jdbc:sqlserver://localhost:14330;database=Pubs;user=sa;password=PaSSw0rd";

    public static void addNewJobWithName(String jobName) {
        try (Connection connect = DriverManager.getConnection(connectionUrl)) {
            connect.createStatement()
                    .execute("INSERT INTO [Pubs].[dbo].[jobs] (job_desc, min_lvl, max_lvl) VALUES ('QA2',50, 100)");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
