Feature: Search functionality

  Scenario: Show search form
    When I navigate to the parameters search page
    Then I should see a search form with the following input criteria:
	|source    	|
	|unit 			|
	|description|

  Scenario: Show search results
		Given there are 15 parameters
    When I navigate to the parameters search page
		And I perform a search for parameters with "source" set to "1"
    Then I should see 6 parameters
    
  Scenario: Show pages search results
    Given there are 125 parameters
    When I navigate to the parameters search page
    And I perform a search for parameters with "source" set to "5"
    Then I should see the first 20 parameters out of a total of 21

  @javascript
  Scenario: Change page size when searching parameters
    Given there are 125 parameters
    When I navigate to the parameters search page
    And I perform a search for parameters with "source" set to "5"
    And I select 50 as the page size
    Then I should see 21 parameters

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