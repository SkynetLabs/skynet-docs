# Uploading To Skynet

## Uploading A File

```shell--curl
curl -X POST "https://siasky.net/skynet/skyfile" -F file=@image.jpg
```

```shell--cli
skynet upload "./image.jpg"
```

```javascript--browser
import { upload } from "skynet-js";

try {
  const { skylink } = await upload("https://siasky.net", "./image.jpg");
} catch (error) {
  console.log(error)
}
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
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

Uploading a file to Skynet can be done through a Skynet portal or your
local `siad` instance.

<aside class="notice">
If a file is uploaded through a portal, the portal owner is paying to host that file, and it will remain on the network for as long as that file contract is valid.
</aside>

### Parameters

Field | Description
----- | -----------
`path` | The local path where the file to upload may be found.

### Additional Options

```javascript--browser
export const defaultUploadOptions = {
  ...options,
  portalEndpointPath: "/skynet/skyfile",
  portalFileFieldname: "file",
  portalDirectoryFileFieldname: "files[]",
  customFilename: "",
};
```

```go
UploadOptions struct {
    Options

    // PortalFileFieldName is the fieldName for files on the portal.
    PortalFileFieldName string
    // PortalDirectoryFileFieldName is the fieldName for directory files on
    // the portal.
    PortalDirectoryFileFieldName string

    // CustomFilename is the custom filename to use for the upload. If this
    // is empty, the filename of the file being uploaded will be used by
    // default.
    CustomFilename string
    // CustomDirname is the custom name of the directory. If this is empty,
    // the base name of the directory being uploaded will be used by
    // default.
    CustomDirname string

    // SkykeyName is the name of the skykey used to encrypt the upload.
    SkykeyName string
    // SkykeyID is the ID of the skykey used to encrypt the upload.
    SkykeyID string
}
```

Eventually, all SDKs will support the following options:

Field | Description
----- | -----------
`portalFileFieldName` | The field name for files on the portal. Usually should not need to be changed.
`portalDirectoryFileFieldName` | The field name for directories on the portal. Usually should not need to be changed.
`customFilename` | Custom filename. This is the filename that will be returned when downloading the file in a browser.
`customDirname` | Custom dirname. If this is empty, the base name of the directory being uploaded will be used by default.
`skykeyName` | The name of the skykey on the portal used to encrypt the upload.
`skykeyID` | The ID of the skykey on the portal used to encrypt the upload.

### Response

```shell--curl
{
  "skylink": "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg",
  "merkleroot": "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I",
  "bitfield": 2048
}
```

```shell--cli
# TODO
```

```javascript--browser
// skylink = "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```javascript--node
// skylink = "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```python
# skylink = "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```go
// skylink = "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

The response will contain some or all of these fields:

Field        | Description
------------ | -----------
`skylink`    | This is the skylink that can be used when downloading to retrieve the file that has been uploaded. It is a 46-character base64 encoded string that consists of the merkle root, offset, fetch size, and Skylink version which can be used to access the content.
`merkleroot` | This is the hash that is encoded into the skylink.
`bitfield`   | This is the bitfield that gets encoded into the skylink. The bitfield contains a version, an offset and a length in a heavily compressed and optimized format.

## Uploading A Directory

```shell--curl
curl "https://siasky.net/skynet/skyfile" -F files[]=@./images/image1.png -F files[]=@./images/image2.png
```

```shell--cli
skynet upload "source dir path"
```

```javascript--browser
// TODO
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const url = await skynet.UploadDirectory(
		"./images",
		skynet.DefaultUploadOptions
	);
	console.log(`Upload successful, url: ${url}`);
})();
```

```python
import siaskynet as skynet

url = skynet.upload_directory("./images")
print("Upload successful, url: " + url)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	url, err := skynet.UploadDirectory("./images", skynet.DefaultUploadOptions)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, url: %v\n", url)
}
```

It is possible to upload a directory as a single piece of content. Doing this
will allow you to address your content under one skylink, and access the files
by their path. This is especially useful for webapps.

Directory uploads work using multipart form upload.

### Settings

Field       | Description
----------- | -----------
`portal`    | The URL of the portal
`filename`  | Custom filename. This is the filename that will be returned when downloading the file in a browser

### Response

```shell--curl
{
  "skylink": "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg",
  "merkleroot": "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I",
  "bitfield": 2048
}
```

```shell--cli
# TODO
```

```javascript--browser
// url = sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg
```

```javascript--node
// url = sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg
```

```python
# url = sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg
```

```go
// url = sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg
```

Field        | Description
------------ | -----------
`skylink`    | This is the skylink that can be used when downloading to retrieve the file that has been uploaded. It is a 46-character base64 encoded string that consists of the merkle root, offset, fetch size, and Skylink version which can be used to access the content.
`merkleroot` | This is the hash that is encoded into the skylink.
`bitfield`   | This is the bitfield that gets encoded into the skylink. The bitfield contains a version, an offset and a length in a heavily compressed and optimized format.

## Uploading With Encryption

TODO
