Feature: Parse a list of names
  As a hacker who works with Namae
  I want to be able to parse multiple names in a list

  @list
  Scenario: A list of names separated by 'and'
    When I parse the names "Plato and Archimedes and Publius Ovidius Naso"
    Then there should be 3 names
    And the names should be:
      | given           | family |
      | Plato           |        |
      | Archimedes      |        |
      | Publius Ovidius | Naso   |

  @list
  Scenario: A list of sort-order names separated by commas
    When I parse the names "Kernighan, Brian, Ritchie, Dennis, Knuth, Donald"
    Then there should be 3 names
    And the names should be:
      | given  | family    |
      | Brian  | Kernighan |
      | Dennis | Ritchie   |
      | Donald | Knuth     |
    Given a parser that prefers commas as separators
    When I parse the names "Kernighan, Brian, Ritchie, Dennis, Knuth, Donald"
    Then there should be 3 names
    And the names should be:
      | given  | family    |
      | Brian  | Kernighan |
      | Dennis | Ritchie   |
      | Donald | Knuth     |

  @list
  Scenario: A list of names separated by semicolons
    When I parse the names "John D. Smith; Jack R. Johnson; Emily Tanner"
    Then there should be 3 names
    And the names should be:
      | given   | family  |
      | John D. | Smith   |
      | Jack R. | Johnson |
      | Emily   | Tanner  |
    When I parse the names "Smith, John D.; Johnson, Jack R.; Tanner, Emily"
    Then there should be 3 names
    And the names should be:
      | given   | family  |
      | John D. | Smith   |
      | Jack R. | Johnson |
      | Emily   | Tanner  |

  @list
  Scenario: A list of sort-order names with initials separated by commas
    When I parse the names "Kernighan, B., Ritchie, D., Knuth, D."
    Then there should be 3 names
    And the names should be:
      | given       | family             |
      | B.          | Kernighan          |
      | D.          | Ritchie            |
      | D.          | Knuth              |

  @list
  Scenario: A list of mixed names separated by commas and 'and'
    When I parse the names "Kernighan, Brian, Ritchie, Dennis and Donald Knuth"
    Then there should be 3 names
    And the names should be:
      | given  | family    |
      | Brian  | Kernighan |
      | Dennis | Ritchie   |
      | Donald | Knuth     |

  @list
  Scenario: A list of mixed names separated by semicolons, commas and 'and'
    Given a parser that prefers commas as separators
    When I parse the names "John D. Smith, Jack R. Johnson & Emily Tanner"
    Then there should be 3 names
    And the names should be:
      | given   | family  |
      | John D. | Smith   |
      | Jack R. | Johnson |
      | Emily   | Tanner  |
    When I parse the names "C. Foster; C. Hamel, C. Desroches"
    Then there should be 3 names
    And the names should be:
      | given | family    |
      | C.    | Foster    |
      | C.    | Hamel     |
      | C.    | Desroches |

  @list
  Scenario: A list of display-order names separated by commas and 'and'
    Given a parser that prefers commas as separators
    When I parse the names "Brian Kernighan, Dennis Ritchie, and Donald Knuth"
    Then there should be 3 names
    And the names should be:
      | given  | family    |
      | Brian  | Kernighan |
      | Dennis | Ritchie   |
      | Donald | Knuth     |

  @list
  Scenario: A list of sort-order names with initials and a Muhammed abbreviation
    When I parse the names "Haque, Ariful, Abdullah-Al Mamun, Md, Abbas, Md Ahmed, Taufique, M. F. N., Karnati, Priyanka, Ghosh, Kartik"
    Then there should be 6 names
    And the names should be:
      | given       | family             |
      | Ariful      | Haque              |
      | Md          | Abdullah-Al Mamun  |
      | Md Ahmed    | Abbas              |
      | M. F. N.    | Taufique           |
      | Priyanka    | Karnati            |
      | Kartik      | Ghosh              |
    When I parse the names "Haque, Ariful; Abdullah-Al Mamun, Md; Abbas, Md Ahmed; Taufique, M. F. N.; Karnati, Priyanka; Ghosh, Kartik"
    Then there should be 6 names
    And the names should be:
      | given       | family             |
      | Ariful      | Haque              |
      | Md          | Abdullah-Al Mamun  |
      | Md Ahmed    | Abbas              |
      | M. F. N.    | Taufique           |
      | Priyanka    | Karnati            |
      | Kartik      | Ghosh              |
    Given a parser that prefers commas as separators
    When I parse the names "Haque, Ariful, Abdullah-Al Mamun, Md, Abbas, Md Ahmed, Taufique, M. F. N., Karnati, Priyanka, Ghosh, Kartik"
    Then there should be 6 names
    And the names should be:
      | given       | family             |
      | Ariful      | Haque              |
      | Md          | Abdullah-Al Mamun  |
      | Md Ahmed    | Abbas              |
      | M. F. N.    | Taufique           |
      | Priyanka    | Karnati            |
      | Kartik      | Ghosh              |

  @list
  Scenario: A list of sort-order names with an incorrect comma initial
    When I parse the names "Wang, Po-Min, Lo, Yi-Kai, Patel, Henil A., Chu, Jung Soo, V, Liu, Wentai"
    Then there should be 5 names
    And the names should be:
      | given       | family             |
      | Po-Min      | Wang               |
      | Yi-Kai      | Lo                 |
      | Henil A.    | Patel              |
      | Jung Soo V  | Chu                |
      | Wentai      | Liu                |
    Given a parser that prefers commas as separators
    When I parse the names "Wang, Po-Min, Lo, Yi-Kai, Patel, Henil A., Chu, Jung Soo, V, Liu, Wentai"
    Then there should be 5 names
    And the names should be:
      | given       | family             |
      | Po-Min      | Wang               |
      | Yi-Kai      | Lo                 |
      | Henil A.    | Patel              |
      | Jung Soo V  | Chu                |
      | Wentai      | Liu                |

  @list @wip
  Scenario: A list of names separated by commas
    Given a parser that prefers commas as separators
    When I parse the names "G. Proctor, M. Cooper, P. Sanders & B. Malcom"
    Then the names should be:
      | given | family  |
      | G.    | Proctor |
      | M.    | Cooper  |
      | P.    | Sanders |
      | B.    | Malcom  |
    When I parse the names "G Proctor, M Cooper, PJ Sanders & B Malcom"
    Then the names should be:
      | given | family  |
      | G     | Proctor |
      | M     | Cooper  |
      | PJ    | Sanders |
      | B     | Malcom  |

  Scenario: A list of names with particles separated by commas
    Given a parser that prefers commas as separators
    When I parse the names "Di Proctor, M., von Cooper, P."
    Then the names should be:
      | given | family     |
      | M.    | Di Proctor |
      | P.    | Cooper     |
    When I parse the names "Di Proctor, M, von Cooper, P"
    Then the names should be:
      | given | family     |
      | M     | Di Proctor |
      | P     | Cooper     |
