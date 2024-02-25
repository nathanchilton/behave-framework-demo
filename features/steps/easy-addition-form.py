from behave import given, when, then
from pages.addition_form_playwright import addition_form


@given("I am on the Basic First Form Demo Page")
def step_impl(context):
    addition_form.set_context(context)
    addition_form.load()


@when('I enter "{value}" into the "{input}" input field')
def step_impl_complete_form(context, value, input):
    match input:
        case "A":
            addition_form.set_input_a(value)

        case "B":
            addition_form.set_input_b(value)

        # If an exact match is not confirmed, this last case will be used if provided
        case _:
            raise Exception(
                "The input field name should be A or B, not {}".format(input)
            )


@when("I click the 'Get Total' button")
def set_click_get_total(context):
    addition_form.get_total()


@when("I enter numbers into the 'a' and 'b' input fields and click the 'Get Total' button")
def step_impl_complete_form(context):
    addition_form.set_input_a("40")
    addition_form.set_input_b("2")


@then("I will see their sum")
def step_impl(context):
    print(addition_form.result())
    assert addition_form.result() == "42"


@then('I will see their sum: "{expected_sum}"')
def step_impl(context, expected_sum):
    print(addition_form.result())
    assert addition_form.result() == expected_sum
