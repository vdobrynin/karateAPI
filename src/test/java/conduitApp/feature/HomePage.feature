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
        And match response.tags contains 'GitHub'        
        And match response.tags !contains 'truck'
        And match response.tags contains any ['qa career', 'YouTube', 'Value-Focused']      
        And match response.tags == '#array'
        # And match response.tags == '#string' //# reserve words (array 'contains' 'strings') error
        And match each response.tags == "#string" 

# @debug @smoke
    Scenario: Get 10 articles from the page                                                                 
    # * def timeValidator = read('classpath:helpers/timeValidator.js')      // added at #20
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        # And match response.articles == '#[9]'     // will fail
        And match response.articlesCount == 10
        # And match response.articlesCount == 9     // will fail
        # And match response.articlesCount == 25    // will fail
        # And match response.articlesCount == '10'  // will fail

        And match response.articlesCount != 5 
        And match response == {"articles": "#[10]", "articlesCount": 10}
        And match response == {"articles": "#array", "articlesCount": 10}
        # And match response == {"articles": "#array", "articlesCount": 5}  // will fail
        # And match response.articles[0].createdAt contains '2025'          // will fail
        # And match response.articles[*].favoritesCount contains 9          // will fail
        # And match response.articles[*].favoritesCount contains 205        // will fail
        # And match response.articles[*].favoritesCount contains 1          // will fail
        # And match response.articles[*].favoritesCount contains 0          // will fail
        And match response.articles[*].author.bio contains null
        And match response..bio contains null

        And match each response..following == false
        # And match each response..following == true                          // will fail
        And match each response..following == '#boolean'
        # And match each response..favoritesCount == '#string'                // will fail
        And match each response..favoritesCount == '#number' 
        #                                                 
        And match each response..bio == '##string'           // double ## --> null or string
        # And match each response..bio == '#string'                           // will fail

    #   And match each response.articles ==
    #   """
    #       {
    #         "slug": "#string",
    #         "title": "#string",
    #         "description": "#string",
    #         "body": "#string",
    #         "tagList": '#array',
    #         "createdAt": "#? timeValidator(_)",
    #         "updatedAt": "#? timeValidator(_)",
    #         "favorited": '#boolean',
    #         "favoritesCount": '#number',
    #         "author": {
    #             "username": "#string",
    #             "bio": '##string',
    #             "image": "#string",
    #             "following": '#boolean'
    #         }
    #       }
    #   """

    # Scenario: Conditional  Logic
    #   Given params { limit: 10, offset: 0 }
    #   Given path 'articles'
    #   When method Get
    #   Then status 200  
    #   * def favoritesCount = response.articles[0].favoritesCount
    #   * def article = response.articles[0]

    #   # * if (favoritesCount == 0) karate.call('classpath:helpers/addLikes.feature', article)
    #                                                                                           # // javascript option bellow line 93 & 100
    #   * def result = favoritesCount == 0 ? karate.call('classpath:helpers/addLikes.feature', article).likesCount : favoritesCount

    #   Given params { limit: 10, offset: 0 }
    #   Given path 'articles'
    #   When method Get
    #   Then status 200 
    #   # And match response.articles[0].favoritesCount == 1
    #   And match response.articles[0].favoritesCount == result

    # Scenario: Retry call   
    #   * configure retry = { count: 10, interval: 5000 }

    #   # Given params { limit: 10, offset: 0 }
    #   Given path 'articles'

    #   When retry until response.articles[0].favoritesCount == 0
    #   # When retry until response.articles[0].favoritesCount == 1

    #   When method Get
    #   Then status 200  

    # Scenario: Sleep call   
    #   * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

    #   Given params { limit: 10, offset: 0 }
    #   Given path 'articles'
    #   When method Get

    #   * eval sleep(5000)

    #   Then status 200     
    
    # Scenario: Number to string
    #   # * match 10 == '10'
    #   * def foo = 10
    #   * def json = { 'bar': #(foo+'')}
    #   * match json == { 'bar': '10'}
    
    # Scenario: String to number
    #   * def foo = '10'
    #   * def json = { 'bar': #(parseInt(foo))}
    #   * def json1 = { 'bar': #(~~parseInt(foo))}
    #   * def json2 = { 'bar': #(foo*1)}
    #   * match json == { 'bar': 10}
    #   * match json1 == { 'bar': 10}
    #   * match json2 == { 'bar': 10}