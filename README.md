# Behave Framework Demo

This project serves as a demonstration of using Behave, a Python framework for behavior-driven development (BDD), to automate scenarios in Gherkin syntax. It includes a simple page object model and utilizes Playwright for browser automation.

## Background

Originally developed in 2019, this project stemmed from the author's experience in test automation with Ruby, particularly using Cucumber with SitePrism. With a preference for Gherkin syntax, the author sought to explore similar capabilities in Python. Behave was chosen due to its similarity to Cucumber. While no direct equivalent of SitePrism was found for Python, the author crafted a basic page object model after researching various approaches and articles.

## Features

- Automation of scenarios written in Gherkin syntax using Behave
- Simple page object model for organizing tests
- Utilizes Playwright for browser automation
- Includes two sample scenarios for testing a basic web form hosted at [https://www.nathanchilton.com/webform/addition_form.html](https://www.nathanchilton.com/webform/addition_form.html)

## Getting Started

### Prerequisites

- Python 3 installed
- Ensure that the `python` and `pip` commands are linked to Python 3
- If both Python 2 and Python 3 are installed, use `python3` and `pip3` instead

### Installation

1. Clone this repository.
   ``` bash
   git clone git@github.com:nathanchilton/behave-framework-demo.git
   cd behave-framework-demo
   ```

2. Ensure pip is installed:
    ```bash
    python -m ensurepip --upgrade
    ```

3. Create a Python virtual environment using venv:
    ```bash
    python -m venv venv
    ```

4. Activate the virtual environment:
    ```bash
    source venv/bin/activate
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
