Feature: Display parameters

  Scenario: Show all parameters
    Given there are 5 parameters
    When I navigate to the parameters page
    Then I should see 5 parameters
