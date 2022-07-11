# Uploading To Skynet

## Uploading A File

```shell--curl
curl -L -X POST "https://siasky.net/skynet/skyfile/<siapath>" -F 'file=@image.jpg'
```

```shell--cli
skynet upload "./image.jpg"
```

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

// NOTE: This example is different from the other SDKs because we cannot just
// take a path to a local file.

async function uploadExample() {
  try {
    const { skylink } = await client.uploadFile(file);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
const { SkynetClient } = require('@skynetlabs/skynet-nodejs');

const client = new SkynetClient();

(async () => {
	const skylink = await client.uploadFile("./image.jpg");
	console.log(`Upload successful, skylink: ${skylink}`);
})();
```

```python
import siaskynet as skynet

client = skynet.SkynetClient()

skylink = client.upload_file("image.jpg")
print("Upload successful, skylink: " + skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetLabs/go-skynet/v2"
)

var client = skynet.New()

func main() {
	skylink, err := client.UploadFile("./image.jpg", skynet.DefaultUploadOptions)
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

Note that you can set [common options](#common-options) for individual method calls as well, including `onUploadProgress`.

Field | Description | Default
----- | ----------- | -------
`portalFileFieldName` | The field name for files on the portal. Usually should not need to be changed. | `"file"`
`portalDirectoryFileFieldName` | The field name for directories on the portal. Usually should not need to be changed. | `"files[]"`
`customFilename` | Custom filename. This is the filename that will be returned when downloading the file in a browser. | `""`
`customDirname` | Custom dirname. If this is empty, the base name of the directory being uploaded will be used by default. | `""`
`onUploadProgress` | Optional callback to track upload progress. See [Setting Additional Options](#setting-additional-options). | `undefined`

### Response

```shell--curl
{
  "skylink": "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg",
  "merkleroot": "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I",
  "bitfield": 2048
}
```

```shell--cli
Successfully uploaded file! Skylink: sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg
```

```javascript--browser
"sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```javascript--node
"sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```python
"sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

```go
"sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

Field | Description
------| -----------
`skylink` | This is the skylink that can be used when downloading to retrieve the file that has been uploaded. It is a 46-character base64 encoded string that consists of the merkle root, offset, fetch size, and Skylink version which can be used to access the content.
`merkleroot` | This is the hash that is encoded into the skylink.
`bitfield` | This is the bitfield that gets encoded into the skylink. The bitfield contains a version, an offset and a length in a heavily compressed and optimized format.

<aside class="warning">
Note that the SDKs only return the skylink since this is what you want most of the time. We are still working on ways to access more information from the result without complicating the main use case.
</aside>

## Uploading A Directory

```shell--curl
curl -L -X POST "https://siasky.net/skynet/<siapath>?filename=images" -F 'files[]=@./images/image1.png' -F 'files[]=@./images/image2.png'
```

```shell--cli
skynet upload "./images"
```

```javascript--browser
import { getRelativeFilePath, getRootDirectory, SkynetClient } from "skynet-js";

const client = new SkynetClient();

// Assume we have a list of files from an input form.

async function uploadDirectoryExample() {
  try {
    // Get the directory name from the list of files.
    // Can also be named manually, i.e. if you build the files yourself
    // instead of getting them from an input form.
    const filename = getRootDirectory(files[0]);

    // Use reduce to build the map of files indexed by filepaths
    // (relative from the directory).
    const directory = files.reduce((accumulator, file) => {
      const path = getRelativeFilePath(file);

      return { ...accumulator, [path]: file };
    }, {});

    const { skylink } = await client.uploadDirectory(directory, filename);
  } catch (error) {
    console.log(error);
  }
}
```

```javascript--node
const { SkynetClient } = require('@skynetlabs/skynet-nodejs');

const client = new SkynetClient();

(async () => {
	const skylink = await client.uploadDirectory("./images");
	console.log(`Upload successful, skylink: ${skylink}`);
})();
```

```python
import siaskynet as skynet

client = skynet.SkynetClient()

skylink = client.upload_directory("./images")
print("Upload successful, skylink: " + skylink)
```

```go
package main

import (
	"fmt"
	skynet "github.com/SkynetLabs/go-skynet/v2"
)

var client = skynet.New()

func main() {
	skylink, err := client.UploadDirectory("./images", skynet.DefaultUploadOptions)
	if err != nil {
		panic("Unable to upload: " + err.Error())
	}
	fmt.Printf("Upload successful, skylink: %v\n", skylink)
}
```

It is possible to upload a directory as a single piece of content. Doing this
will allow you to address your content under one skylink, and access the files
by their path. This is especially useful for webapps.

For example, let's say you upload a web app with the following simple structure:

<pre class="not_example">
src
|-- favicon.ico
|-- index.html
|-- css
    |-- main.css
|-- js
    |-- app.js
</pre>

The four files can be accessed as follows:

<pre class="not_example">
[portal url]/[skylink]/favicon.ico
[portal url]/[skylink]/index.html
[portal url]/[skylink]/css/main.css
[portal url]/[skylink]/js/app.js
</pre>

<aside class="success">
You can use relative links to refer to different files within a web app. For
example, to link to the <code>main.css</code> resource from <code>index.html</code> you would do
<code>src="css/app.css</code>.
</aside>

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

See [Uploading A File](#uploading-a-file).

### Response

```shell--curl
{
  "skylink": "EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg",
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

See [Uploading A File](#uploading-a-file).
