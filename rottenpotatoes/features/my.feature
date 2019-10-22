Feature: add/delete/edit movies
  As a rottenpotatoes user
  So that I can add/delete movies or edit information of movies 
  I want to be able to add/delete/edit movies
  
Background: movies in database
  
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: add a new movie
  When I am on the RottenPotatoes home page
  And I follow "Add new movie"
  And I fill in "Title" with "test"
  And I select "R" from "Rating"
  And I select "2019" from "movie_release_date_1i"
  And I select "October" from "movie_release_date_2i"
  And I select "22" from "movie_release_date_3i"
  And I fill in "Director" with "bozhao zhang"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "test was successfully created."

Scenario: delete a movie
  When I am on the RottenPotatoes home page
  And I follow "More about Alien"
  And I press "Delete"
  Then I should be on the home page
  And I should see "Movie 'Alien' deleted."

Scenario: create new movies
  When I am on the RottenPotatoes home page
  And I follow "More about Alien"
  And I follow "Edit"
  And I fill in "Director" with "Ridley Scott"
  And I press "Update Movie Info"
  Then I should be on the details page for "Alien"
  And I should see "Alien was successfully updated."