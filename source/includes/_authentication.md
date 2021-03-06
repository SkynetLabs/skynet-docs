# API Authentication

## Skynet Portal Authentication

```shell--curl
curl -X POST -H "Skynet-Api-Key: <token>" "https://skynetfree.net/skynet/skyfile"
```

```shell--cli
skynet upload image.jpg --skynet-api-key foobar
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

async function authenticationExample() {
  const { skylink } = await client.uploadFile(file, { skynetApiKey: "foobar" });
}
```

```javascript--node
const { SkynetClient } = require('@skynetlabs/skynet-nodejs');

const client = new SkynetClient();

(async () => {
	const skylink = await client.uploadFile("./image.jpg", { skynetApiKey: "foobar" });
	console.log(`Upload successful, skylink: ${skylink}`);
})();
```

```python
import siaskynet as skynet

client = skynet.SkynetClient()

skylink = client.upload_file("image.jpg", { "skynet_api_key": "foobar" })
print("Upload successful, skylink: " + skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetLabs/go-skynet/v2"
)

var client = skynet.New()

func main() {
	opts := skynet.DefaultUploadOptions
	opts.SkynetAPIKey = "foobar"
	skylink, err := client.UploadFile("./image.jpg", opts)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

Certain Skynet portals are only available to signed-in or paid users. To access
these programmatically, you will need an API key. You can get an API key for
your user and pass it either to individual calls or to the Skynet client.

**Warning:** Be careful not to leak your API key as it will allow malicious
attackers to compromise your account!

### Obtaining a Skynet API Key

[Instructions](https://docs.skynetlabs.com/developer-guides/server-hosted-skynet-usage#obtaining-your-skynet-api-key)

## Local Node Authentication

```shell--curl
curl -X POST -A "Sia-Agent" --user "":"foobar" \
  "https://siasky.net/skynet/skyfile" -F 'file=@image.jpg'
```

```shell--cli
skynet upload "./image.jpg" --api-key "foobar" --custom-user-agent "Sia-Agent"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

async function authenticationExample() {
  try {
    const { skylink } = await client.uploadFile(
      file,
      { APIKey: "foobar", customUserAgent: "Sia-Agent" }
    );
  } catch (error) {
    console.log(error);
  }
}
```

```javascript--node
const { SkynetClient } = require('@skynetlabs/skynet-nodejs');

const client = new SkynetClient();

(async () => {
	const skylink = await client.uploadFile(
    "./image.jpg",
    { APIKey: "foobar", customUserAgent: "Sia-Agent" }
  );
	console.log(`Upload successful, skylink: ${skylink}`);
})();
```

```python
import siaskynet as skynet

client = skynet.SkynetClient();

skylink = client.upload_file(
  "image.jpg",
  {"api_key": "foobar", "custom_user_agent": "Sia-Agent"}
)
print("Upload successful, skylink: " + skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetLabs/go-skynet/v2"
)

var client = skynet.New()

func main() {
	opts := skynet.DefaultUploadOptions
	opts.APIKey = "foobar"
  opts.CustomUserAgent = "Sia-Agent"
	skylink, err := client.UploadFile("./image.jpg", opts)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

<aside class="warning">
This option is for users who are running their own Skynet node (skyd instance)
locally. This option is not related to skynetApiKey which authenticates with
portals (not single nodes). You should probably be using that option, instead.
</aside>

When making requests to a locally-running Skynet node (`skyd` instance), you may
authenticate yourself by setting the `APIKey` custom option. You would have to
set the portal to localhost.

### Setting The User Agent

The node may also require that certain sensitive requests contain a custom
user agent header, usually `Sia-Agent`. This is for security purposes, as
otherwise a malicious website could make requests to your local portal on your
behalf and steal coins.

We want this to be an opt-in for now, so `Sia-Agent` is not currently the
default. You may change the user agent header by setting the `customUserAgent`
custom option. See [Setting Additional Options](#setting-additional-options).

### More Information

For more information about authentication on local `skyd` instances please see
[the Sia Docs](https://sia.tech/docs/#authentication).
