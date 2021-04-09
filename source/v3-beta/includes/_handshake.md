# Handshake

[Handshake](https://handshake.org/) is a protocol which allows the creation of
update-able content with persistent links, backed by the Skynet infrastructure.
For more information on using Handshake with Skynet, please see [this blog
post](https://blog.sia.tech/skynet-handshake-d5d16e6b632f).

The SDKs contain support for downloading from Handshake domains as well as for
resolving Handshake domains to retrieve the underlying skylinks.

## Downloading Handshake Files

```shell--curl
curl -A "Sia-Agent" "https://siasky.net/hns/doesn"
```

```shell--cli
# NOTE: this function has not yet been implemented for this SDK.

skynet hns download "doesn" "./dst.html"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const domain = "doesn";

try {
  client.downloadFileHns(domain);
  // Or client.openFileHns(domain) to open it in a new browser tab.
} catch (error) {
  console.log(error);
}
```

```javascript--node
# NOTE: this function has not yet been implemented for this SDK.

const { SkynetClient } = require('@nebulous/skynet');

const client = new SkynetClient();
const domain = "doesn";

(async () => {
	await client.downloadFileHns("./dst.html", domain);
	console.log('Handshake download successful');
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

client = skynet.SkynetClient()
domain = "doesn"

client.download_file_hns("./dst.html", domain)
print("Handshake download successful")
```

```go
// NOTE: this function has not yet been implemented for this SDK.

package main

import (
	"fmt"
	skynet "github.com/SkynetHQ/go-skynet/v2"
)

var client = skynet.New()

func main() {
  const domain = "doesn"

	err := client.DownloadFileHns("./dst.html", domain, skynet.DefaultDownloadHnsOptions)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Handshake download successful")
}
```

This function downloads a file from a given Handshake domain on the portal's
`/hns` endpoint. To give an example, the full URL of the Sia-controlled
Handshake domain `doesn` is `https://siasky.net/hns/doesn`.

### Parameters

Field | Description
----- | -----------
`path` | The local path where the file should be downloaded to.
`domain` | The Handshake domain that should be downloaded.

*Browser JS:*

Field | Description
----- | -----------
`domain` | The Handshake domain that should be downloaded.

### Response

Empty on success.

## Resolving Handshake Domains

```shell--curl
curl -A "Sia-Agent" "https://siasky.net/hnsres/doesn"
```

```shell--cli
# NOTE: this function has not yet been implemented for this SDK.

skynet hns resolve "doesn"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const domain = "doesn";

try {
  const data = client.resolveHns(domain);
} catch (error) {
  console.log(error);
}
```

```javascript--node
# NOTE: this function has not yet been implemented for this SDK.

const { SkynetClient } = require('@nebulous/skynet');

const client = new SkynetClient();
const domain = "doesn";

(async () => {
	const data = await client.resolveHns(domain);
	console.log('Handshake resolve successful');
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

client = skynet.SkynetClient()
domain = "doesn"

data = client.resolve_hns(domain)
print("Handshake resolve successful")
```

```go
// NOTE: this function has not yet been implemented for this SDK.

package main

import (
	"fmt"
	skynet "github.com/SkynetHQ/go-skynet/v2"
)

const domain = "doesn"
var client = skynet.New()

func main() {
	err := client.ResolveHns(domain, skynet.DefaultResolveHnsOptions)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Handshake resolve successful")
}
```

This function resolves a given Handshake domain and returns its TXT record. In
the context of Skynet, this should contain a `skylink` field. For example, a
request to `https://siasky.net/hnsres/doesn` returns only the data
`{"skylink":"sia://IAC6CkhNYuWZqMVr1gob1B6tPg4MrBGRzTaDvAIAeu9A9w"}`.

### Parameters

Field | Description
----- | -----------
`domain` | The Handshake domain that should be resolved.

### Response

```shell--curl
{"skylink":"sia://IAC6CkhNYuWZqMVr1gob1B6tPg4MrBGRzTaDvAIAeu9A9w"}
```

```shell--cli
Coming Soon
```

```javascript--browser
{"skylink":"sia://IAC6CkhNYuWZqMVr1gob1B6tPg4MrBGRzTaDvAIAeu9A9w"}
```

```javascript--node
{"skylink":"sia://IAC6CkhNYuWZqMVr1gob1B6tPg4MrBGRzTaDvAIAeu9A9w"}
```

```python
{"skylink":"sia://IAC6CkhNYuWZqMVr1gob1B6tPg4MrBGRzTaDvAIAeu9A9w"}
```

```go
{"skylink":"sia://IAC6CkhNYuWZqMVr1gob1B6tPg4MrBGRzTaDvAIAeu9A9w"}
```

The full TXT record containing the skylink is returned.
