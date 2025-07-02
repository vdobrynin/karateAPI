package helpers;

import com.github.javafaker.*;
import net.minidev.json.JSONObject;

public class DataGenerator {                            // #21
    public static String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUsername() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    // public String getRandomUsername2() {    // #21.2 for using 'non-static' method with JS
    //     Faker faker = new Faker();
    //     String username = faker.name().username();
    //     return username;
    // }

    public static JSONObject getRandomArticleValues() {
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }
}
