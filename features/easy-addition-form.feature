@addition-demo
Feature: Easy Addition Form

    Background:
        Given I am on the Basic First Form Demo Page

    Scenario: I can use the form to get the sum of two numbers (implicit)
        When I enter numbers into the 'a' and 'b' input fields and click the 'Get Total' button
        And I click the 'Get Total' button
        Then I will see their sum

    Scenario: I can use the form to get the sum of two numbers (explicit)
        When I enter "40" into the "A" input field
        And I enter "2" into the "B" input field
        And I click the 'Get Total' button
        Then I will see their sum: "42"
