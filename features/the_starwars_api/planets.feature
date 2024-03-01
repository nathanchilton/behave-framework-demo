@swapi @automated @karate-style @python @api
Feature: The /planets route for The Star Wars API at swapi.dev

  Background:
    # All the URLs in this feature file will use the following as the "base URL"
    * url "https://swapi.dev/api/planets"

    # This jsonschema is used for multiple tests:
    * text context.planet_jsonschema =
      """
      {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "rotation_period": {
            "type": "string",
            "pattern": "^\\d+$"
          },
          "orbital_period": {
            "type": "string",
            "pattern": "^\\d+$"
          },
          "diameter": {
            "type": "string",
            "pattern": "^\\d+$"
          },
          "climate": {
            "type": "string"
          },
          "gravity": {
            "type": "string"
          },
          "terrain": {
            "type": "string"
          },
          "surface_water": {
            "type": "string"
          },
          "population": {
            "type": "string",
            "pattern": "^\\d+$|unknown"
          },
          "residents": {
            "type": "array"
          },
          "films": {
            "type": "array"
          },
          "created": {
            "type": "string",
            "pattern": "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d+Z$"
          },
          "edited": {
            "type": "string",
            "pattern": "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d+Z$"
          },
          "url": {
            "type": "string"
          }
        },
        "required": [
          "name",
          "rotation_period",
          "orbital_period",
          "diameter",
          "climate",
          "gravity",
          "terrain",
          "surface_water",
          "population",
          "residents",
          "films",
          "created",
          "edited",
          "url"
        ]
      }
      """

  Scenario: /planets returns a list of all planets
    # Send a GET request to the URL defined in the background
    * method GET

    # Assert that the HTTP status code in the response is 200
    * status 200

    # Print the response to the console (just for fun/debugging)
    * print response

    # Make some assertions about the content of the response
    * assert response.count == 60
    * assert response.results.length == 10

    # Validate top-level response
    * text context.jsonschema =
      """
      {
        "type": "object",
        "properties": {
          "count": {
            "type": "number"
          },
          "next": {
            "type": "string"
          },
          "previous": {
            "type": [
              "string",
              "null"
            ]
          },
          "results": {
            "type": "array"
          }
        }
      }
      """
    * validate response using jsonschema in context.jsonschema

    # Validate each of the values in the "results" array
    * validate each response.results using jsonschema in context.planet_jsonschema


  Scenario: Exercise pagination
    # Get the first page of planets
    * method GET
    * assert response.count == 60
    * assert response.results.length == 10
    * assert response.next == "https://swapi.dev/api/planets/?page=2"
    * assert response.previous == null

    # Get the last page
    * print context.request_url
    * path "/?page=6"
    * print context.request_url
    * breakpoint
    * method GET
    * assert response.count == 60
    * assert response.results.length == 10
    * assert response.next == null
    * assert response.previous == "https://swapi.dev/api/planets/?page=5"

  ########################
  # Basic Endpoint Tests:
  ########################


  Scenario: /planets/:id returns information for a specific planet
    # Add /1 to the end of the "base URL"
    * path "/1"

    * method GET

    * status 200
    * print response
    * validate response using jsonschema in context.planet_jsonschema


  Scenario: Search for planet by name
    # Add /1 to the end of the "base URL"
    * path "/?search=Dagobah"

    * method GET

    * status 200
    * print response
    * assert response.count == 1
    * assert response.next == null
    * assert response.previous == null
    * validate response.results[0] using jsonschema in context.planet_jsonschema


  Scenario: Wookiee Format
    # Add /1 to the end of the "base URL"
    * path "/1"
    * path "?format=wookiee"

    * method GET

    * status 200
    * text context.planet_jsonschema_wookiee =
      """
      {
        "type": "object",
        "properties": {
          "whrascwo": {
            "type": "string"
          },
          "rcooaoraaoahoowh_akworcahoowa": {
            "type": "string",
            "pattern": "^\\d+$"
          },
          "oorcrhahaoraan_akworcahoowa": {
            "type": "string",
            "pattern": "^\\d+$"
          },
          "waahrascwoaoworc": {
            "type": "string",
            "pattern": "^\\d+$"
          },
          "oaanahscraaowo": {
            "type": "string"
          },
          "rrrcrahoahaoro": {
            "type": "string"
          },
          "aoworcrcraahwh": {
            "type": "string"
          },
          "churcwwraoawo_ohraaoworc": {
            "type": "string"
          },
          "akooakhuanraaoahoowh": {
            "type": "string",
            "pattern": "^\\d+$"
          },
          "rcwocahwawowhaoc": {
            "type": "array"
          },
          "wwahanscc": {
            "type": "array"
          },
          "oarcworaaowowa": {
            "type": "string",
            "pattern": "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d+Z$"
          },
          "wowaahaowowa": {
            "type": "string",
            "pattern": "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d+Z$"
          },
          "hurcan": {
            "type": "string"
          }
        },
        "required": [
          "whrascwo",
          "rcooaoraaoahoowh_akworcahoowa",
          "oorcrhahaoraan_akworcahoowa",
          "waahrascwoaoworc",
          "oaanahscraaowo",
          "rrrcrahoahaoro",
          "aoworcrcraahwh",
          "churcwwraoawo_ohraaoworc",
          "akooakhuanraaoahoowh",
          "rcwocahwawowhaoc",
          "wwahanscc",
          "oarcworaaowowa",
          "wowaahaowowa",
          "hurcan"
        ]
      }
      """
    * validate response using jsonschema in context.planet_jsonschema_wookiee

  # Test that /planets/ returns a list of all planets.
  # Test that /planets/:id/ returns information for a specific planet.
  # Test that /planets/schema/ returns the JSON schema for the planets resource.
  # Data Validation Tests:

  # Validate the structure of the response JSON against the expected schema.
  # Check the data types of attributes (e.g., string, number, array).
  # Ensure required fields are present.
  # Verify that all URLs in the response are valid and accessible.

  #############################
  # Search Functionality Tests:
  #############################

  # Test searching for planets by name using various cases (e.g., uppercase, lowercase, mixed case).
  # Verify that partial matches work correctly.
  # Test searching for planets that don't exist to ensure appropriate error handling.
  # Encoding Tests:

  # Test fetching planet data in both JSON and Wookiee encoding.
  # Verify that Wookiee-encoded responses are correctly translated and formatted.

  ###############################
  # Boundary and Edge Case Tests:
  ###############################

  # Test endpoints with invalid IDs (e.g., non-existent IDs, negative IDs).
  # Test endpoints with extreme values for numeric attributes (e.g., very large or very small diameters, orbital periods).
  # Test endpoints with empty or null values for optional attributes.

  #####################
  # Performance Tests:
  #####################

  # Test the response time of endpoints to ensure they meet performance requirements.
  # Execute load tests to assess how the API handles concurrent requests and heavy traffic.

  ####################
  # Regression Tests:
  ####################

  # Re-run tests for previously identified issues to ensure they have been fixed.
  # Test for regression by verifying that fixed issues remain resolved.

  ##################
  # Negative Tests:
  ##################

  # @focus
  Scenario Outline: HTTP method is not supported: <method>
    Only GET requests are supported
    * method <method>

    # Expect a status code of 405 (Method Not Allowed)
    * status 405

    Examples:
      | method |
      | POST   |
      | PUT    |
      | PATCH  |
      | DELETE |

  ########################
  # Error Handling Tests:
  ########################

  # Test endpoints with malformed requests to ensure appropriate error responses are returned (e.g., invalid JSON, missing parameters).
  # Verify that error responses include meaningful error messages and appropriate HTTP status codes.


  ######################
  # Documentation Tests:
  ######################


  Scenario: /planets/schema returns the schema
    # The documentation clearly states that:
    #   /planets/schema/ -- view the JSON schema for this resource
    # Note: This test is failing.  The API is returning a 404.
    * path "/schema/"
    * print context.request_url
    * method GET
    * status 200
