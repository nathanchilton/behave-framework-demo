from selenium import webdriver

def get_browser_driver(browser_name):
    if str(browser_name).lower() == "firefox":
        browser_driver = webdriver.Firefox()
    elif str(browser_name).lower() == "chrome":
        browser_driver = webdriver.Chrome()
    else:
        print("The requested browser '" + browser_name + "' is not supported.")
        print("Starting Firefox....")
        browser_driver = webdriver.Firefox()
    return browser_driver
