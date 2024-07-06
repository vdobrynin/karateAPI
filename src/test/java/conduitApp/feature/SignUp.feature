
@debug
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()    
        * url apiUrl
#@debug
    Scenario: New user Sign Up
        # Given def userData = {"email":"karateQa3@test.com", "username": "karateQa3"}      //#21 
                                                    # to create Jav class instance need to create JS function
        # * def jsFunction =
        # """
        #     function() {
        #         var DataGenerator = Java.type('helpers.DataGenerator')
        #         var generator = new DataGenerator()
        #         return generator.getRandomUsername2()
        #     }
        # """
        # * def randomUsername2 = call jsFunction
    
        Given path 'users'
        # And request {"user":{"email": #('Test' + userData.email),"password":"vd12345678","username": #('User' + userData.username)}}
        And request
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "vd12345678",
                    "username": #(randomUsername)
                }
            }
        """
       # "username": #(randomUsername2)

        When method Post
        Then status 201
        And match response ==
        """
            {
                "user": {
                    "id": '#number',
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": '##string',
                    "image": '#string',
                    "token": '#string'
                }
            }
        """
            # "body": '#string',            //# extra fields if needed
            # "tagList": '#array',
            #  "createdAt": '#? timeValidator(_)',
            #  "updatedAt": '#? timeValidator(_)',
        # "username": #(randomUsername2)

# @debug
@parallel=false    
Scenario Outline: Validate Sign Up error messages
    Given path 'users'
    And request
    """
        {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
            }
        }
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples: 
        | email                | password | username              | errorResponse                                                                    |           
        | #(randomEmail)       | karate101| karateUser101         | {"errors":{"username":["has already been taken"]}}                               |
        | karateUser1@test.com | karate101| #(randomUsername)     | {"errors":{"email":["has already been taken"]}}                                  |
        # | karateUser1          | karate101| #(randomUsername)     | {"errors":{"email":["is invalid"]}}                                  |
        | karateUser111        | karate101| #(randomUsername)     | {"errors":{"email":["has already been taken"]}}                                  |
        # | #(randomEmail)       | karate101| karateUser101010101012| {"errors":{"username":["is too long (maximum is 20 characters)"]}}   |
        | #(randomEmail)       | karate101| karateUser101010101012| {"errors":{"username":["has already been taken"]}}                               |
        # | #(randomEmail)       | kar      | #(randomUsername)     | {"errors":{"password":["is too short (minimum is 8 characters)"]}}   |
        |                      | karate101| #(randomUsername)     | {"errors":{"email":["can't be blank"]}}                                          |
        | #(randomEmail)       |          | #(randomUsername)     | {"errors":{"password":["can't be blank"]}}                                       |
        # | #(randomEmail)       | karate101|                       | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}}|