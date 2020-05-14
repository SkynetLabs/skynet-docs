---
title: Skynet Docs

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python
  - go

toc_footers:
  # - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - skyfile
  - skylink
  - encryption
  - blacklist
  - portals
  - statistics
  - responses

search: true
---

# Introduction

Welcome to the Skynet SDK docs!

We have language bindings in Shell, Python, JavaScript and Go! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.

This example API documentation page was created with [Slate](https://github.com/slatedocs/slate). Feel free to edit it and use it as a base for your own API's documentation.


# Authentication

```shell
// example POST curl call with Authentication
curl -A "Sia-Agent" --user "":<apipassword> --data "amount=123&destination=abcd" "localhost:9980/wallet/siacoins"
```

API authentication is enabled by default, using a password stored in a flat
file. The location of this file is:

 - Linux:   `$HOME/.sia/apipassword`
 - MacOS:   `$HOME/Library/Application Support/Sia/apipassword`
 - Windows: `%LOCALAPPDATA%\Sia\apipassword`

<aside class="notice">
The file contains a trailing newline, which must be trimmed before use.
</aside>

Authentication is HTTP Basic Authentication as described in [RFC 2617](https://tools.ietf.org/html/rfc2617), however, the username is the empty string. The flag does not enforce authentication on all API endpoints. Only endpoints that expose sensitive information or modify state require authentication.

For example, if the API password is "foobar" the request header should include

`Authorization: Basic OmZvb2Jhcg==`

And for a curl call the following would be included

`--user "":<apipassword>`

Authentication can be disabled by passing the `--authenticate-api=false` flag to
siad. You can change the password by modifying the password file, setting the
`SIA_API_PASSWORD` environment variable, or passing the `--temp-password` flag
to siad.
