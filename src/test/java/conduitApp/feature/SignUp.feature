# @ignore
# @debug
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl

@debug
    Scenario: New user Sign Up
        # Given def userData = {"email":"karateQa3@test.com", "username": "karateQa3"} //#21
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()    

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
        When method Post
        Then status 201