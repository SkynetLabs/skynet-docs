# Downloading From Skynet

## Downloading A File

```shell--curl
curl -A "Sia-Agent" "https://siasky.net/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg" -o dst.jpg
```

```shell--cli
skynet download "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg" "./dst.jpg"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  client.downloadFile(skylink);
  // Or client.openFile(skylink) to open it in a new browser tab.
} catch (error) {
  console.log(error);
}
```

```javascript--node
const { SkynetClient } = require('@nebulous/skynet');

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

(async () => {
	await client.downloadFile("./dst.jpg", skylink);
	console.log('Download successful');
})();
```

```python
import siaskynet as skynet

client = skynet.SkynetClient()
skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

client.download_file("./dst.jpg", skylink)
print("Download successful")
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet/v2"
)

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
var client = skynet.New()

func main() {
	err := client.DownloadFile("./dst.go", skylink, skynet.DefaultDownloadOptions)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Download successful")
}
```

This function downloads a skylink using HTTP streaming. The call blocks until
the data is received. There is a 30s default timeout applied to downloading a
skylink. If the data can not be found within this 30s time constraint, a `404`
error will be returned. This timeout is configurable.

### Parameters

Field | Description
----- | -----------
`path` | The local path where the file should be downloaded to.
`skylink` | The skylink that should be downloaded. The skylink can contain an optional path.

*Browser JS:*

Field | Description
----- | -----------
`skylink` | The skylink that should be downloaded. The skylink can contain an optional path.

### Additional Options

Field | Description | Default
----- | ----------- | -------
`path` | The path to use after the skylink. See the next section.  | `""`
`timeout_seconds` | The timeout in seconds. | `""`

### Response

Empty on success.

## Downloading A File From An Uploaded Directory

```shell--curl
curl -A "Sia-Agent" "https://siasky.net/XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg/dir2/file3" -o dst.jpg
```

```shell--cli
skynet download "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg/dir2/file3" "./dst.jpg"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

// Using the skylink.
try {
  const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg/dir2/file3";
  client.downloadFile(skylink);
} catch (error) {
  console.log(error);
}

// Using the path option.
try {
  const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";
  client.downloadFile(skylink, { path: "dir2/file3" });
} catch (error) {
  console.log(error);
}
```

```javascript--node
const { SkynetClient } = require('@nebulous/skynet');

const client = new SkynetClient();

// Using the skylink.
(async () => {
  const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg/dir2/file3";
	await client.downloadFile("./dst.jpg", skylink);
	console.log('Download successful');
})();

// Using the path option.
(async () => {
  const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";
	await client.downloadFile("./dst.jpg", skylink, { path: "dir2/file3" });
	console.log('Download successful');
})()
```

```python
import siaskynet as skynet

client = skynet.SkynetClient()

# Using the skylink.
skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg/dir2/file3"
client.download_file("./dst.jpg", skylink)
print("Download successful")

# Using the path option.
skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
client.download_file("./dst.jpg", skylink, { "path": "dir2/file3" })
print("Download successful")
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet/v2"
)

var client = skynet.New()

func main() {
	// Using the skylink.
	skylink := "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg/dir2/file3"
	opts := skynet.DefaultDownloadOptions
	err := client.DownloadFile("./dst.go", skylink, opts)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Download successful")

	// Using the path option.
	skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
	opts.Path = "dir2/file3";
	err := client.DownloadFile("./dst.go", skylink, opts)
	if err != nil {
		panic("Something went wrong, please try again.\nError: " + err.Error())
	}
	fmt.Println("Download successful")
}
```

It is possible to download files from uploaded directories if their paths
relative to the uploaded directory are known. There are two ways to do this.

### Including The Path In The Skylink

The skylink being passed in can contain an optional path. This path can specify
a directory or a particular file. If specified, only that file or directory will
be returned. The examples here use the directory structure from [Uploading A
Directory](#uploading-a-directory) to illustrate this.

### The Path Additional Parameter

There is a caveat to the above approach: the skylink is used as-is and any
special characters in the appended path are not encoded. We recommend using the
additional option `path` to let the SDK properly encode it for you.

The `path` option also is easier to use if you would otherwise have to manually
append the path to the skylink.

## Getting Metadata

```shell--curl
curl -I -A "Sia-Agent" "https://siasky.net/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```shell--cli
# NOTE: this function has not yet been implemented for this SDK.

skynet metadata "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

async metadataExample() {
  try {
    const { metadata, contentType, skylink } = await client.getMetadata(skylink);
  } catch (error) {
    console.log(error);
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const { SkynetClient } = require('@nebulous/skynet');

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

(async () => {
	const md = await client.getMetadata(skylink);
	console.log(Get metadata successful');
})();
```

```python
import siaskynet as skynet

client = skynet.SkynetClient()
skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"

md = client.get_metadata(skylink)
```

```go
// NOTE: this function has not yet been implemented for this SDK.

package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet/v2"
)

const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
var client = skynet.New()

func main() {
	md, err := client.Metadata(skylink, skynet.DefaultMetadataOptions)
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
| `contentType` | String representing the file's content type. |
| `metadata` | Object returned in the `skynet-metadata` header when accessing the file |

### Additional Options

See [Downloading A File](#downloading-a-file).

### Response

```shell--curl
{
  "mode":     640,
  "filename": "folder",
  "subfiles": {
    "folder/file1.txt": {
      "mode":         640,
      "filename":     "folder/file1.txt",
      "contenttype":  "text/plain",
      "offset":       0,
      "len":          6
    }
  }
}
```

```shell--cli
{
  "mode":     640,
  "filename": "folder",
  "subfiles": {
    "folder/file1.txt": {
      "mode":         640,
      "filename":     "folder/file1.txt",
      "contenttype":  "text/plain",
      "offset":       0,
      "len":          6
    }
  }
}
```

```javascript--browser
{
  "mode":     640,
  "filename": "folder",
  "subfiles": {
    "folder/file1.txt": {
      "mode":         640,
      "filename":     "folder/file1.txt",
      "contenttype":  "text/plain",
      "offset":       0,
      "len":          6
    }
  }
}
```

```javascript--node
{
  "mode":     640,
  "filename": "folder",
  "subfiles": {
    "folder/file1.txt": {
      "mode":         640,
      "filename":     "folder/file1.txt",
      "contenttype":  "text/plain",
      "offset":       0,
      "len":          6
    }
  }
}
```

```python
{
  "mode":     640,
  "filename": "folder",
  "subfiles": {
    "folder/file1.txt": {
      "mode":         640,
      "filename":     "folder/file1.txt",
      "contenttype":  "text/plain",
      "offset":       0,
      "len":          6
    }
  }
}
```

```go
{
  "mode":     640,
  "filename": "folder",
  "subfiles": {
    "folder/file1.txt": {
      "mode":         640,
      "filename":     "folder/file1.txt",
      "contenttype":  "text/plain",
      "offset":       0,
      "len":          6
    }
  }
}
```

Coming Soon
