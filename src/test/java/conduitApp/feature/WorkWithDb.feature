
@debug
Feature: work with DB
    Background: connect to db
        * def dbHandler = Java.type('helpers.DbHandler')
# @debug
    Scenario: Seed database with a new Job
        * eval dbHandler.addNewJobWithName('QA5')      // #33 change number for creating diff query

# @debug
    Scenario: Get level for Job
        * def level = dbHandler.getMinAndMaxLevelsForJob("QA5")
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '95'
        And match level.maxLvl == '105'
