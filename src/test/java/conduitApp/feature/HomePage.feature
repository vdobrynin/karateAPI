@smoke
Feature: Tests for the home page

  Background: Define URL
    Given url 'https://conduit-api.bondaracademy.com/api/'    

  Scenario: Get all tags
    # Given url 'https://conduit-api.bondaracademy.com/api/tags'
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'tags'
    When method Get 
    Then status 200
    And match response.tags contains 'GitHub'
    And match response.tags contains ['Zoom', 'Coding']
    And match response.tags !contains 'truck'
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