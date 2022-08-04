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
        self.page = context.page

    URL = 'http://localhost:8000/'

    INPUT_A = '#sum1'
    INPUT_B = '#sum2'
    BUTTON_GET_TOTAL = "form#gettotal button"
    DISPLAY_VALUE = "span#displayvalue"

    def load(self):
        self.page.goto(self.URL)

    def set_input_a(self, phrase):
        self.page.locator(self.INPUT_A).fill(phrase)

    def set_input_b(self, phrase):
        self.page.locator(self.INPUT_B).fill(phrase)

    def get_total(self):
        self.page.locator(self.BUTTON_GET_TOTAL).click()

    def result(self):
        return self.page.locator(self.DISPLAY_VALUE).text_content()

addition_form = EasyAdditionForm.get_instance()
