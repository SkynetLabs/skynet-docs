
# API Authentication

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
