Feature: View parameters

  Scenario: Show all parameters
    Given there are 5 parameters
    When I navigate to the parameters page
    Then I should see 5 parameters

  Scenario: Show pagination information
    Given there are 42 parameters
    When I navigate to the parameters page
    Then I should see the first 20 parameters out of a total of 42

  @javascript
  Scenario: Change page size when browsing parameters
    Given there are 52 parameters
    When I navigate to the parameters page
    And I select 50 as the page size
    Then I should see the first 50 parameters out of a total of 52    

  Scenario: Move through pages
    Given there are 42 parameters
    When I navigate to the parameters page
    And I choose to view the next page
		Then the current page should be 2

  Scenario: Export buttons present
    Given there are 5 parameters
    When I navigate to the parameters page
    Then the export as pdf button exists
    And the export as xml button exists

  Scenario: Export pdf
    Given there are 5 parameters
    When I navigate to the parameters page
    And I export the results as pdf
    Then I should get a response with content-type "application/pdf"

  Scenario: Export xml
    Given there are 5 parameters
    When I navigate to the parameters page
    And I export the results as xml
    Then I should get a response with content-type "application/xml"