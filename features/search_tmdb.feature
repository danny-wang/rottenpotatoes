Feature: User can add movie by searching for it in the movie database(TM)

	As a movie fan
	So that I can add new movies without manual tedium
	I want to add movies by looking up their details in TMDb

Background: Start from the Search form on the home page
	Given I am on the RottenPotatoes home page
	Then I should see "Search TMDb for a movie"

Scenario: Try to add nonexistet movie(sad path)

	
	When I fill in "search_terms" with "Movie That Does Not Exist"
	And I press "Search TMDb"
	Then I should be on the RottenPotatoes home page
	And I should see "'Movie That Does Not Exist' was not found in TMDb."


Scenario: Try to add nonexistet movie(happy path)
	When I fill in "search_terms" with "Inception"
	And I press "Search TMDb"
	Then I should be on the "Search Results" page
	And I should not see "not found"
	And I should see "Inception"