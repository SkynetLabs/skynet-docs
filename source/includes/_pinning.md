# Pinning And Unpinning

One of the core features of Skynet that makes it so exciting is the ability to
pin files. *Pinning* re-uploads a copy of a file, ensuring its availability on
Skynet even if the original upload is no longer available.

## Pinning A File

```shell--curl
Coming Soon
```

```shell--cli
Coming Soon
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";
const destSiaPath = "pin/location";

async function pinExample() {
  try {
    const client = new SkynetClient();
    await client.pin(skylink, destSiaPath);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";
const destSiaPath = "pin/location";

(async () => {
	await skynet.pin(skylink, destSiaPath);
})();
```

```python
import siaskynet as skynet

skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
destSiaPath = "pin/location"

skynet.pin(skylink, destSiaPath)
print("Pin successful")
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
	const destSiaPath = "pin/location"

	fmt.Println("Pinning...")
	err := skynet.Pin(skylink, destSiaPath, skynet.DefaultPinOptions)
	if err != nil {
		panic("Unable to pin: " + err.Error())
	}
	fmt.Printf("File pinned successfully")
}
```

This function pins the file associated with this skylink by re-uploading an
exact copy. This ensures that the file will still be available on skynet as long
as you continue maintaining the file in your renter.

### Parameters

Field | Type | Description
----- | ---- | -----------
`skylink` | string | The skylink that should be pinned.
`destSiaPath` | string | The destination siapath for this file.

### Response

Empty on success.

## Unpinning A File

```shell--curl
Coming Soon
```

```shell--cli
Coming Soon
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const siaPath = "pin/location";

async function unpinExample() {
  try {
    const client = new SkynetClient();
    await client.unpin(siaPath);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

const siaPath = "pin/location";

(async () => {
	await skynet.unpin(siaPath);
})();
```

```python
import siaskynet as skynet

siaPath = "pin/location"

skynet.unpin(siaPath)
print("Unpin successful")
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const siaPath = "pin/location"

	fmt.Println("Unpinning...")
	err := skynet.Unpin(siaPath, skynet.DefaultUnpinOptions)
	if err != nil {
		panic("Unable to unpin: " + err.Error())
	}
	fmt.Printf("File unpinned successfully")
}
```

This function unpins the pinned skyfile or directory at the given siapath. The
files and directories will continue to be available on Skynet if other nodes
have pinned them.

### Parameters

Field | Type | Description
----- | ---- | -----------
`siaPath` | string | The location of the file to unpin.

### Response

Empty on success.
