Feature: Article
    Background: Define URL
        * url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
        * def articleRequestBody.article.description = getRandomArticleValues().Description
        # * set articleRequestBody.article.description = __gatling.Description
        * def articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

        # * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
        # * def pause = karate.get('__gatling.pause', sleep)

    Scenario: Create & Delete Article
        # * configure headers = {"Authorization": #('Token ' + __gatling.token)}
        Given path 'articles'
        And request articleRequestBody
        # And header karate-name = 'Create Article'
        When method Post
        Then status 200
        * def articleId = response.article.slug

        # * pause(5000)

        Given path 'articles',articleId
        When method Delete
        Then status 200