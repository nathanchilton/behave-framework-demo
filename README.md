# Behave Framework Demo

This project serves as a demonstration of using Behave, a Python framework for behavior-driven development (BDD), to automate scenarios in Gherkin syntax. It includes a simple page object model and utilizes Playwright for browser automation.

## Karate-like API testing in Python (POC)

This project now includes a proof of concept for using "Karate-style" syntax for API testing!

I am a long-time user of the [Karate](https://github.com/karatelabs/karate) framework.  I have introduced it at two different companies, taught others to use it, and I have seen excellent results when putting it to use.  My team members have been able to learn it quickly and have created large suites of tests with it.  We have used it effectively with both REST APIs and GraphQL APIs.  We have also used it effectively with both Selenium and Playwright, for automating a browser when testing the front end.

I really like working with Python and Playwright, but I immediately missed the simplicity of Karate tests, particularly for testing APIs, where high-level Given/When/Then does not really fit the need.  So, I started thinking about how I might be able to enable a similar style of testing, within a Python/Behave framework.

This is very much a proof of concept and not anywhere close to a full implementation of Karate's functionality.  However, with the small amount of code in `karate_style.py`, we have enough step definitions to start developing some basic API tests which can be constructed entirely as `.feature` files.

A key feature of this approach, is that it means not needing to choose between one style and another.  We can support *both!*  Within the same suite of tests (and even within any given scenario), we can make use of a combination of flexible, pre-defined, Karate-style steps and standard Gherkin/BDD steps (which will require some new "glue code" to make them work).

There are some example tests, to demonstrate this functionality, in `features/the_starwars_api/planets.feature`.

After following the instructions in the [Installation](#installation) section of this document, these "Karate-style" tests can be executed using the following command:

``` bash
behave -t @karate-style
```

## Background

Originally developed in 2019, this project stemmed from the author's experience in test automation with Ruby, particularly using Cucumber with SitePrism. With a preference for Gherkin syntax, the author sought to explore similar capabilities in Python. Behave was chosen due to its similarity to Cucumber. While no direct equivalent of SitePrism was found for Python, the author crafted a basic page object model after researching various approaches and articles.

## Features

- Automation of scenarios written in Gherkin syntax using Behave
- Simple page object model for organizing tests
- Utilizes Playwright for browser automation
- Supports [Karate](https://github.com/karatelabs/karate)-style syntax for API testing (early proof of concept)
- Includes two sample scenarios for testing a basic web form hosted at [https://www.nathanchilton.com/webform/addition_form.html](https://www.nathanchilton.com/webform/addition_form.html)

## Getting Started

### Prerequisites

- Python 3 installed
- Ensure that the `python` and `pip` commands are linked to Python 3
- If both Python 2 and Python 3 are installed, you _may_ need to use `python3` and `pip3` instead of `python` and `pip`
- Using macOS, Ubuntu Linux, or Windows

### Installation

1. Clone this repository.

   ``` bash
   git clone git@github.com:nathanchilton/behave-framework-demo.git
   cd behave-framework-demo
   ```

2. Create a Python virtual environment using venv:

    ```bash
    python -m venv venv
    ```

3. Activate the virtual environment:

    macOS/Linux:

    ```bash
    source venv/bin/activate
    ```

    Windows:

    ```bash
    venv\Scripts\activate
    ```

4. Ensure that `pip` is installed:

    ```bash
    python -m ensurepip --upgrade
    ```

5. Install the dependencies:

    ```bash
    pip install -r requirements.txt
    ```

6. Install the required browsers for Playwright:

    ```bash
    playwright install
    ```

### Running Tests

- To execute the automated scenarios:

    ```bash
    behave
    ```

- To execute tests in parallel:

    ```bash
    behavex -t @TAG --parallel-processes 4 --parallel-scheme scenario
    ```

Replace `@TAG` with the specific tag or tags you want to include or exclude during parallel execution.
