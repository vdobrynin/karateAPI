
# @debug
# @parallel=false
Feature: Hooks
    Background: hooks                                               // #26.1    
        * def result = call read('classpath:helpers/Dummy.feature')   
        * def username = result.username                            

        # // after hooks                                                                       
        # * configure afterFeature = function() { karate.call('classpath:helpers/Dummy.feature') }                                                                                          
        * configure afterScenario = function() { karate.call('classpath:helpers/Dummy.feature') }
        # * configure afterFeature = function() { karate.log('After Feature Text') }
        * configure afterFeature = 
        """
            function() { 
                karate.log('After Feature Text') 
            }
        """

    Scenario: First scenario
        * print username
        * print 'Print this first scenario'

    Scenario: Second scenario
        * print username
        * print 'Print this second scenario'    

