# Getting Started

## Making Your First API Call

```shell--curl
curl -X POST "https://siasky.net/skynet/skyfile" -F file=@image.jpg
```

```shell--cli
skynet upload "./image.jpg"
```

```javascript--browser
// TODO
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const skylink = await skynet.UploadFile(
		"./image.jpg",
		skynet.DefaultUploadOptions
	);
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
		fmt.Println("Unable to upload:", err.Error())
		return
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

The SDKs are set up to be as simple as possible. Despite the many possible options for configuration, most users will be able to get started with a single API call. In the example on the right, we upload the file `image.jpg` to the default Skynet portal, `https://siasky.net`.

## Setting Additional Options
TODO
