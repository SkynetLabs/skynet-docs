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

// NOTE: This example is different from the other SDKs because we cannot just take a path to a local file.

try {
  // Using a file from an input form.
  const { skylink } = await upload("https://siasky.net", file);
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const skylink = await skynet.uploadFile("./image.jpg");
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
If a file is uploaded through a portal, the portal owner is paying to host that
file, and it will remain on the network for as long as that file contract is
valid.
</aside>

### Parameters

Field | Description
----- | -----------
`path` | The local path where the file to upload may be found.

*Browser JS:*

Field | Description
----- | -----------
`file` | The `File` object returned from an input form.

### Additional Options

Field | Description | Default
----- | ----------- | -------
`endpointPath` | The relative URL path of the portal endpoint to contact. | `"/skynet/skyfile"`
`portalFileFieldName` | The field name for files on the portal. Usually should not need to be changed. | `"file"`
`portalDirectoryFileFieldName` | The field name for directories on the portal. Usually should not need to be changed. | `"files[]"`
`customFilename` | Custom filename. This is the filename that will be returned when downloading the file in a browser. | `""`
`customDirname` | Custom dirname. If this is empty, the base name of the directory being uploaded will be used by default. | `""`
`skykeyName` | The name of the skykey on the portal used to encrypt the upload. | `""`
`skykeyID` | The ID of the skykey on the portal used to encrypt the upload. | `""`
`timeout_seconds` | The timeout in seconds. | `""`

### Response

```shell--curl
{
  "skylink": "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg",
  "merkleroot": "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I",
  "bitfield": 2048
}
```

```shell--cli
Successfully uploaded file! Skylink: CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg
```

```javascript--browser
"CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```javascript--node
"CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```python
"CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```go
"CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

Field        | Description
------------ | -----------
`skylink` | This is the skylink that can be used when downloading to retrieve the file that has been uploaded. It is a 46-character base64 encoded string that consists of the merkle root, offset, fetch size, and Skylink version which can be used to access the content.
`merkleroot` | This is the hash that is encoded into the skylink.
`bitfield` | This is the bitfield that gets encoded into the skylink. The bitfield contains a version, an offset and a length in a heavily compressed and optimized format.

## Uploading A Directory

```shell--curl
curl "https://siasky.net/skynet/skyfile" -F files[]=@./images/image1.png -F files[]=@./images/image2.png
```

```shell--cli
skynet upload "source dir path"
```

```javascript--browser
import { getRelativeFilePath, getRootDirectory, uploadDirectory } from "skynet-js";

// NOTE: This example is different from the other SDKs because we cannot just take a path to a local directory.

// Assume we have a list of files from an input form.
const filename = getRootDirectory(files[0]);
const directory = files.reduce((acc, file) => {
  const path = getRelativeFilePath(file);

  return { ...acc, [path]: file };
}, {});

try {
  const directory = files.reduce((acc, file) => {
    const path = getRelativeFilePath(file);

    return { ...acc, [path]: file };
  }, {});

  const { skylink } = await uploadDirectory("https://siasky.net", directory, filename);
} catch (error) {
  console.log(error);
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const url = await skynet.uploadDirectory("./images");
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

For example, let's say you upload a directory with the following structure:

<pre class="not_example">
dir1
|-- file1
|-- file1
|-- dir2
    |-- file3
</pre>

The three files can be accessed as follows:

<pre class="not_example">
...portal.../...skylink.../file1
...portal.../...skylink.../file2
...portal.../...skylink.../dir2/file3
</pre>

Accessing one of the two directories...

<pre class="not_example">
...portal.../...skylink...
...portal.../...skylink.../dir2
</pre>

... will download them as a .zip archive containing the contents, by default.

### Parameters

Field | Description
----- | -----------
`path` | The local path where the directory to upload may be found.

*Browser JS:*

Field | Description
----- | -----------
`directory` | Object containing `File`s from an input form to upload, indexed by their path strings.
`filename` | The name of the directory.

### Additional Options

See [Uploading A File](.#uploading-a-file).

### Response

```shell--curl
{
  "skylink": "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg",
  "merkleroot": "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I",
  "bitfield": 2048
}
```

```shell--cli
Successfully uploaded directory! Skylink: sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg
```

```javascript--browser
"sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"
```

```javascript--node
"sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"
```

```python
"sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"
```

```go
"sia://EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"
```

See [Uploading A File](.#uploading-a-file).

## Uploading With Encryption

```shell--curl
Coming Soon
```

```shell--cli
skynet upload "./image.jpg" --skykey-name "my-skykey"
```

```javascript--browser
import { upload } from "skynet-js";

// Assume we have a file from an input form.

try {
  const { skylink } = await upload("https://siasky.net", file, { skykeyName: "my-skykey" });
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const skylink = await skynet.uploadFile(
		"./image.jpg",
		{ skykeyName: "my-skykey" }
	);
	console.log(`Upload successful, skylink: ${skylink}');
})();
```

```python
TODO
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	opts := skynet.DefaultUploadOptions
	opts.SkykeyName = "my-skykey"
	skylink, err := skynet.UploadFile("./image.jpg", opts)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

If you have a skykey on the portal you can ask the portal to encrypt the
uploaded content for you. Simply pass the skykey name or ID in the custom
options when uploading a file or directory.

See the additional options in [Uploading A File](.#uploading-a-file).

Also see [Encryption](.#encryption).
