    # @parallel=false
    # @debug
Feature: Articles
    Background: Define URL
      Given url 'https://conduit-api.bondaracademy.com/api/'
    #   * url apiUrl
    #   * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    #   * def dataGenerator = Java.type('helpers.DataGenerator')
    #   * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    #   * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    #   * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

        # Given path 'users/login'   // at #15.1 move next 5 lines to CreateToken.feature                    
        # And request {"user":{"email":"karateTest64@test.com","password":"vd1234567"}}    
        # When method Post
        # Then status 200
        # * def token = response.user.token                              // #15.2 line bellow
      * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email":"karateTest64@test.com","password":"vd1234567"}
      * def token = tokenResponse.authToken       // #15.2
      
      # @ignore
    Scenario: Create a new article                                       // at #14 delete article put on @ignore
      Given header Authorization = 'Token ' + token           // #12
      Given path 'articles'
      # And request articleRequestBody
      And request {"article": {"title": "Trying testing API","description": "Very new to me","body": "empty body","tagList": []}}
      When method Post
      Then status 201        And match response.article.description == 'Very new to me'
      And match response.article.title == 'Trying testing API'     // #12
      # And match response.article.title == articleRequestBody.article.title
    @debug
  Scenario: Create and delete new article                           // #14
      Given header Authorization = 'Token ' + token       
      Given path 'articles'
      # And request articleRequestBody
      And request {"article":{"title":"Delete Article","description":"Very new to me","body":"empty body","tagList":[]}}
      When method Post
      Then status 201
      * def articleSlugId = response.article.slug
      * print 'Slug title is: ' + articleSlugId
      
      Given header Authorization = 'Token ' + token               // #14
      # Given params { limit: 10, offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      * print 'Article Title is: ' + response.articles[0].title
      And match response.articles[0].title == 'Delete Article' 
    #   And match response.articles[0].title == articleRequestBody.article.title    
         

      Given header Authorization = 'Token ' + token           // #14
      Given path 'articles',articleSlugId
      When method Delete
      Then status 204

    #   Given params { limit: 10, offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      And match response.articles[0].title != 'Delete Article'
    #   And match response.articles[0].title != articleRequestBody.article.title
      