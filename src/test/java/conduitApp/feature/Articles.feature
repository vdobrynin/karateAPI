
Feature: Articles

  Background: Define URL
      Given url apiUrl
      # Given path 'users/login'                                      //# move to CreateToken.feature
      # And request {"user":{"email":"karate4Tests64@tests.com","password":"vd123456789"}}    
      # When method Post
      # Then status 200        
      # * def token = response.user.token
      #   * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') //#16
      #   * def token = tokenResponse.authToken
  
  Scenario: To create a new article
      #   Given header Authorization = 'Token ' + token //#16
      Given path 'articles'
      And request {"article":{"title":"Holograms!1","description":"api testing","body":"go ga, for","tagList":[]}}
      When method Post
      Then status 201
      # And match response.article.description == 'do more api testing today'
      And match response.article.title == 'Holograms!1'
  # @debug 
  Scenario: Create and delete new article
      #   Given header Authorization = 'Token ' + token //#16
      Given path 'articles'
      And request {"article":{"title":"Delete Article","description":"testing today","body":"do da","tagList":[]}}
      When method Post
      Then status 201
      * print 'Slug title is ' + response.article.slug
      * def articleId = response.article.slug
      
    #   Given header Authorization = 'Token ' + token //#16
      Given params { limit: 10, offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      * print 'ArticleTitle is ' + response.articles[0].title
      And match response.articles[0].title == 'Delete Article'    

      #   Given header Authorization = 'Token ' + token //#16
      Given path 'articles',articleId
      When method Delete
      Then status 204

      Given params { limit: 10, offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      And match response.articles[0].title != 'Delete Article'