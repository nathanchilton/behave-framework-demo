from behave import given, when, then
from pages.selenium_easy_first_form import selenium_easy

@given(u'I am on the Basic First Form Demo Page')
def step_impl(context):
    selenium_easy.set_context(context)
    selenium_easy.load()

@when(u'I enter a number into the \'a\' and \'b\' input fields and click the \'Get Total\' button')
def step_impl_complete_form(context):
    selenium_easy.set_input_a('40')
    selenium_easy.set_input_b('2')
    selenium_easy.get_total()

@then(u'I will see their sum')
def step_impl(context):
    print(selenium_easy.result())
    assert selenium_easy.result() == '42'
