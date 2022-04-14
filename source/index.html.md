---
title: Skynet Docs

language_tabs: # must be one of https://git.io/vQNgJ
  - shell--curl: curl
  - shell--cli: CLI
  - javascript--browser: Browser JS
  - javascript--node: NodeJS
  - python: Python
  - go: Go

toc_footers:
  - "Version: v4"
  - <a href='v4'>Permalink to this version</a>
  - <a href='v3'>Previous version</a>
  - ---
  - <a href='https://siasky.net/'>Check out Skynet!</a>
  - <a href='https://github.com/SkynetLabs/skynet-docs'>Contribute to the docs</a>
  - ---
  - <a href='https://github.com/slatedocs/slate'>Powered by Slate</a>

includes:
  - gettingstarted
  - client
  - uploading
  - downloading
  - skydb
  - registry
  - mysky
  - crypto-utilities
  - handshake
  - browser-js-api
  - authentication
  - updating

search: true
---

# Introduction

**Latest version:** <a href='v4'>v4</a> ([Update Guide](v4#updating-from-v3))

Welcome to the Skynet SDK API reference docs!

To **learn more about Skynet**, see the [Skynet support docs](https://support.siasky.net/).

For **developer guides**, see the [Skynet developer docs](https://docs.siasky.net/).

## Languages

<aside class="warning">
As of April 2022 the non-JS SDKs are still under heavy construction. Use the JS
libraries for the best experience.
</aside>

We have SDK support for several languages:

- Shell (using curl). See the [Using The Shell](#using-the-shell) section.
- [Browser JS](https://github.com/SkynetLabs/skynet-js) **(most up-to-date)**
- [NodeJS](https://github.com/SkynetLabs/nodejs-skynet) (missing SkyDB and MySky but mostly featureful)
- [Python](https://github.com/SkynetLabs/python-skynet) (basic functionality only)
- [Go](https://github.com/SkynetLabs/go-skynet) (basic functionality only)
- [Skynet CLI](https://github.com/SkynetLabs/skynet-cli) (written in Go, basic functionality only).

Full documentation for the Skynet HTTP API can be found in the [Sia API
Documentation](https://sia.tech/docs/#skynet).

<aside class="success">
You can view code examples in the dark area to the right. Switch to the
programming language of your choice by clicking the tabs in the top right.
</aside>

## Tutorial

We have a detailed tutorial for [Creating Your First Webapp On
Skynet](https://blog.sia.tech/creating-your-first-web-app-on-skynet-ec6f4fff405f)
on our tech blog. Check it out if you are just starting out!

See also our [developer docs](https://docs.siasky.net/) for more guides.

## Using the Beta

We are releasing new features and fixes first on the `beta` stream. The latest
beta version can be installed with `npm install skynet-js@beta`.

## A Note About Language Differences

Though we tried to keep the SDKs as similar to each other as possible in usage,
differences between the languages -- the idiosyncracies and best practices of
each -- resulted in differences between the SDKs. We've noted them where
necessary throughout the documentation.

### Function Parameters

In most of the SDKs the additional options may be left out of the function
calls, in which case the default options are used. In <b>Go</b> the options must
always be passed in, as the language does not support optional function
parameters.

### Case

Note that the casing of functions and their parameters differs between the
languages:

Language | Case
-------- | ----
Javascript | [`camelCase`](https://en.wikipedia.org/wiki/Camel_case)
Python | [`snake_case`](https://en.wikipedia.org/wiki/Snake_case)
Go | [`PascalCase`](https://en.wikipedia.org/wiki/PascalCase)

For consistency throughout this document, functions and their parameters are
documented using `camelCase`.

### Standard Responses

Functions will respond with the desired content on success and with errors or
exceptions on failure. The error messages may contain HTTP status codes (see
[the Sia Docs](https://sia.tech/docs/#standard-responses)).

Functions will fail differently in each SDK depending on the language:

Language | Failure Mode
-------- | ------------
Javascript | Exceptions are raised and must be caught with a `try-catch` block.
Python | Same as above.
Go | Errors are returned and must be checked for explicitly.

## Using The Shell

```shell
function skynet() {
  curl -X POST "https://siasky.net/skynet/skyfile" -F "file=@$1" \
    | jq ".skylink" | xargs -I _ echo "https://siasky.net/_"
}
```

Our shell examples present only simple curl calls. You may find it helpful to
write wrappers around these in Bash, or the shell language of your choice, to
make them more reusable. To the right we have provided a simple example which
uses [`jq`](https://stedolan.github.io/jq/).
