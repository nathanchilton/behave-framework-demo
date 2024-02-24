# behave-framework-demo

Back in 2019, when I put this together, all of my test automation experience (over 2.5 years) had been done in Ruby, using SitePrism -- first with RSpec and then with Cucumber.

Being a fan of Gherkin, I wanted to try automating scenarios using another language.  Python has a few different options, but Behave looks like the closest thing to what I'm used to with Cucumber.  I wasn't able to find anything comparable to SitePrism for Python but, after reading multiple articles and trying a few different approaches, I put this together, as a basic starting point for automating Gherkin scenarios, using Behave, with a very simple page object model.

My original implementation used Selenium, but I have since updated it to use Playwright, instead.

It contains two simple scenarios for automating a test of a simple form hosted at [https://www.nathanchilton.com/webform/addition_form.html](https://www.nathanchilton.com/webform/addition_form.html)


Running the tests should be fairly simple, if you follow these instructions.  Playwright automatically downloads browsers, so you should not need to worry about having the right browser installed or setting up a driver.

### Prerequisites
You will need to have Python 3 installed.  This guide assumes that the `python` and `pip` commands will be linked to Python 3 and not Python 2.  If you have both Python 2 and Python 3 on your machine, you may need to use `python3` and `pip3`.

### Installing `pip`
After cloning this repository, you will need `pip`.
Assuming you have Python3 installed:
```bash
python -m ensurepip --upgrade
```

### create a [Python virtual environment](https://docs.python.org/3/tutorial/venv.html)
using the [venv](https://docs.python.org/3/library/venv.html) module
to manage dependency packages locally:
```bash
python -m venv venv
```

### Activate the virtual environment:
```bash
source venv/bin/activate
```

### Install the dependencies:
``` bash
pip install -r requirements.txt
```

### Install the required browsers:
``` bash
playwright install
```

### With that done, you should be able to run the automated scenario using:
``` bash
behave
```

### To execute tests in parallel, use `behavex`:
``` bash
behavex -t @TAG --parallel-processes 4 --parallel-scheme scenario
```
