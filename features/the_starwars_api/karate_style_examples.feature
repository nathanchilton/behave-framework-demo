@discovery @portfolios-graphql @python
Feature: Discovery Schema Validation

  @TestCaseKey=QC-T2052 @focus
  Scenario: Validate Discovery Schema (Python Version)

    Given I am signed in as discovery.user@riskalyze.com
    And url portfolios_graphql_base_url

    * string context.graphql_query = read("features/riskalyze/discovery/graphql/discovery/resources/discovery-query.gql")
    * text context.jsonschema =
      """
      {
        "type": "object",
        "properties": {
          "discovery": {
            "type": "object",
            "properties": {
              "securities": {
                "type": "array"
              },
              "totalNumResults": {
                "type": "number"
              }
            }
          }
        }
      }
      """

    * request
      """
      {"query": context.graphql_query }
      """
    * method POST
    * status 200
    * validate response.data using jsonschema in context.jsonschema


  @python @TestCaseKey=QC-T4083
  Scenario: /date-ranges will correctly identify 2 ranges of consecutive dates (Python)
    Given url https://www.nathanchilton.com/date-ranges
    And text context.request_body =
      """
      [
        "2022-10-05",
        "2022-10-06",
        "2022-10-03",
        "2022-10-04",
        "2022-10-10"
      ]
      """
    * method POST
    * status 200
    * assert response.ranges.length == 2

    * text context.range_schema =
      """
      {
        "type": "array",
        "properties": {
          "begin": {
            "type": "string",
            "pattern": "^\\d{4}-\\d{2}-\\d{2}$"
          },
          "end": {
            "type": "string",
            "pattern": "^\\d{3}-\\d{2}-\\d{2}$"
          }
        }
      }
      """
    * validate response.ranges using jsonschema in context.range_schema
