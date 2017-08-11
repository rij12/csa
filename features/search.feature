Feature: Search
   As an administrator
   I want to be able to search for users by any user detail
   So that I quickly find users of interest    
    
Background:
  Given we have the following Users:
    | firstname | surname | email            | grad_year | 
    | Chris     | Loftus  | xyz0@aber.ac.uk  | 2000      |
    | Jon       | Adams   | xyz1@aber.ac.uk  | 2001      |
    | Peter     | Loftus  | xyz11@aber.ac.uk | 2002      |

@javascript
Scenario: Find Users by email using auto-search 
  When I enter "xyz1" in the search field
  Then the results must be:
    | firstname | surname | email            | grad_year | 
    | Jon       | Adams   | xyz1@aber.ac.uk  |  2001     |
    | Peter     | Loftus  | xyz11@aber.ac.uk |  2002     |

Scenario: Find Users by email
  When I search for User "xyz1"
  Then the results must be:
    | firstname | surname | email            | grad_year |
    | Jon       | Adams   | xyz1@aber.ac.uk  | 2001      |
    | Peter     | Loftus  | xyz11@aber.ac.uk | 2002      |