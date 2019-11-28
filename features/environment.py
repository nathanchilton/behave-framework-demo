from framework.browser_factory import get_browser_driver

def before_all(context):
    context.browser = get_browser_driver(context.config.userdata['browser'])

def after_all(context):
    context.browser.quit()
