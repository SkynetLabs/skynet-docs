# Skynet SDK Docs

Documentation for the Skynet SDKs in various languages:

- Shell (using curl)
- [Browser JS](https://github.com/SkynetLabs/skynet-js)
- [NodeJS](https://github.com/SkynetLabs/nodejs-skynet)
- [Python](https://github.com/SkynetLabs/python-skynet)
- [Go](https://github.com/SkynetLabs/go-skynet)

as well as the [Skynet CLI](https://github.com/SkynetLabs/skynet-cli) (written in Go).

Unofficial SDKs are not documented here.

## Status of SDKs

Please see [here](https://hackmd.io/@5HZOdvckTSSTaM7aLUxJ-A/Sk_c3qv6U) for the current status of the SDKs.

## Contributing

To contribute to the docs, you should only directly modify the `source/index.html.md` file and/or any files in `source/includes/`.

Make sure you run `./update-latest.sh` before making changes. This sets up a hook that ensures that the permanent link files also get updated when you commit. For example, if the latest version is `v2` and you made changes to `source/index.html.md`, the hook ensures that the changes are propogated to `source/v2/index.html.md`. These changes should also be committed.

See [Skynet SDK Publishing](https://hackmd.io/JG31576YSlO29Dj4gLkDsA?view#skynet-docs) for more info.

## Building the docs

For information on building the docs using [Slate](https://github.com/slatedocs/slate) see [here](https://github.com/slatedocs/slate/wiki#getting-started).
