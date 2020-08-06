# Getting Started

## Making Your First API Call

```shell--curl
curl -X POST "https://siasky.net/skynet/skyfile" -F file=@image.jpg
```

```shell--cli
skynet upload "./image.jpg"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

// Assume we have a file from an input form.

async function uploadExample() {
  try {
    const client = new SkynetClient();
    const { skylink } = await client.upload(file);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const skylink = await skynet.uploadFile("./image.jpg");
	console.log(`Upload successful, skylink: ${skylink}`);
})();
```

```python
import siaskynet as skynet

skylink = skynet.upload_file("image.jpg")
print("Upload successful, skylink: " + skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	skylink, err := skynet.UploadFile("./image.jpg", skynet.DefaultUploadOptions)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

The SDKs are set up to be as simple as possible. Despite the many options for
configuration, most users will be able to get started with a single API call. In
the example on the right, we upload the file `image.jpg` to the default Skynet
portal, `https://siasky.net`.

## Using A Different Portal

The default portal used is `https://siasky.net` for all SDKs *except Browser
JS*, which tries to use the portal which is running the sky app. The default
portal is accessible through the exported function, `defaultPortalUrl`, and no
configuration is required to use it. Having a reasonable choice already selected
keeps friction for new developers low. However, as Skynet is a decentralized
project, it is also possible to use different portals.

In every SDK *except Browser JS*, a different portal can be passed in as part of
the options for each function. See [Setting Additional
Options](.#setting-additional-options).

### Browser JS

```javascript--browser
import SkynetClient from "skynet-js";

// Or SkynetClient() without arguments to use the default portal.
const client = new SkynetClient("https://some-other-portal.xyz");

async uploadExample() {
  try {
    const { skylink } = await client.upload(file);
  } catch (error) {
    console.log(error)
  }
}
```

In Browser JS you will need to first create a new client with the desired
portal. The client can be initialized without arguments to use the default
portal URL or the portal can be specified. See the code example on the right.

## Setting Additional Options

<aside class="warning">
The SDKs are actively being worked on, and so far not every additional option
has been implemented in every SDK.
</aside>

Each SDK function also accepts additional options. These vary depending on the
endpoint and are documented alongside each function.

<aside class="notice">
In most of our SDKs the additional options may be left out of the function
calls, in which case the default options are used. In <b>Go</b> the options must
always be passed in, as the language does not support optional function
parameters.
</aside>

### Common Options

Every function accepts the following common options:

Option | Description | Default
------ | ----------- | -------
`portalUrl` | The URL of the portal. *(Not available in Browser JS)* | `"https://siasky.net"`
`endpointPath` | The relative path on the portal where the endpoint may be found for the function being called. Some portals, for example, may offer alternate download paths. | `""`
`customUserAgent` | This option is available to change the User Agent, as some portals may reject user agents that are not `Sia-Agent` for security reasons. | `""`

## Useful Constants

Here are some constants exported by the SDKs which may be of use in applications.

Constant | Description | Default
-------- | ----------- | -------
`defaultPortalUrl` | The default Skynet portal to use, if one is not provided. | `"https://siasky.net"`
`uriSkynetPrefix` | The Skynet URI prefix. | `"sia://"`
