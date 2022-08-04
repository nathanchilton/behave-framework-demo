import re
from playwright.sync_api import Page, expect

class EasyAdditionForm:
    instance = None

    @classmethod
    def get_instance(cls):
        if cls.instance is None:
            cls.instance = EasyAdditionForm()
        return cls.instance

    def set_context(self, context):
        self.context = context

    # Assumes that you have started a local web server,
    # using something like:
    #   python -m http.server 8000
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

addition_form = EasyAdditionForm.get_instance()
