
Feature: Dummy

Scenario: dummy
    * def dataGenerator = Java.type('helpers.DataGenerator')  
    * def username = dataGenerator.getRandomUsername()
    * print username                                                                      