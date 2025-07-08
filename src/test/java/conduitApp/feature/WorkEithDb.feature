# @parallel=false
Feature: work with DB
    Background: connect to db
        * def dbHandler = Java.type('helpers.DbHandler')
@debug
    Scenario: Seed database with a new Job
        * eval dbHandler.addNewJobWithName('QA2')
