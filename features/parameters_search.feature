Feature: Display search initial page

  Scenario: Show search form
    When I navigate to the parameters search page
    Then I should see a search form with the following input criteria:
	|source    	|
	|unit 			|
	|description|
	