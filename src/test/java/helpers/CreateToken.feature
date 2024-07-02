
Feature: Create Token

    Scenario: Create Token
        Given url 'https://conduit-api.bondaracademy.com/api/'
        Given path 'users/login'        
        And request {"user":{"email":"karate4Tests64@tests.com","password":"vd123456789"}}    
        When method Post
        Then status 200        
        * def authToken = response.user.token