Feature: View parameters

  Scenario: Show all parameters
    Given there are 5 parameters
    When I navigate to the parameters page
    Then I should see 5 parameters

  Scenario: Show pagination information
    Given there are 42 parameters
    When I navigate to the parameters page
    Then I should see the first 20 parameters out of a total of 42

  Scenario: Move through pages
    Given there are 42 parameters
    When I navigate to the parameters page
    And I choose to view the next page
		Then the current page should be 2

