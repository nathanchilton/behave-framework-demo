from behave import *
import time
from playwright.sync_api import sync_playwright


def before_all(context):

    playwright = sync_playwright().start()
    context.playwright = playwright

    context.browser = playwright.chromium.launch(headless=False)


def before_tag(context, tag):
    if tag.lower() == "ui":
        context.browser_context = context.browser.new_context()
        context.page = context.browser_context.new_page()


def after_tag(context, tag):
    if tag.lower() == "ui":
        context.browser_context.close()


def after_all(context):
    context.playwright.stop()
