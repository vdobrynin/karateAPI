# @parallel=false
# @ignore
# @debug    
Feature: Sign Up new user
    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')            // #21
        * def timeValidator = read('classpath:helpers/timeValidator.js')    // #21.1
        * def randomEmail = dataGenerator.getRandomEmail()                  // at #22.3 move from 'New user Sign Up' & more
        * def randomUsername = dataGenerator.getRandomUsername()            // at #22.3 move from 'New user Sign Up' & more
        Given url apiUrl
# @debug
    Scenario: New user Sign Up                
                                        #// next line #17.2 & #17.3 declare a json object & users should not uniq
        # Given def userData = {"email":"karateTest83@test.com", "username": "karateTest83"}  // then commenting at #21 
        # * def randomEmail = dataGenerator.getRandomEmail()                  // #21  // at #22.3 move to 'Background'
        # * def randomUsername = dataGenerator.getRandomUsername()            // #21  // at #22.3 move to 'Background'
            # // need only for JS    # // #21.2 need to create instance JavaScript function to call non-static method from dataGen...
        # * def jsFunction =
        # """
        # function() {
        #         var DataGenerator = Java.type('helpers.DataGenerator')
        #         var generator = new DataGenerator()
        #         return generator.getRandomUsername2()
        #     }
        # """
        #                                             # // #21.2 define for non-static JS function line below to call above
        # * def randomUsername2 = call jsFunction    

        Given path 'users'
        # * print randomEmail         // #24
        # * print randomUsername
        # And request {"user":{"email": #('Test' + userData.email),"password":"vd1234554321","username": #('User' + userData.username)}} // #17.3 comment to have json below
        # And request {"user":{"email": #(userData.email),"password":"vd1234554321","username": #(userData.username)}} // #17.2
        # And request {"user":{"email": "karateTest73@test.com","password":"vd1234554321","username": "karateTest73"}} // #17.1
                    # // #17.3 use JSON below, better than above (don't put comments at lin below, cause it's belong to JSON)
                                                    # //"email": #(userData.email),
                                                    # //"password": "vd1234554321",
                                                    # //"username": #(userData.username)
                    # // #21 change to random below (above original)
        And request                                                 
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "vd1234554321",
                    "username": #(randomUsername)
                }
            }
        """ 
        When method Post
        Then status 201 
                            # // #21.1 assertion
        And match response ==
        """
            {
                "user": {
                    "id": '#number',
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image": '#string',
                    "token": '#string'
                }
            }
        """
    #                    # // #21.2 for randomUsername2 for jsFunction 'ONLY' with commenting randomUsername request & response
        # And request                                                 
        # """
        #     {
        #         "user": {
        #             "email": #(randomEmail),
        #             "password": "vd1234554321",
        #             "username": #(randomUsername2)
        #         }
        #     }
        # """
        # When method Post
        # Then status 201 
        #                          # // #21.2 for randomUsername2   
        # And match response ==
        # """
        #     {
        #         "user": {
        #             "id": '#number',
        #             "email": #(randomEmail),
        #             "username": #(randomUsername2),
        #             "bio": null,
        #             "image": '#string',
        #             "token": '#string'
        #         }
        #     }
        # """

            # "body": '#string',            //# extra fields if needed
            # "tagList": '#array',
            #  "createdAt": '#? timeValidator(_)',
            #  "updatedAt": '#? timeValidator(_)',
        # "username": #(randomUsername2)
@debug
    # Scenario: Validate Sign Up error messages                // #22.1 1st TWO variations        
    Scenario Outline: Validate Sign Up error messages              // #22.2        
        # * def randomEmail = dataGenerator.getRandomEmail()         // #22.2   & then  // at #22.3 move to 'Background'  
        # * def randomUsername = dataGenerator.getRandomUsername()    // #22.2    & then   // at #22.3 move to 'Background'   
                                # // #22.1 below
        Given path 'users'
        # And request
        # """
        #     {
        #         "user": {
        #             "email": "karateTest75@test.com",
        #             "password": "vd1234554321",
        #             "username": #(randomUsername)
        #         }
        #     }
        # """
                    # // #22.2 different from above (karate will read from email)
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
        * print randomEmail
        * print randomUsername
        # * print password          // can't print password
        # * print errorResponse      // can't print error
                                                                # // #22.3
        And match response == <errorResponse>
        Examples:
            |       email           | password  |       username         |      errorResponse                                                                      |           
            | #(randomEmail)        | vd1234567 | karateTest67           | {"errors":{"username":["has already been taken"]}}                                 |
            | karateTest64@test.com | vd1234567 | #(randomUsername)      | {"errors":{"email":["has already been taken"]}}                                    |
            | karateUser123         | vd1234567 | #(randomUsername)      | {"errors":{"email":["is invalid"]}}                                                |
            | #(randomEmail)        | vd1234567 | karateUser101010101012 | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                 |
            | #(randomEmail)        | vd123     | #(randomUsername)      | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                 |
            |                       | vd1234567 | #(randomUsername)      | {"errors":{"email":["can't be blank"]}}                                            |
            | #(randomEmail)        |           | #(randomUsername)      | {"errors":{"password":["can't be blank"]}}                                         |
            | #(randomEmail)        | vd1234567 |                        | {"errors":{"username":["can't be blank"]}}                                         |
            # | #(randomEmail)        | vd1234567 |                        | {"errors":{"username":["is too short (minimum is 1 character)"]}}                  |
            # | #(randomEmail)        | vd1234567 |                        | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}} |
            # | #(randomEmail)        | vd1234567 |                        | {"errors":{"username":["can't be blank, is too short (minimum is 1 character)"]}} |