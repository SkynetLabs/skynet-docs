# API Authentication

```shell--curl
curl -X POST -A "Sia-Agent" --user "":"foobar" \
  "https://siasky.net/skynet/skyfile" -F file=@image.jpg
```

```shell--cli
skynet upload "./image.jpg" --api-key "foobar" --custom-user-agent "Sia-Agent"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

async function authenticationExample() {
  try {
    const { skylink } = await client.upload(
      file,
      { APIKey: "foobar", customUserAgent: "Sia-Agent" }
    );
  } catch (error) {
    console.log(error);
  }
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const skylink = await skynet.uploadFile(
    "./image.jpg",
    { APIKey: "foobar", customUserAgent: "Sia-Agent" }
  );
	console.log(`Upload successful, skylink: ${skylink}`);
})();
```

```python
import siaskynet as skynet

skylink = skynet.upload_file(
  "image.jpg",
  {"api_key": "foobar", "custom_user_agent": "Sia-Agent"}
)
print("Upload successful, skylink: " + skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetLabs/go-skynet"
)

func main() {
	opts := skynet.DefaultUploadOptions
	opts.APIKey = "foobar"
  opts.CustomUserAgent = "Sia-Agent"
	skylink, err := skynet.UploadFile("./image.jpg", opts)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

Portals will likely require authentication on several of their endpoints. This
is to prevent unwanted modifications to the blocklist, portal list, etc.

If you are authorized to use password-protected endpoints on a portal, you may
authenticate yourself by setting the `APIKey` custom option when calling a
function.

## Setting The User Agent

The portal may also require that certain sensitive requests contain a custom
user agent header, usually `Sia-Agent`. This is for security purposes, as
otherwise a malicious website could make requests to your local portal on your
behalf and steal coins.

We want this to be an opt-in for now, so `Sia-Agent` is not currently the
default. You may change the user agent header by setting the `customUserAgent`
custom option.

## More Information

For more information about authentication on portals and local `siad` instances
please see [the Sia Docs](https://sia.tech/docs/#authentication).
