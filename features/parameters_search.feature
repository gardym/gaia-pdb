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
	