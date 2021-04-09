# Getting Started

## Making Your First API Call

```shell--curl
curl -L -X POST "https://siasky.net/skynet/skyfile/<siapath>" -F 'file=@image.jpg'
```

```shell--cli
skynet upload "./image.jpg"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

// Assume we have a file from an input form.

async function uploadExample() {
  try {
    const skylink = await client.uploadFile(file);
    console.log(`Upload successful, skylink: ${skylink}`);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
const { SkynetClient } = require('@nebulous/skynet');

const client = new SkynetClient();

(async () => {
	const skylink = await client.uploadFile("./image.jpg");
	console.log(`Upload successful, skylink: ${skylink}`);
})();
```

```python
import siaskynet as skynet

client = skynet.SkynetClient()

skylink = client.upload_file("image.jpg")
print("Upload successful, skylink: " + skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetHQ/go-skynet/v2"
)

var client = skynet.New()

func main() {
	skylink, err := client.UploadFile("./image.jpg", skynet.DefaultUploadOptions)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

The SDKs are set up to be as simple as possible. Despite the many options for
configuration, most users will be able to get started with a single API call. In
the example on the right, we upload the file `image.jpg` to the default Skynet
portal (which in Browser JS is the portal running the code and in other SDKs is
`https://siasky.net`).

**Note:** If you are testing or running a Browser JS app locally, you will
either have to run a Skynet portal locally or initialize the Skynet Client to
connect to an existing portal such as `https://siasky.net`. See [Portal
Selection](#portal-selection) below.

## Skynet Client

The above examples also demonstrate the use of the Skynet client. This client is
required to make any API calls. It sets the portal that will be used for all
requests. It can also be initialized with custom connection options that will
be applied in all calls, unless calling an API method with the same options,
which then take precedent and override what was set in client initialization.

Please see [Using The Skynet Client](#using-the-skynet-client) for more information.

## Portal Selection

In order to use a specific portal, you will need to use it as the first argument
in client creation. Please see [Basic Portal Selection](#basic-portal-selection)
for more information.

## Setting Additional Options

Each SDK function also accepts additional options. These vary depending on the
endpoint and are documented alongside each function.

<aside class="warning">
The SDKs are actively being worked on, and so far not every additional option
has been implemented in every SDK.
</aside>

<aside class="notice">
The additional options object is optional in most SDKs but mandatory in Go. See
<a href="#function-parameters">Function Parameters</a>.
</aside>

### Common Options

```javascript--browser
import { SkynetClient } from "skynet-js";

// Set a custom user agent.
const customUserAgent = "Sia-Agent";

// Set an upload progress tracker.
const onUploadProgress = (progress, { loaded, total }) => {
  console.info(`Progress ${Math.round(progress * 100)}%`);
};

// Initialize the client.
const client = new SkynetClient("https://siasky.net", { customUserAgent, onUploadProgress });

async function uploadExample() {
  try {
    const skylink = await client.uploadFile(file);
  } catch (error) {
    console.log(error);
  }
}
```

Every function accepts the following common options:

Option | Description | Default
------ | ----------- | -------
`APIKey` | The API password used for [authentication](#api-authentication). | `""`
`customUserAgent` | Allows changing the User Agent, as some portals may reject user agents that are not `Sia-Agent` for security reasons. | `""`
`onUploadProgress` | Optional callback to track upload progress. | undefined

## Useful Constants

Here are some constants exported by the SDKs which may be of use in applications.

Constant | Description | Default
-------- | ----------- | -------
`defaultSkynetPortalUrl` | The default Skynet portal to use, if one is not provided. | `"https://siasky.net"`
`uriSkynetPrefix` | The Skynet URI prefix. | `"sia://"`
