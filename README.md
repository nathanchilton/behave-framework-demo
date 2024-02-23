# behave-framework-demo

Back in 2019, when I put this together, all of my test automation experience (over 2.5 years) had been done in Ruby, using SitePrism -- first with RSpec and then with Cucumber.

Being a fan of Gherkin, I wanted to try automating scenarios using another language.  Python has a few different options, but Behave looks like the closest thing to what I'm used to with Cucumber.  I wasn't able to find anything comparable to SitePrism for Python but, after reading multiple articles and trying a few different approaches, I put this together, as a basic starting point for automating Gherkin scenarios, using Behave, with a very simple page object model.

It contains one simple scenario for automating a test of a simple form hosted at https://www.seleniumeasy.com/test/basic-first-form-demo.html (an example I automated in Ruby as a teaching lesson for my team).

Update: That form no longer exists, so I have put together a quick workaround.  We can serve the form locally!  The form can be found in the `index.html` file in the root of this repository.

We can use Python to serve up the page, so that the test can hit it.  If you have Python3 installed as `python`:
``` bash
python -m http.server 8000
```

Running the test should be fairly simple.
You'll need a web browser and the appropriate driver for it (Chrome/Chromium and ChromeDriver or Firefox and GeckoDriver).

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
python3 -m venv venv
```

### Activate the virtual environment:
```bash
source venv/bin/activate
```

### Install the dependencies:
``` bash
pip3 install -r requirements.txt
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
