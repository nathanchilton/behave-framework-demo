Feature: Selenium Easy

    Scenario: I can use the form to get the sum of two numbers
        Given I am on the Basic First Form Demo Page
        When I enter a number into the 'a' and 'b' input fields and click the 'Get Total' button
        Then I will see their sum
