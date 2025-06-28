@parallel=false
Feature: Articles
    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
    #   * url apiUrl
    #   * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    #   * def dataGenerator = Java.type('helpers.DataGenerator')
    #   * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    #   * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    #   * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

        Given path 'users/login'  // #12 moved up from 'create a new article' //# move to CreateToken.feature                    
        And request {"user":{"email":"karateTest64@test.com","password":"vd1234567"}}    
        When method Post
        Then status 200 
        * def token = response.user.token
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') //#16
        # * def token = tokenResponse.authToken

    Scenario: Create a new article
        Given header Authorization = 'Token ' + token           // #12
        Given path 'articles'
        # And request articleRequestBody
        And request {"article": {"title": "gchgcnb nvnvjh","description": "ghcgfddn","body": "jvhgrs","tagList": []}}
        When method Post
        Then status 201
        And match response.article.description == 'ghcgfddn'
        And match response.article.title == 'gchgcnb nvnvjh'     // #12
        # And match response.article.title == articleRequestBody.article.title

#   Scenario: Create and delete new article
#       Given header Authorization = 'Token ' + token       // #16
#       Given path 'articles'
#       And request articleRequestBody
#       # And request {"article":{"title":"Delete Article","description":"testing today","body":"do da","tagList":[]}}
#       When method Post
#       Then status 201
#       * def articleSlugId = response.article.slug
#       # * print 'Slug title is ' + articleSlugId
      
#       Given header Authorization = 'Token ' + token //#16
#       # Given params { limit: 10, offset: 0 }
#       Given path 'articles'
#       When method Get
#       Then status 200
#       * print 'ArticleTitle is ' + response.articles[0].title
#       And match response.articles[0].title == articleRequestBody.article.title    
#       # And match response.articles[0].title == 'Delete Article'    

#       Given header Authorization = 'Token ' + token //#16
#       Given path 'articles',articleSlugId
#       When method Delete
#       Then status 204

#       # Given params { limit: 10, offset: 0 }
#       Given path 'articles'
#       When method Get
#       Then status 200
#       And match response.articles[0].title != articleRequestBody.article.title
#       And match response.articles[0].title != 'Delete Article'