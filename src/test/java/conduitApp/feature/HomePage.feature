# @parallel=false
# @debug
Feature: Tests for the home page
    Background: Define URL
        Given url apiUrl
        # Given url 'https://conduit-api.bondaracademy.com/api/'   // #16.1 replace url 

# @debug    
    Scenario: Get all tags
        Given path 'tags'
        When method Get 
        Then status 200
        # And match response.tags contains 'GitHub'             //--> line 13 to 23 comment at *** #20 *** 
        # And match response.tags !contains 'truck'
        # And match response.tags contains any ['Blog', 'Git', "Value-Focused"]      // #18 all 3 present                                                         
        # And match response.tags contains any ['fish', 'GitHub', 'Dog', 'Enroll']  // #18 any values below (have only one)  
        # And match response.tags contains any ['Dog', 'fish', 'Bondar Academy']                                                                     
        # # And match response.tags contains any ['fish', 'Dog']                            // #18 will fail
        # And match response.tags !contains any ['fish', 'Dog', 'Value-Focused', 'Enroll']    //  #18 not contain any
        # And match response.tags contains only ["Test","Git","Zoom","YouTube","Blog","Bondar Academy","Enroll","Exam","Community","GitHub"]      
        # # And match response.tags contains only ["Test","Git","Zoom","YouTube","Bondar Academy","Enroll","Exam","Community","GitHub"]                
        And match response.tags == '#array'                                 // #19 *#1* priority in assertions
        # And match response.tags == '#string' //# reserve words (array 'contains' 'strings') error
        And match each response.tags == "#string"                           // #19 *#1* priority in assertions

# @debug @smoke
    Scenario: Get 10 articles from the page                                                                 
        * def timeValidator = read('classpath:helpers/timeValidator.js')  // added at #20 schema validator
        # Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        # And match response.articles == '#[10]'                       //--> line 33 to 61 comment at *** #20 *** 
        # # And match response.articles == '#[9]'     // will fail
        # And match response.articlesCount == 11                      // #18 *** probably teacher change from 10 to 11
        # # And match response.articlesCount == 9     // will fail
        # # And match response.articlesCount == 25    // will fail
        # # And match response.articlesCount == '10'  // will fail
        # And match response.articlesCount != 50 
        # # And match response.articlesCount == 50      // will fail

        # And match response.articlesCount != 5 
        And match response == {"articles": "#[10]", "articlesCount": 10}    // #18 *** probably teacher change from 10 to 11
        # And match response == {"articles": "#array", "articlesCount": 11}   // #18 *** probably teacher change from 10 to 11
        # # And match response == {"articles": "#array", "articlesCount": 5}  // will fail
        # # And match response == {"articles": "#array", "articlesCount": 9}  // will fail
        # And match response.articles[0].createdAt contains '2025'       
        # # And match response.articles[0].createdAt contains '2024'          // will fail
        # And match response.articles[*].favoritesCount contains 689          
        # And match response.articles[*].favoritesCount contains 61         
        # And match response.articles[*].author.bio contains null
        # And match response..bio contains null

        # And match each response..following == false                // #19 
        # # And match each response..following == true                          // will fail
        # And match each response..following == '#boolean'           // #19 
        # # And match each response..favoritesCount == '#string'                // will fail
        # And match each response..favoritesCount == '#number'       // #19 
        # #                                                 
        # And match each response..bio == '##string'           // double ## --> value of bio's should be null or string
        # # And match each response..bio == '#string'                           // will fail
                                                            # // *** #20 schema validation ***
      And match each response.articles ==
      """
          {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": '#array',
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": '#boolean',
            "favoritesCount": '#number',
            "author": {
                "username": "#string",
                "bio": '##string',
                "image": "#string",
                "following": '#boolean'
            }
          }
      """
# @debug
    Scenario: Conditional  Logic              // #29 create 1 article with 1 like to have data
        # Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200  
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

        # * if (favoritesCount == 0) karate.call('classpath:helpers/addLikes.feature', article) // #29.1
                                               # // js option bellow line 93 & 100      // #29.2
        * def result = favoritesCount == 0 ? karate.call('classpath:helpers/addLikes.feature', article).likesCount : favoritesCount

        # Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200 
        # And match response.articles[0].favoritesCount == 1      // #29.1
        And match response.articles[0].favoritesCount == result   // #29.2
        * print "favoritesCount: ",favoritesCount

# @debug
    Scenario: Retry call   
        * configure retry = { count: 10, interval: 5000 }
        # Given params { limit: 10, offset: 0 }
        Given path 'articles'

        # When retry until response.articles[0].favoritesCount == 0  // retry should be place before action
        When retry until response.articles[0].favoritesCount == 1
        When method Get
        Then status 200  

# @debug
    Scenario: Sleep call   
        * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
        # Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        * eval sleep(5000)    // hardcode sleep
        Then status 200     

# @debug
    Scenario: Number to string
        # * match 10 == '10'            // will fail
        * def foo = 10
        # * def json = { 'bar': #(foo)}           // will fail
        * def json = { 'bar': #(foo + '')}
        * match json == { 'bar': '10'}
    
@debug
    Scenario: String to number
        * def foo = '10'
        # * def json = { 'bar': #(foo)}               // will fail
        * def json = { 'bar': #(foo * 1)}   
        * def json1 = { 'bar': #(parseInt(foo))}        // js add 1.0
        * def json2 = { 'bar': #(~~parseInt(foo))}      // for integer       
        * match json == { 'bar': 10}
        * match json1 == { 'bar': 10}
        * match json2 == { 'bar': 10}