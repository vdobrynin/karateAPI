# @smoke
@debug
Feature: Tests for the home page

  Background: Define URL
    Given url apiUrl   

  Scenario: Get all tags
    # Given url 'https://conduit-api.bondaracademy.com/api/tags'
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'tags'
    When method Get 
    Then status 200
    # And match response.tags contains 'GitHub'   //#next 4 assertion no needed in auto.testing
    # And match response.tags contains ['Zoom', 'Coding']
    # And match response.tags !contains 'truck'
    # And match response.tags contains any ['fish', 'dog', 'Exam']
    # And match response.tags contains any ['fish', 'dog']          //# wil fail
    And match response.tags == '#array'
    # And match response.tags == '#string' # will have an error (array contains strings)
    And match each response.tags == "#string" 


  @skip
  Scenario: Get 10 articles from the page  
      # Given param limit = 10
      # Given param offset = 0
    Given params { limit: 10, offset: 0 }
    # Given url 'https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0'
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    # And match response.articles == '#[9]' 
    # And match response.articlesCount == 10
    # And match response.articlesCount == 9   
    # And match response.articlesCount == 20 
    # And match response.articlesCount == '10' 

    # And match response.articlesCount == 10 
    And match response.articlesCount != 5 
    # And match response == {"articles": "#array", "articlesCount": 10}
    # And match response == {"articles": "#array", "articlesCount": 5}    //# will fail
    And match response.articles[0].createdAt contains '2024'
    And match response.articles[*].favoritesCount contains 8
    # And match response.articles[*].favoritesCount contains 205
    # And match response.articles[*].favoritesCount contains 1    //# will fail
    # And match response.articles[*].favoritesCount contains 0
    And match response.articles[*].author.bio contains null
    And match response..bio contains null
    
    And match each response..following == false
    # And match each response..following == true //# will fail
    And match each response..following == '#boolean'
    # And match each response..favoritesCount == '#string' 
    And match each response..favoritesCount == '#number' 
                                                        # // double ## --> null or string, see below
    And match each response..bio == '##string'
    # And match each response..bio == '#string' //# will fail