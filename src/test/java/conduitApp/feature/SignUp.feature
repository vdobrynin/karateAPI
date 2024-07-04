@ignore
Feature: Sign Up new user

    Background: Preconditions
        Given url apiUrl
# @debug
    Scenario: New user Sign Up
        Given def userData = {"email":"karateQa3@test.com", "username": "karateQa3"}

        Given path 'users'
        # And request {"user":{"email": #('Test' + userData.email),"password":"vd12345678","username": #('User' + userData.username)}}
        And request
        """
            {
                "user": {
                    "email": #(userData.email),
                    "password": "vd12345678",
                    "username": #(userData.username)
                }
            }
        """
        When method Post
        Then status 201