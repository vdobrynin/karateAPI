Feature: Create Token
Scenario: Create Token
    Given url apiUrl  
    # Given url 'https://conduit-api.bondaracademy.com/api/'        // #16.1 replace url  
    Given path 'users/login'     // at #15.1 bring next 5 lines to CreateToken.feature 
    # And request {"user":{"email":"karateTest64@test.com","password":"vd1234567"}} 
    # And request {"user":{"email": "#(email)","password": "#(password)"}}  // #15.2 after change in 'Articles' line 18  
    And request {"user":{"email": "#(userEmail)","password": "#(userPassword)"}}  // #16.1 during creating env  
    When method Post
    Then status 200        
    * def authToken = response.user.token  // #15.1 rename token to authToken   // # --> #24 line below                  
    * print authToken           