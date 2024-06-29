@parallel=false
Feature: Articles

  Background: Define URL
      Given url 'https://conduit-api.bondaracademy.com/api/'
  Scenario: Create a new article
      Given path 'users/login'
      And request {"user":{"email":"karate4Tests64@tests.com","password":"vd123456789"}}    
      When method Post
      Then status 200
      * def token = response.user.token

      Given header Authorization = 'Token ' + token
      Given path 'articles'
      And request {"article":{"title":"Join Me on a Journey with the Three Plus Three New Holograms!!","description":"do more api testing today","body":"do da, go ga, for ","tagList":[]}}
      When method Post
      Then status 201
      # And match response.article.description == 'do more api testing today'
      And match response.article.title == 'Join Me on a Journey with the Three Plus Three New Holograms!!'