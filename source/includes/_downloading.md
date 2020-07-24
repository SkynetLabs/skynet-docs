# Downloading From Skynet

## Downloading A File

```shell--curl
# entire file
curl -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"

# directory
curl -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg/folder"

# sub file
curl -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg/folder/file.txt"
```

```shell--cli
skynet download [skylink] [destination]
```

```javascript--browser
// TODO
```

```javascript--node
const skynet = require('@nebulous/skynet');

// Must have a 'skylink' from an earlier upload.

(async () => {
	await skynet.DownloadFile(
		"./dst.jpg",
		skylink,
		skynet.DefaultDownloadOptions
	);
	console.log('Download successful');
})();
```

```python
import siaskynet as skynet

# Must have a 'skylink' from an earlier upload.

skynet.download_file("./dst.jpg", skylink)
print("Download successful")
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	// Must have a 'skylink' from an earlier upload.

	err = skynet.DownloadFile("./dst.go", skylink, skynet.DefaultDownloadOptions)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Download successful")
}
```

This endpoint downloads a skylink using http streaming. The call blocks until
the data is received. There is a 30s default timeout applied to downloading a
skylink. If the data can not be found within this 30s time constraint, a `404`
error will be returned. This timeout is configurable.

### Parameters

Field | Description
----- | -----------
`skylink` | The skylink that should be downloaded. The skylink can contain an optional path. This path can specify a directory or a particular file. If specified, only that file or directory will be returned.

### Additional Options

Eventually, all SDKs will support the following options:

Field | Description
----- | -----------
`skykeyName` | The name of the skykey on the portal used to decrypt the download.
`skykeyID` | The ID of the skykey on the portal used to decrypt the download.

### Default Options

```javascript--browser
export const defaultDownloadOptions = {
  ...options,
  portalEndpointPath: "/",
};
```

```go
DefaultDownloadOptions = DownloadOptions{
    Options: DefaultOptions("/"),
}
```

The default endpoint for this function is `/`.

### Response

TODO

## Getting Metadata

```shell--curl
curl -I -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```shell--cli
TODO
```

```javascript--browser
TODO
```

```javascript--node
TODO
```

```python
TODO
```

```go
TODO
```

It is possible to get metadata about a file or directory without fetching
the entire content. These API calls will perform a HEAD request that fetches the
headers for the given skylink. These headers are identical to the ones that
would be returned if the request had been a GET request.

### Parameters

TODO

### Additional Options

TODO

### Response

TODO
