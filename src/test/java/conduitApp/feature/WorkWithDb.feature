@ignore
# @debug
Feature: work with DB
    Background: connect to db
        * def dbHandler = Java.type('helpers.DbHandler')
# @debug
    Scenario: Seed database with a new Job
        * eval dbHandler.addNewJobWithName('QA4')      // #33 change number for creating diff query

# @debug
    Scenario: Get level for Job
        * def level = dbHandler.getMinAndMaxLevelsForJob("QA4")
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '75'
        And match level.maxLvl == '110'
