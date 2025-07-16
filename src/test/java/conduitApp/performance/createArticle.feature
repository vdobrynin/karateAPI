Feature: Articles
    Background: Define URL
        * url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = __gatling.Title       // #40 change at
        * set articleRequestBody.article.description = __gatling.Description  // #40 change at
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

        * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
        * def pause = karate.get('__gatling.pause', sleep)

    Scenario: Create & Delete Article
        * configure headers = {"Authorization": #('Token ' + __gatling.token)}
        Given path 'articles'
        And request articleRequestBody
        And header karate-name = 'Title requested: ' + __gatling.Title
        # And header karate-name = 'Create Article: '
        When method Post
        Then status 200
        * def articleId = response.article.slug
                            # //           // #40 commenting temp
        * pause(5000)                     
                            # //           // #40 commenting temp
        Given path 'articles',articleId   
        When method Delete
        Then status 200