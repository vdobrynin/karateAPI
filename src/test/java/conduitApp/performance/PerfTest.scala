package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {
    
    val protocol = karateProtocol(
        "/api/articles/{articleId}" -> Nil
    )

    val createArticle = scenario("Create & Delete Article")
        .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))
        
    setUp(
        createArticle.inject(
            atOnceUsers(3),
            // nothingFor(4 seconds),
            // constantUsersPerSec(1) during (3 seconds),
            // constantUsersPerSec(2) during (10 seconds),
            // rampUsersPerSec(2) to 10 during (20 seconds),
            // nothingFor(5 seconds),
            // constantUsersPerSec(1) during (5 seconds)
            ).protocols(protocol)
        )
}

// import conduitApp.performance.createTokens.CreateTokens

// CreateTokens.createAccessTokens()

//   protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

//       val csvFeeder = csv("articles.csv").circular
//       val tokenFeeder = Iterator.continually(Map("token" -> CreateTokens.getNextToken))

//       .feed(csvFeeder)
//           .feed(tokenFeeder)