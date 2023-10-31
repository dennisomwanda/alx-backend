#!/usr/bin/env python3
'''Task 2: Get locale from request
'''

from flask import Flask, render_template, request
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


@babel.localeselector
def get_locale() -> str:
    """Retrieves the locale for a web page.
    Returns:
        str: best match
    """
    return request.accept_languages.best_match(app.config['LANGUAGES'])


@app.route('/')
def index() -> str:
    '''default route
    Returns:
        html: homepage
    '''
    return render_template("2-index.html")

# uncomment this line and comment the @babel.localeselector
# you get this error:
# AttributeError: 'Babel' object has no attribute 'localeselector'
# babel.init_app(app, locale_selector=get_locale)


if __name__ == "__main__":
    app.run()
  66 changes: 66 additions & 0 deletions66  
0x02-i18n/README.md
@@ -28,3 +28,69 @@ First you will setup a basic Flask app in `0-app.py`. Create a single `/` route

solution - [0-app.py](./0-app.py), [templates/0-index.html](./templates/0-index.html)

### 1. Basic Babel setup

Install the Babel Flask extension:

```bash
pip3 install flask_babel
```

Then instantiate the `Babel` object in your app. Store it in a module-level variable named `babel`.

In order to configure available languages in our app, you will create a `Config` class that has a `LANGUAGES` class attribute equal to `["en", "fr"]`.

Use `Config` to set Babel’s default locale (`"en"`) and timezone (`"UTC"`).

Use that class as config for your Flask app.

solution - [1-app.py](./1-app.py), [templates/1-index.html](./templates/1-index.html)

### 2. Get locale from request

Create a `get_locale` function with the `babel.localeselector` decorator. Use `request.accept_languages` to determine the best match with our supported languages.

solution - [2-app.py](./2-app.py), [templates/2-index.html](./templates/2-index.html)

### 3. Parametrize templates

Use the `_` or `gettext` function to parametrize your templates. Use the message IDs `home_title` and `home_header`.

Create a `babel.cfg` file containing

```
[python: **.py]
[jinja2: **/templates/**.html]
extensions=jinja2.ext.autoescape,jinja2.ext.with_
```

Then initialize your translations with

```shell
$ pybabel extract -F babel.cfg -o messages.pot .
```

and your two dictionaries with

```shell
$ pybabel init -i messages.pot -d translations -l en
$ pybabel init -i messages.pot -d translations -l fr
```

Then edit files `translations/[en|fr]/LC_MESSAGES/messages.po `to provide the correct value for each message ID for each language. Use the following translations:

| msgid | English | French |
| ----- | ------- | ------ |
| home_title | "Welcome to Holberton" | "Bienvenue chez Holberton" |
| home_header | "Hello world!" | "Bonjour monde!" |

Then compile your dictionaries with

```
$ pybabel compile -d translations
```

Reload the home page of your app and make sure that the correct messages show up.


 5 changes: 5 additions & 0 deletions5  
0x02-i18n/babel.cfg
@@ -0,0 +1,5 @@
[python: **.py]
[jinja2: **/templates/**.html]

# for jinja2 versions >= 3.x.x
# extensions=jinja2.ext.autoescape,jinja2.ext.with_
 19 changes: 19 additions & 0 deletions19  
0x02-i18n/messages.pot
@@ -0,0 +1,19 @@
# Translations template for PROJECT.
# Copyright (C) 2023 ORGANIZATION
# This file is distributed under the same license as the PROJECT project.
# FIRST AUTHOR <EMAIL@ADDRESS>, 2023.
#
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: PROJECT VERSION\n"
"Report-Msgid-Bugs-To: EMAIL@ADDRESS\n"
"POT-Creation-Date: 2023-03-01 19:22+0100\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language-Team: LANGUAGE <LL@li.org>\n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=utf-8\n"
"Content-Transfer-Encoding: 8bit\n"
"Generated-By: Babel 2.12.1\n"

 9 changes: 9 additions & 0 deletions9  
0x02-i18n/templates/3-index.html
@@ -0,0 +1,9 @@
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Welcome to Holberton</title>
</head>
<body>
    <h1>Hello world</h1>
</body>
</html>
 Binary file addedBIN +721 Bytes 
0x02-i18n/translations/en/LC_MESSAGES/messages.mo
Binary file not shown.
 34 changes: 34 additions & 0 deletions34  
0x02-i18n/translations/en/LC_MESSAGES/messages.po
@@ -0,0 +1,34 @@
# English translations for PROJECT.
# Copyright (C) 2023 ORGANIZATION
# This file is distributed under the same license as the PROJECT project.
# FIRST AUTHOR <EMAIL@ADDRESS>, 2023.
#
msgid ""
msgstr ""
"Project-Id-Version: PROJECT VERSION\n"
"Report-Msgid-Bugs-To: EMAIL@ADDRESS\n"
"POT-Creation-Date: 2023-03-01 19:22+0100\n"
"PO-Revision-Date: 2023-03-01 19:23+0100\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language: en\n"
"Language-Team: en <LL@li.org>\n"
"Plural-Forms: nplurals=2; plural=(n != 1);\n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=utf-8\n"
"Content-Transfer-Encoding: 8bit\n"
"Generated-By: Babel 2.12.1\n"

msgid "home_title"
msgstr "Welcome to Holberton"

msgid "home_header"
msgstr "Hello world!"

msgid "logged_in_as"
msgstr "You are logged in as %(username)s."

msgid "not_logged_in"
msgstr "You are not logged in."

msgid "current_time_is"
msgstr "The current time is %(current_time)s."
 Binary file addedBIN +738 Bytes 
0x02-i18n/translations/fr/LC_MESSAGES/messages.mo
Binary file not shown.
 34 changes: 34 additions & 0 deletions34  
0x02-i18n/translations/fr/LC_MESSAGES/messages.po
@@ -0,0 +1,34 @@
# French translations for PROJECT.
# Copyright (C) 2023 ORGANIZATION
# This file is distributed under the same license as the PROJECT project.
# FIRST AUTHOR <EMAIL@ADDRESS>, 2023.
#
msgid ""
msgstr ""
"Project-Id-Version: PROJECT VERSION\n"
"Report-Msgid-Bugs-To: EMAIL@ADDRESS\n"
"POT-Creation-Date: 2023-03-01 19:22+0100\n"
"PO-Revision-Date: 2023-03-01 19:23+0100\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language: fr\n"
"Language-Team: fr <LL@li.org>\n"
"Plural-Forms: nplurals=2; plural=(n > 1);\n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=utf-8\n"
"Content-Transfer-Encoding: 8bit\n"
"Generated-By: Babel 2.12.1\n"

msgid "home_title"
msgstr "Bienvenue chez Holberton"

msgid "home_header"
msgstr "Bonjour monde!"

msgid "logged_in_as"
msgstr "Vous êtes connecté en tant que %(username)s."

msgid "not_logged_in"
msgstr "Vous n'êtes pas connecté."

msgid "current_time_is"
msgstr "Nous sommes le %(current_time)s."
