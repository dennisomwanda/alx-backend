#!/usr/bin/env python3
'''Task 4: Force locale with URL parameter
'''

from typing import Dict, Union
from flask import Flask, render_template, request, g
from flask_babel import Babel


class Config:
    '''Config class'''

    DEBUG = True
    LANGUAGES = ["en", "fr"]
    BABEL_DEFAULT_LOCALE = "en"
    BABEL_DEFAULT_TIMEZONE = "UTC"


app = Flask(__name__)
app.config.from_object(Config)
app.url_map.strict_slashes = False
babel = Babel(app)

users = {
    1: {"name": "Balou", "locale": "fr", "timezone": "Europe/Paris"},
    2: {"name": "Beyonce", "locale": "en", "timezone": "US/Central"},
    3: {"name": "Spock", "locale": "kg", "timezone": "Vulcan"},
    4: {"name": "Teletubby", "locale": None, "timezone": "Europe/London"},
}


def get_user() -> Union[Dict, None]:
    """Retrieves a user based on a user id.
    """
    login_id = request.args.get('login_as')
    if login_id:
        return users.get(int(login_id))
    return None


@app.before_request
def before_request() -> None:
    """Performs some routines before each request's resolution.
    """

    g.user = get_user()


#@babel.localeselector
def get_locale() -> str:
    """Retrieves the locale for a web page.
    Returns:
        str: best match
    """
    locale = request.args.get('locale')
    if locale in app.config['LANGUAGES']:
        return locale
    return request.accept_languages.best_match(app.config['LANGUAGES'])


@app.route('/')
def index() -> str:
    '''default route
    Returns:
        html: homepage
    '''
    return render_template("5-index.html")

# uncomment this line and comment the @babel.localeselector
# you get this error:
# AttributeError: 'Babel' object has no attribute 'localeselector'
babel.init_app(app, locale_selector=get_locale)


if __name__ == "__main__":
    app.run()
 4 changes: 2 additions & 2 deletions4  
0x02-i18n/templates/4-index.html
@@ -1,9 +1,9 @@
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Welcome to Holberton</title>
    <title>{{ _('home_title') }}</title>
</head>
<body>
    <h1>Hello world</h1>
    <h1>{{ _('home_header') }}</h1>
</body>
</html>
 17 changes: 17 additions & 0 deletions17  
0x02-i18n/templates/5-index.html
@@ -0,0 +1,17 @@
<!DOCTYPE html>
<html lang="en">
<head>
    <title>{{ _('home_title') }}</title>
</head>
<body>
    <h1>{{ _('home_header') }}</h1>

    <p>
        {% if g.user %}
            {{ _('logged_in_as', username=g.user.name) }}
        {% else %}
            {{ _('not_logged_in') }}
        {% endif %}
    </p>
</body>
</html>
  11 changes: 6 additions & 5 deletions11  
0x02-i18n/translations/en/LC_MESSAGES/messages.po
@@ -18,17 +18,18 @@ msgstr ""
"Content-Transfer-Encoding: 8bit\n"
"Generated-By: Babel 2.12.1\n"

#: templates/3-index.html:4 templates/4-index.html:4 templates/5-index.html:4
msgid "home_title"
msgstr "Welcome to Holberton"

#: templates/3-index.html:7 templates/4-index.html:7 templates/5-index.html:7
msgid "home_header"
msgstr "Hello world!"

msgid "logged_in_as"
msgstr "You are logged in as %(username)s."

#: templates/5-index.html:11
msgid "not_logged_in"
msgstr "You are not logged in."

msgid "current_time_is"
msgstr "The current time is %(current_time)s."
#: templates/5-index.html:13
msgid "logged_in_as"
msgstr "You are logged in as %(username)s."
  11 changes: 6 additions & 5 deletions11  
0x02-i18n/translations/fr/LC_MESSAGES/messages.po
@@ -18,17 +18,18 @@ msgstr ""
"Content-Transfer-Encoding: 8bit\n"
"Generated-By: Babel 2.12.1\n"

#: templates/3-index.html:4 templates/4-index.html:4 templates/5-index.html:4
msgid "home_title"
msgstr "Bienvenue chez Holberton"

#: templates/3-index.html:7 templates/4-index.html:7 templates/5-index.html:7
msgid "home_header"
msgstr "Bonjour monde!"

msgid "logged_in_as"
msgstr "Vous êtes connecté en tant que %(username)s."

#: templates/5-index.html:11
msgid "not_logged_in"
msgstr "Vous n'êtes pas connecté."

msgid "current_time_is"
msgstr "Nous sommes le %(current_time)s."
#: templates/5-index.html:13
msgid "logged_in_as"
msgstr "Vous êtes connecté en tant que %(username)s."
