Feature: The /planets route for The Star Wars API at swapi.dev

    Background:
        * url "https://swapi.dev/api"
        * path "/planets"

    Scenario: /planets returns a list of all planets

        * print context.request_url
        * method GET
        * status 200
        * print response
        * breakpoint


# Basic Endpoint Tests:

# Test that /planets/ returns a list of all planets.
# Test that /planets/:id/ returns information for a specific planet.
# Test that /planets/schema/ returns the JSON schema for the planets resource.
# Data Validation Tests:

# Validate the structure of the response JSON against the expected schema.
# Check the data types of attributes (e.g., string, number, array).
# Ensure required fields are present.
# Verify that all URLs in the response are valid and accessible.
# Search Functionality Tests:

# Test searching for planets by name using various cases (e.g., uppercase, lowercase, mixed case).
# Verify that partial matches work correctly.
# Test searching for planets that don't exist to ensure appropriate error handling.
# Encoding Tests:

# Test fetching planet data in both JSON and Wookiee encoding.
# Verify that Wookiee-encoded responses are correctly translated and formatted.
# Boundary and Edge Case Tests:

# Test endpoints with invalid IDs (e.g., non-existent IDs, negative IDs).
# Test endpoints with extreme values for numeric attributes (e.g., very large or very small diameters, orbital periods).
# Test endpoints with empty or null values for optional attributes.
# Performance Tests:

# Test the response time of endpoints to ensure they meet performance requirements.
# Execute load tests to assess how the API handles concurrent requests and heavy traffic.
# Regression Tests:

# Re-run tests for previously identified issues to ensure they have been fixed.
# Test for regression by verifying that fixed issues remain resolved.
# Negative Tests:

# Test endpoints with invalid or missing parameters.
# Test endpoints with unsupported HTTP methods (e.g., POST, PUT, DELETE).
# Authentication and Authorization Tests (if applicable):

# Test endpoints with valid and invalid authentication tokens.
# Verify that unauthorized users cannot access restricted endpoints.
# Error Handling Tests:

# Test endpoints with malformed requests to ensure appropriate error responses are returned (e.g., invalid JSON, missing parameters).
# Verify that error responses include meaningful error messages and appropriate HTTP status codes.
# Concurrency Tests:

# Test the API under concurrent requests to check for any race conditions or thread safety issues.
# Documentation Tests:

# Verify that the API documentation accurately reflects the behavior of the endpoints.
# Ensure that all endpoints, parameters, and responses are well-documented and up-to-date.