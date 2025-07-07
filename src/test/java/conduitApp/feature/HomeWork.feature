# @debug
Feature: Home Work
    Background: Preconditions
        * def timeValidator = read('classpath:helpers/timeValidator.js')  
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def conduitUsername = 'karateTest64'
        * url apiUrl 
# @debug
    Scenario: Favorite articles
        # Step 1: Get articles of the global feed      
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get   
        Then status 200

        # Step 2: Get the favorites count and slug ID for the first article, save it to variables
        * def favoritesCount = response.articles[0].favoritesCount
        * def articleSlugId = response.articles[0].slug
        # * print 'Slug title is :' + articleSlugId
        # * print 'Favorites count is :' + favoritesCount

        # Step 3: Make POST request to increase favorites count for the first article
        Given path 'articles',articleSlugId,'favorite'
        And request {}
        When method Post
        Then status 200

        # Step 4: Verify response schema
        And match response ==
        """
            {
                "article": {
                id: "#number",
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": '#array',
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "authorId": "#number",
                "favorited": '#boolean',
                "favoritesCount": '#number',
                "author": {
                    "username": "#string",
                    "bio": '##string',
                    "image": "#string",
                    "following": '#boolean'
                    },
                    "favoritedBy": '#array',
                    "favorited": '#boolean',
                    "favoritesCount": '#number',
                }
            }   
        """

        # Step 5: Verify that favorites article incremented by 1
        * def incrementedCount = response.article.favoritesCount
        # * print 'Before: ', favoritesCount, 'After: ', incrementedCount
        * match incrementedCount == favoritesCount + 1
  
        # Step 6: Get all favorite articles
        Given params {"favorited": "#(conduitUsername)" , "limit": 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        # * print 'Favorited by: ', conduitUsername
        # * print 'Returned favorites: ', response.articles

        # Step 7: Verify response schema
        And match response ==
        """
            {
                "articles": '#array',
                "articlesCount": '#number'
            }
        """

        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        * def favoriteSlugs = response.articles.map(x => x.slug)
        # * print 'favoriteSlugs: ', favoriteSlugs
        # * print 'articleSlugId:' , articleSlugId
        * match favoriteSlugs contains articleSlugId

        # Step 8.5: Unfavorite the article to reset the state (optional but safe)
        Given path 'articles',articleSlugId,'favorite'
        When method Delete
        Then status 200
    
        ## Get slugs of only favorited articles         
        # * def favoriteSlugs = response.articles.filter(x => x.favoritesCount > 0).map(x => x.slug).slug
        # * print "favoriteSlugs: " + favoriteSlugs
        ## Now check if the saved slug ID is among them
        # * match favoriteSlugs contains articleSlugId
# @debug        
    Scenario: Comment articles
        # Step 1: Get articles of the global feed
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200

        # Step 2: Get the slug ID for the first article, save it to variable
        * def articleSlugId = response.articles[0].slug

        # Step 3: Make a GET call to 'comments' end-point to get all comments
        Given path 'articles',articleSlugId,'comments'
        When method Get
        Then status 200

        # Step 4: Verify response schema
        And match response ==
        """
            {
                "comments": '#array'
            }
        """

        # Step 5: Get the count of the comments array length and save to variable
        # * def responseWithComments = [{"article": "first"}, {article: "second"}]
        # * def articlesCount = responseWithComments.length
        * def initialCommentsCount = response.comments.length
        # * print "initialCommentsCount: " + initialCommentsCount

        # Step 6: Make a POST request to publish a new comment
        * def postNewComment = dataGenerator.getRandomArticleValues().body
        Given path 'articles',articleSlugId,'comments'
        And request 
        """
            {
                "comment": { 
                    "body": '#(postNewComment)'
                    }
            }
        """
        When method Post
        Then status 200
        # * print "postNewComment: " + postNewComment

        # Step 7: Verify response schema that should contain posted comment text
        And match response ==
        """ 
            {
                "comment": {
                    "id": '#number',
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "body": '#string',
                    "author": {
                        "username": '#string',
                        "bio": '##string',
                        "image": '#string',
                        "following": '#boolean'
                    }
                }
            }
        """
        * def newCommentId = response.comment.id
        # * print "commentText: ",newCommentId

        # Step 8: Get the list of all comments for this article one more time
        Given path 'articles',articleSlugId,'comments'
        When method Get
        Then status 200
        # * print "initialCommentsCount",initialCommentsCount

        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)   
        * def currentCommentsCount = response.comments.length
        # * print "currentCommentsCount: " + currentCommentsCount
        And match currentCommentsCount == initialCommentsCount + 1
        
        # Step 10: Make a DELETE request to delete comment
        Given path 'articles',articleSlugId,'comments',newCommentId
        When method Delete
        Then status 200

        # Step 11: Get all comments again and verify number of comments decreased by 1
        # * print "initialCommentsCount: ",initialCommentsCount
        And match initialCommentsCount == currentCommentsCount - 1
        # * print "currentCommentsCount: ",currentCommentsCount
        # * print "currentCommentsCount: ",currentCommentsCount - 1
        