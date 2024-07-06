# @ignore
# @debug
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        * url apiUrl

@debug
    Scenario: New user Sign Up
        # Given def userData = {"email":"karateQa3@test.com", "username": "karateQa3"} //#21
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()    

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

        # "username": #(randomUsername2),