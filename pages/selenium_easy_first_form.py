from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

class SeleniumEasyFirstForm:
    instance = None

    @classmethod
    def get_instance(cls):
        if cls.instance is None:
            cls.instance = SeleniumEasyFirstForm()
        return cls.instance

    def set_context(self, context):
        self.context = context
        self.browser = context.browser

    # URL = 'https://www.seleniumeasy.com/test/basic-first-form-demo.html'
    URL = 'http://localhost:8000/'

    INPUT_A = (By.ID, 'sum1')
    INPUT_B = (By.ID, 'sum2')
    BUTTON_GET_TOTAL = (By.CSS_SELECTOR, "form#gettotal button")
    DISPLAY_VALUE = (By.CSS_SELECTOR, "span#displayvalue")

    def load(self):
        self.browser.get(self.URL)

    def set_input_a(self, phrase):
        element = self.browser.find_element(*self.INPUT_A)
        element.send_keys(phrase)

    def set_input_b(self, phrase):
        element = self.browser.find_element(*self.INPUT_B)
        element.send_keys(phrase)

    def get_total(self):
        self.browser.find_element(*self.BUTTON_GET_TOTAL).click()

    def result(self):
        return self.browser.find_element(*self.DISPLAY_VALUE).text

selenium_easy = SeleniumEasyFirstForm.get_instance()
