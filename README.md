# behave-framework-demo

All of my test automation experience so far (over 2.5 years) has been done in Ruby, using SitePrism -- first with RSpec and then with Cucumber.  Being a fan of Gherkin, I wanted to try automating scenarios using another language.  Python has a few different options, but Behave looks like the closest thing to what I'm used to with Cucumber.  I wasn't able to find anything comparable to SitePrism for Python but, after reading multiple articles and trying a few different approaches, I put this together, as a basic starting point for automating Gherkin scenarios, using Behave, with a very simple page object model.

It contains one simple scenario for automating a test of a simple form hosted at https://www.seleniumeasy.com/test/basic-first-form-demo.html (an example I automated in Ruby as a teaching lesson for my team).

Running this should be fairly simple.
You'll need a web browser and the appropriate driver for it (Chrome/Chromium and ChromeDriver or Firefox and GeckoDriver).

After cloning this repository, you'll need `pip` 
```sudo apt install python3-pip```
Then, you can use `pip` to install `pipenv`
```pip3 install pipenv```
... and then you can use `pipenv` to install Selenium and Behave:
```pipenv install```

With that done, you should be able to run the automated scenario using:
```pipenv run behave```

The browser can be selected by editing `behave.ini`.
