from behave import *
import time
from playwright.sync_api import sync_playwright


def before_all(context):
    playwright = sync_playwright().start()
    context.playwright = playwright

    browser_ = playwright.chromium.launch(headless=False)
    context_ = browser_.new_context()
    context.page = context_.new_page()


def after_all(context):
    context.playwright.stop()
