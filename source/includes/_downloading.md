# Downloading From Skynet

## Downloading A File

```shell--curl
# entire file
curl -A "Sia-Agent" "https://siasky.net/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"

# sub path
curl -A "Sia-Agent" "https://siasky.net/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg/folder/file.txt"
```

```shell--cli
skynet download [skylink] [destination]
```

```javascript--browser
import { download } from "skynet-js";

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  download("https://siasky.net", skylink);
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

(async () => {
	await skynet.downloadFile("./dst.jpg", skylink);
	console.log('Download successful');
})();
```

```python
import siaskynet as skynet

skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

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
  const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

	err := skynet.DownloadFile("./dst.go", skylink, skynet.DefaultDownloadOptions)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Download successful")
}
```

This function downloads a skylink using http streaming. The call blocks until
the data is received. There is a 30s default timeout applied to downloading a
skylink. If the data can not be found within this 30s time constraint, a `404`
error will be returned. This timeout is configurable.

### Parameters

Field | Description
----- | -----------
`path` | The local path where the file should be downloaded to.
`skylink` | The skylink that should be downloaded. The skylink can contain an optional path. This path can specify a directory or a particular file. If specified, only that file or directory will be returned. See [Uploading A Directory](.#uploading-a-directory) for examples.

*Browser JS:*

Field | Description
----- | -----------
`skylink` | The skylink that should be downloaded. The skylink can contain an
optional path. This path can specify a directory or a particular file. If
specified, only that file or directory will be returned. See [Uploading A
Directory](.#uploading-a-directory) for examples.

### Additional Options

Field | Description | Default
----- | ----------- | -------
`endpointPath` | The relative URL path of the portal endpoint to contact. | `"/"`
`skykeyName` | The name of the skykey on the portal used to decrypt the download. | `""`
`skykeyID` | The ID of the skykey on the portal used to decrypt the download. | `""`
`timeout_seconds` | The timeout in seconds. | `""`

### Response

Empty on success.

## Getting Metadata

```shell--curl
curl -I -A "Sia-Agent" "https://siasky.net/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```shell--cli
Coming Soon
```

```javascript--browser
import { metadata } from "skynet-js";

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  const md = await metadata("https://siasky.net", skylink);
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

(async () => {
	const md = await skynet.metadata(skylink);
	console.log(Get metadata successful');
})();
```

```python
import siaskynet as skynet

skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

md = skynet.metadata(skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

	md, err := skynet.Metadata(skylink, skynet.DefaultMetadataOptions)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Printf("Get metadata successful, metadata: %+v\n", md)
}
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

Coming Soon

## Downloading With Decryption

```shell--curl
Coming Soon
```

```shell--cli
skynet download [skylink] [destination] --skykey-name "my-skykey"
```

```javascript--browser
import { download } from "skynet-js";

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  download("https://siasky.net", skylink, { skykeyName: "my-skykey" });
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

(async () => {
	await skynet.downloadFile(
		"./dst.jpg",
		skylink,
		{ skykeyName: "my-skykey" }
	);
	console.log('Download successful');
})();
```

```python
import siaskynet as skynet

skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

skynet.download_file("./dst.jpg", skylink, { skykeyName: "my-skykey" })
print("Download successful")
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

func main() {
	// Must have a 'skylink' from an earlier upload.

	opts := skynet.DefaultDownloadOptions
	opts.SkykeyName = "my-skykey"
	err := skynet.DownloadFile("./dst.go", skylink, opts)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Download successful")
}
```

If you have a skykey on the portal you can ask the portal to decrypt the
downloaded content for you. Simply pass the skykey name or ID in the custom
options when downloading.

See the additional options in [Downloading A File](.#downloading-a-file).

Also see [Encryption](.#encryption).
