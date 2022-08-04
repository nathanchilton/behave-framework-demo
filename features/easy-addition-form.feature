Feature: Easy Addition Form

    Scenario: I can use the form to get the sum of two numbers (implicit)
        Given I am on the Basic First Form Demo Page
        When I enter a number into the 'a' and 'b' input fields and click the 'Get Total' button
        And I click the 'Get Total' button
        Then I will see their sum
    @focus
    Scenario: I can use the form to get the sum of two numbers (explicit)
        Given I am on the Basic First Form Demo Page
        When I enter "40" into the "A" input field
        And I enter "2" into the "B" input field
        And I click the 'Get Total' button
        Then I will see their sum: "42"
