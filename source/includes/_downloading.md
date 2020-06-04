# Download

## Download File

```shell
# entire file
curl -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"

# directory
curl -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg/folder"

# sub file
curl -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg/folder/file.txt"
```

```javascript
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
from siaskynet import Skynet

# Must have a 'skylink' from an earlier upload.

Skynet.download_file("./dst.jpg", skylink)
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
		fmt.Println("Something went wrong, please try again.\nError:", err.Error())
		return
	}
	fmt.Println("Download successful")
}
```

This endpoint downloads a skylink using http streaming. This call blocks until
the data is received. There is a 30s default timeout applied to downloading a
skylink. If the data can not be found within this 30s time constraint, a 404
will be returned. This timeout is configurable through the query string
parameters.

### HTTP Request

`GET /skynet/skylink/<skylink>`

### URL Parameters

Parameter | Description
--------- | -----------
skylink | The skylink that should be downloaded. The skylink can contain an optional path. This path can specify a directory or a particular file. If specified, only that file or directory will be returned.

### Query String Parameters

Parameter | Type | Description
--------- | -----| -----------
attachment | bool | If 'attachment' is set to true, the Content-Disposition http header will be set to 'attachment' instead of 'inline'. This will cause web browsers to download the file as though it is an attachment instead of rendering it.
format | string | If 'format' is set, the skylink can point to a directory and it will return the data inside that directory. Format will decide the format in which it is returned. Currently we only support 'concat', which will return the concatenated data of all subfiles in that directory.
timeout | int | If 'timeout' is set, the download will fail if the Skyfile can not be retrieved  before it expires. Note that this timeout does not cover the actual download time, but rather covers the TTFB. Timeout is specified in seconds, a timeout  value of 0 will be ignored. If no timeout is given, the default will be used, which is a 30 second timeout. The maximum allowed timeout is 900s (15 minutes).

### HTTP Response Headers

Name | Type | Description
---- | -----| -----------
Skynet-File-Metadata | SkyfileMetadata | The header field "Skynet-FileMetadata" will be set such that it has an encoded json object which matches the modules.SkyfileMetadata struct. If a path was supplied, this metadata will be relative to the given path.

### HTTP HEAD Request

```shell
curl -I -A "Sia-Agent" "localhost:9980/skynet/skylink/CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

> The above command returns JSON structured like this:

```json
{
  "mode":     640,      // os.FileMode
  "filename": "folder", // string
  "subfiles": [         // []SkyfileSubfileMetadata | null
    {
    "mode":         640,                // os.FileMode
    "filename":     "folder/file1.txt", // string
    "contenttype":  "text/plain",       // string
    "offset":       0,                  // uint64
    "len":          6                   // uint64
    }
  ]
}
```

This curl command performs a HEAD request that fetches the headers for
the given skylink. These headers are identical to the ones that would be
returned if the request had been a GET request.
