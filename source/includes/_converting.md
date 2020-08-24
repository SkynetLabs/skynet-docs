# Converting

## Converting Siafiles to Skyfiles

```shell--curl
Coming Soon
```

```shell--cli
# NOTE: this function has not yet been implemented for this SDK.

skynet convert "src/path" "dest/path"
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const srcSiaPath = "src/path";
const destSiaPath = "dest/path";

async function convertExample() {
  try {
    const { skylink } = await client.convert(srcSiaPath, destSiaPath);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

const srcSiaPath = "src/path";
const destSiaPath = "dest/path";

(async () => {
	const skylink = await skynet.convert(srcSiaPath, destSiaPath);
	console.log(`Convert successful, skylink: ${skylink}`);
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

srcSiaPath = "src/path"
destSiaPath = "dest/path"

skylink = skynet.convert(srcSiaPath, destSiaPath)
print("Convert successful, skylink: " + skylink)
```

```go
// NOTE: this function has not yet been implemented for this SDK.

package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const srcSiaPath = "src/path"
	const destSiaPath = "dest/path"

	skylink, err := skynet.Convert(srcSiaPath, destSiaPath, skynet.DefaultConvertOptions)
	if err != nil {
		panic("Unable to convert: " + err.Error())
	}
	fmt.Printf("Convert successful, skylink: %v\n", skylink)
}
```

This function creates a skyfile using an existing siafile. The original siafile
and the skyfile will both need to be kept in order for the file to remain
available on Skynet.

### Parameters

Field | Type | Description
----- | ---- | -----------
`srcSiaPath` | string | The source siapath location of this file.
`destSiaPath` | string | The destination siapath for this file.

### Additional Options

See [Uploading A File](#uploading-a-file).

### Response

See [Uploading A File](#uploading-a-file).
