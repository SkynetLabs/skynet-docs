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
import { download } from "skynet-js";

// Assume we have a skylink e.g. from a previous upload.

try {
  download(portalUrl, skylink);
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

// Must have a 'skylink' from an earlier upload.

(async () => {
	await skynet.DownloadFile(
		"./dst.jpg",
		skylink
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
`path` | The local path where the file should be downloaded to.
`skylink` | The skylink that should be downloaded. The skylink can contain an optional path. This path can specify a directory or a particular file. If specified, only that file or directory will be returned.

*Browser JS:*

Field | Description
----- | -----------
`skylink` | The skylink that should be downloaded. The skylink can contain an optional path. This path can specify a directory or a particular file. If specified, only that file or directory will be returned.

### Additional Options

Eventually, all SDKs will support the following options:

Field | Description | Default
----- | ----------- | -------
`endpointPath` | The relative URL path of the portal endpoint to contact. | `"/"`
`skykeyName` | The name of the skykey on the portal used to decrypt the download. | `""`
`skykeyID` | The ID of the skykey on the portal used to decrypt the download. | `""`
`timeout_seconds` | The timeout in seconds. | `""`

### Response

*Browser JS:*

Exception on failure.

## Getting Metadata

```shell--curl
curl -I -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```shell--cli
TODO
```

```javascript--browser
import { metadata } from "skynet-js";

// Assume we have a skylink e.g. from a previous upload.

try {
  const md = metadata(portalUrl, skylink);
} catch (error) {
  console.log(error)
}
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

Field | Description
----- | -----------
`skylink` | The skylink that should be downloaded. The skylink can contain an optional path. This path can specify a directory or a particular file. If specified, only that file or directory will be returned.

### Additional Options

See [Downloading A File](.#downloading-a-file).

### Response

```shell--curl
{
"mode":     640,
"filename": "folder",
"subfiles": [
  {
  "mode":         640,
  "filename":     "folder/file1.txt",
  "contenttype":  "text/plain",
  "offset":       0,
  "len":          6
  }
]
}
```

```shell--cli
{
"mode":     640,
"filename": "folder",
"subfiles": [
  {
  "mode":         640,
  "filename":     "folder/file1.txt",
  "contenttype":  "text/plain",
  "offset":       0,
  "len":          6
  }
]
}
```

```javascript--browser
{
"mode":     640,
"filename": "folder",
"subfiles": [
  {
  "mode":         640,
  "filename":     "folder/file1.txt",
  "contenttype":  "text/plain",
  "offset":       0,
  "len":          6
  }
]
}
```

```javascript--node
{
"mode":     640,
"filename": "folder",
"subfiles": [
  {
  "mode":         640,
  "filename":     "folder/file1.txt",
  "contenttype":  "text/plain",
  "offset":       0,
  "len":          6
  }
]
}
```

```python
{
"mode":     640,
"filename": "folder",
"subfiles": [
  {
  "mode":         640,
  "filename":     "folder/file1.txt",
  "contenttype":  "text/plain",
  "offset":       0,
  "len":          6
  }
]
}
```

```go
{
"mode":     640,
"filename": "folder",
"subfiles": [
  {
  "mode":         640,
  "filename":     "folder/file1.txt",
  "contenttype":  "text/plain",
  "offset":       0,
  "len":          6
  }
]
}
```

The response will contain some or all of these fields:

TODO

## Downloading With Decryption

```shell--curl
TODO
```

```shell--cli
skynet download [skylink] [destination] --skykey-name "my-skykey"
```

```javascript--browser
import { download } from "skynet-js";

// Assume we have a skylink e.g. from a previous upload.

try {
  download(portalUrl, skylink, { skykeyName: "my-skykey" });
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

// Must have a 'skylink' from an earlier upload.

(async () => {
	await skynet.DownloadFile(
		"./dst.jpg",
		skylink,
		{ skykeyName: "my-skykey" }
	);
	console.log('Download successful');
})();
```

```python
import siaskynet as skynet

# Must have a 'skylink' from an earlier upload.

skynet.download_file("./dst.jpg", skylink, { skykeyName: "my-skykey" })
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

	opts := skynet.DefaultDownloadOptions
	opts.SkykeyName = "my-skykey"
	err = skynet.DownloadFile("./dst.go", skylink, opts)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Download successful")
}
```

If you have a skykey on the portal you can ask the portal to decrypt the downloaded content for you. Simply pass the skykey name or ID in the custom options when downloading.

See the additional options in [Downloading A File](.#downloading-a-file).

Also see [Encryption](.#encryption).
