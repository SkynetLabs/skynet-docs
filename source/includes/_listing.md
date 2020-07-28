# Listing

## Listing Pinned Skyfiles

```shell--curl
Coming Soon
```

```shell--cli
# Listing a single siapath
skynet ls "path/file-or-dir"

# Listing all
skynet ls
```

```javascript--browser
import { ls } from "skynet-js";

const siaPath = "path/file-or-dir";

try {
  const ls = await ls("https://siasky.net", siaPath);
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

const siaPath = "path/file-or-dir";

(async () => {
	const ls = await skynet.ls(siaPath);
})();
```

```python
import siaskynet as skynet

siaPath = "path/file-or-dir"

ls = skynet.ls(siaPath)
print("Ls successful: ", ls)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const siaPath = "path/file-or-dir"

	fmt.Println("Running ls...")
	ls, err := skynet.Ls(siaPath, skynet.DefaultLsOptions)
	if err != nil {
		panic("Unable to pin: " + err.Error())
	}
	fmt.Printf("Ls run successfully: %+v", ls)
}
```

This function lists all skyfiles that the user has pinned along with the corresponding
skylinks.

<aside class="notice">
By default, only files in <code>var/skynet/</code> will be displayed. The
<code>root</code> option can be used to view skyfiles pinned in other folders.
</aside>

### Parameters

Field | Type | Description
----- | ---- | -----------
`siaPath` | string | Siapath to list. Can be either a directory or a siafile to get information about a single file. Pass `""` to list from root Skynet directory.

### Additional Options

Coming soon

### Response

```shell--curl
Coming Soon
```

```shell--cli
Coming Soon
```

```javascript--browser
Coming Soon
```

```javascript--node
Coming Soon
```

```python
Coming Soon
```

```go
Coming Soon
```

Coming Soon
