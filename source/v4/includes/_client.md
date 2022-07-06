# Using The Skynet Client

The Skynet Client is required to make any API calls. It sets the portal that
will be used for all requests. It can also be initialized with custom connection
options that will be applied in all calls, unless calling an API method with the
same options (which then take precedent and override what was set in client
initialization).

## Basic Portal Selection

```shell--curl
No client available.
```

```shell--cli
No client available.
```

```javascript--browser
import { SkynetClient } from "skynet-js";

// Or SkynetClient() without arguments to use the default portal.
const client = new SkynetClient("https://some-other-portal.xyz");
```

```javascript--node
const { SkynetClient } = require('@skynetlabs/skynet-nodejs');

// Or SkynetClient() without arguments to use the default portal.
const client = new SkynetClient("https://some-other-portal.xyz");
```

```python
import siaskynet as skynet

# Or SkynetClient() without arguments to use the default portal.
client = skynet.SkynetClient("https://some-other-portal.xyz")
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetLabs/go-skynet/v2"
)

var client = skynet.NewCustom("https://some-other-portal.xyz", skynet.Options{})
```

To make any API calls you will need to first create a new client with the
desired portal. The client can be initialized without arguments to let the
client choose it for you (see below) or the portal can be specified. See the
code example on the right.

## Default Portal Selection

The default portal used is `https://siasky.net` for all SDKs *except Browser
JS*, which tries to use the portal which is running the sky app. The default
portal is accessible through the exported function, `defaultPortalUrl`, and no
configuration is required to use it. Having a reasonable choice already selected
keeps friction for new developers low.

In the future the default selection will be smarter and there will be more
options for default portal selection, such as configuration files. Please see
[this issue](https://github.com/SkynetLabs/skynet-docs/issues/5).

## Setting Connection Options

```shell--curl
No client available.
```

```shell--cli
No client available.
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient("", { skynetApiKey: "foobar" });
```

```javascript--node
const { SkynetClient } = require('@skynetlabs/skynet-nodejs');

const client = new SkynetClient("", { skynetApiKey: "foobar" });
```

```python
import siaskynet as skynet

client = skynet.SkynetClient("", { "skynet_api_key": "foobar" })
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetLabs/go-skynet/v2"
)

var client = skynet.NewCustom("", skynet.Options{ SkynetAPIKey: "foobar" })
```

Apart from setting a persistent portal, client initialization also allows you to
choose persistent connection settings. These will be applied on every subsequent
API call using the client, unless the setting is overridden in a particular
call.

For example, in the code samples we initialize a client with a Skynet API key
that is applied on every request made by the client. See [API
Authentication](#api-authentication).

Please also see [Setting Additional Options](#setting-additional-options).

<aside class="notice">
To set custom connection options while using the default portal, set the portal
value to <code>""</code>.
</aside>
