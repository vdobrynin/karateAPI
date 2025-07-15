@parallel=false
# @debug
Feature: Articles
    Background: Define URL
        * url apiUrl
        # Given url apiUrl  // change declaration at #23 to above
        # Given url 'https://conduit-api.bondaracademy.com/api/'   // #16.1 replace url  
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json') // add at #23 next 5 lines below
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

        # Given path 'users/login'   // at #15.1 move next 5 lines to CreateToken.feature                    
        # And request {"user":{"email":"karateTest64@test.com","password":"vd1234567"}}    
        # When method Post
        # Then status 200
        # * def token = response.user.token                              // #15.2 line bellow // #16.1 delete for creating env in karate-config.js
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email":"karateTest64@test.com","password":"vd1234567"}
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') // #16.1 delete during create global token 
        # * def token = tokenResponse.authToken       // #15.2 & // #16.1 delete during create global token 
      
@ignore
# @skip
# @debug 
    Scenario: Create a new article                                       // at #14 delete article put on @ignore
        # Given header Authorization = 'Token ' + token           // #12 & // #16.1 delete during create global token 
        Given path 'articles'
        And request articleRequestBody  // change request at #23 from below
        # And request {"article": {"title": "Trying testing API","description": "Very new to me","body": "empty body","tagList": []}}
        When method Post
        Then status 201        
        # And match response.article.description == 'Very new to me' // comments at #23
        # And match response.article.title == 'Trying testing API'     // #12
        And match response.article.title == articleRequestBody.article.title // change at #23 from above

# @debug
  Scenario: Create and delete new article                           // #14
        # Given header Authorization = 'Token ' + token       // #16.1 delete during create global token 
        Given path 'articles'
        And request articleRequestBody                // change request at #23 from below
        # And request {"article":{"title":"Delete Article","description":"Very new to me","body":"empty body","tagList":[]}}
        When method Post
        Then status 201
        * def articleSlugId = response.article.slug
        # * print 'Slug title is: ' + articleSlugId
      
        # Given header Authorization = 'Token ' + token               // #14 & // #16.1 delete during create global token 
        # Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        # * print 'Article Title is: ' + response.articles[0].title
        # And match response.articles[0].title == 'Delete Article' 
        # And match response.articles[0].title == articleRequestBody.article.title    // change at #23 from above
         
        # Given header Authorization = 'Token ' + token           // #14 & // #16.1 delete during create global token 
        Given path 'articles',articleSlugId
        When method Delete
        Then status 204

        # Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        # And match response.articles[0].title != 'Delete Article'
        And match response.articles[0].title != articleRequestBody.article.title // change at #23 from above
      