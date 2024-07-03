
Feature: Sign Up new user

    Background: Preconditions
        Given url apiUrl
@debug
    Scenario: New user Sign Up
        Given def userData = {"email":"karateQa14@test.com", "username": "karateQa14"}

        Given path 'users'
        And request {"user":{"email": #('Test' + userData.email),"password":"vd12345678","username": #('User' + userData.username)}}
        When method Post
        Then status 201