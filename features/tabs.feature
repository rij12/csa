Feature: Tabs
  As an administrator
  I want to be able to select Home, Jobs, Profile, Users and Broadcasts
  tabs on the web site
  So that I can access all the key functional areas of the application

  Scenario: Select the Users tab
    Given we are on page "/users"
    When I click on the Users tab
    Then it should be highlighted