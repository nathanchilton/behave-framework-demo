from behave import *
from dotmap import DotMap
from assertpy import assert_that
from playwright.sync_api import Page
import requests, re, json, jsonschema

# Karate-style step definitions


@step("url {url}")
def step_impl(context, url):
    context.request_url = remove_outer_quotes(url)


@step("path {path}")
def step_impl(context, path):
    if not "request_url" in context:
        raise Exception(
            'You must use "url" to define a "base url" before adding a "path".'
        )
    else:
        context.request_url += remove_outer_quotes(path)


@step("header {key} = {value}")
def step_impl(context, key, value):
    if not hasattr(context, "request_headers"):
        context.request_headers = {"Content-type": "application/json; charset=UTF-8"}
    context.request_headers[key] = value


@step("request")
def step_impl(context):
    request_body = context.text
    if "context." in request_body:
        request_body = eval(request_body)
    try:
        context.request_body = json.loads(request_body)
    except:
        context.request_body = request_body


@step("method {method_name}")
def step_impl(context, method_name):
    context.method_name = method_name
    data = getattr(context, "request_body", "")
    if type(data) is dict:
        data = json.dumps(data)
    headers = getattr(context, "request_headers", {"Content-Type": "application/json"})
    cookies = getattr(context, "request_cookies", "")

    match method_name.upper():
        case "GET":
            print(f'I recognize the method: "{method_name}"')
            context.response = requests.get(context.request_url, headers=headers)
        case "POST":
            print(f'I recognize the method: "{method_name}"')
            context.response = requests.post(
                context.request_url,
                headers=headers,
                cookies=cookies,
                data=data,
                allow_redirects=False,
            )
        case "PUT":
            print(f'I recognize the method: "{method_name}"')
            context.response = requests.put(
                context.request_url, headers=headers, data=data
            )
        case "PATCH":
            print(f'I recognize the method: "{method_name}"')
            context.response = requests.patch(
                context.request_url, headers=headers, data=data
            )
        case "DELETE":
            print(f'I recognize the method: "{method_name}"')
            context.response = requests.delete(
                context.request_url, headers=headers, data=data
            )
        case _:
            raise (f"A method of {method_name} is not supported.")


@step("status {status_code}")
def step_impl(context, status_code):
    assert_that(str(context.response.status_code)).is_equal_to(status_code)


def remove_outer_quotes(string_value):
    # if the string_value is a string, surrounded by double quotes
    m = re.search('^"(.+)"$', string_value)
    if m:
        # set string_value to be just the part between the double quotes
        string_value = m.group(1)

    # if the string_value is a string, surrounded by single quotes
    m = re.search("^'(.+)'$", string_value)
    if m:
        # set string_value to be just the part between the single quotes
        string_value = m.group(1)

    return string_value


def transform_expected_value(expected_value, context):
    if "context." in expected_value:
        expected_value = eval(expected_value)
    else:
        # assume it is a string, if it contains either single or double quotes
        if re.search("['\"]", expected_value):
            expected_value = remove_outer_quotes(expected_value)
        # cast expected_value into a numeric type, if appropriate
        else:
            if "." in expected_value:
                expected_value = float(expected_value)
            else:
                expected_value = int(expected_value)

    return expected_value


def check_type(value, type):
    match type:
        case "#number":
            assert_that(value).is_not_nan()
        case _:
            raise Exception(f"We do not yet support a type of '{type}'")


@step("assert response.{dot_map_value} == {expected_value}")
def step_impl(context, dot_map_value, expected_value):
    response = DotMap(json.loads(context.response.text))

    left_side = f"response.{dot_map_value}"
    if left_side.endswith(".length"):
        left_side = f"len({left_side.removesuffix('.length')})"

    left_side = eval(left_side)

    if expected_value == "null":
        assert_that(left_side).is_none()
    else:
        expected_value = transform_expected_value(expected_value, context)

        if type(expected_value) is str and expected_value.startswith("#"):
            check_type(left_side, expected_value)
        else:
            assert_that(left_side).is_equal_to(expected_value)


@step("assert response{dot_path} should not be present")
def step_impl(context, dot_path):
    response = DotMap(json.loads(context.response.text))
    key = f"response{dot_path}".split(".")[-1]
    parent = f"response{dot_path}".removesuffix(f".{key}")
    if eval(f"'{key}' in {parent}"):
        raise Exception(f"{parent} contains {key}!")


@step('string context.{variable_name} = read("{file_path}")')
def step_impl(context, variable_name, file_path):
    setattr(context, variable_name, open(file_path).read())


@step("text context.{variable_name}")
def step_impl(context, variable_name):

    # see if an equals symbol was specified, after the variable name
    parts = variable_name.split("=")

    if len(parts) > 1:
        # remove the equals symbol from the variable_name
        variable_name = parts[0].strip()

        # if there is a value to the right of the equals sign, use it
        if len(parts[1].strip()) > 0:
            value = remove_outer_quotes(parts[1].strip())

    # otherwise, get the value from the "Doc String"
    value = locals().get("value", context.text)

    setattr(context, variable_name, value)


@step("def context.{variable_name} = {evaluate_as_code}")
def step_impl(context, variable_name, evaluate_as_code):
    setattr(context, variable_name, eval(evaluate_as_code))


@step("print {evaluate_as_code}")
def step_impl(context, evaluate_as_code):
    if evaluate_as_code == "response":
        evaluate_as_code = "context.response.text"
    if evaluate_as_code == "status":
        evaluate_as_code = f'"status_code: {context.response.status_code}"'
    eval(f"print({evaluate_as_code})")


@step("breakpoint")
def step_impl(context):
    # Set a breakpoint on the next line
    True


@step("validate {json_object_name} using jsonschema in {json_schema_name}")
def step_impl(context, json_object_name, json_schema_name):
    from jsonschema import validate, ValidationError, SchemaError

    response = DotMap(json.loads(context.response.text))

    json_object = eval(json_object_name)
    if type(json_object) is DotMap:
        json_object = json_object.toDict()
    if type(json_object) is list and type(json_object[0]) is DotMap:
        json_object = list(map(lambda x: x.toDict(), json_object))

    json_schema = eval(json_schema_name)
    # if type(json_schema) is str:
    json_schema = json.loads(json_schema)

    validate(json_object, json_schema)
