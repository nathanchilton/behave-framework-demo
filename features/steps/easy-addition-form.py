from behave import given, when, then
from pages.addition_form_playwright import addition_form

@given(u'I am on the Basic First Form Demo Page')
def step_impl(context):
    addition_form.set_context(context)
    addition_form.load()

@when(u'I enter a number into the \'a\' and \'b\' input fields and click the \'Get Total\' button')
def step_impl_complete_form(context):
    addition_form.set_input_a('40')
    addition_form.set_input_b('2')
    addition_form.get_total()

@then(u'I will see their sum')
def step_impl(context):
    print(addition_form.result())
    assert addition_form.result() == '42'
