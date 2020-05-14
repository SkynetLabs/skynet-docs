# Skyfile

## Upload File

```shell
// This command uploads the file 'myImage.png' to the Sia folder
// 'var/skynet/images/myImage.png'. Users who download the file will see the name
// 'image.png'.
curl -A "Sia-Agent" -u "":<apipassword> "localhost:9980/skynet/skyfile/images/myImage.png?filename=image.png" --data-binary @myImage.png
```

> The above command returns JSON structured like this

```json
{
"skylink":    "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg" // string
"merkleroot": "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I" // hash
"bitfield":   2048 // int
}
```

This endpoint uploads a file to the network using a stream. If the upload stream
POST call fails or quits before the file is fully uploaded, the file can be
repaired by a
subsequent call to the upload stream endpoint using the `repair` flag.

### HTTP Request
`POST /skynet/skyfile/<siapath>`

### URL Parameters

Parameter | Description
--------- | -----------
siapath | Location where the file will reside in the renter on the network. The path must be non-empty, may not include any path traversal strings ("./", "../"), and may not begin with a forward-slash character. If the 'root' flag is not set, the path will be prefixed with 'var/skynet/', placing the skyfile into the Sia system's default skynet folder.

### Query String Parameters

Parameter | Type | Description
--------- | -----| -----------
basechunkredundancy | uint8 | The amount of redundancy to use when uploading the base chunk. The base chunk is the first chunk of the file, and is always uploaded using 1-of-N redundancy.
convertpath | string | The siapath of an existing siafile that should be converted to a skylink. A new skyfile will be created. Both the new skyfile and the existing siafile are required to be maintained on the network in order for the skylink to remain active. This field is mutually exclusive with uploading streaming.
filename | string | The name of the file. This name will be encoded into the skyfile metadata, and will be a part of the skylink. If the name changes, the skylink will change as well.
dryrun | bool | If dryrun is set to true, the request will return the Skylink of the file without uploading the actual file to the Sia network.
force | bool | If there is already a file that exists at the provided siapath, setting this flag will cause the new file to overwrite/delete the existing file. If this flag is not set, an error will be returned preventing the user from destroying existing data.
mode | uint32 | The file mode / permissions of the file. Users who download this file will be presented a file with this mode. If no mode is set, the default of 0644 will be used.
root | bool | Whether or not to treat the siapath as being relative to the root directory. If this field is not set, the siapath will be interpreted as relative to 'var/skynet'.
skykeyname | string | **UNSTABLE - subject to change in v1.4.9** The name of the skykey that will be used to encrypt this skyfile. Only the name or the ID of the skykey should be specified.
skykeyid | string | **UNSTABLE - subject to change in v1.4.9** The ID of the skykey that will be used to encrypt this skyfile. Only the name or the ID of the skykey should be specified.

<aside class="notice"> All query string parameters are optional </aside>
<aside class="warning">skykeyid and skykeyname can not be supplied at the same time</aside>

### HTTP Request Headers

Name | Type | Description
---- | -----| -----------
Content-Disposition | string | If the filename is set in the Content-Disposition field, that filename will be used as the filename of the object being uploaded. Note that this header is only taken into consideration when using a multipart form upload. For more details on setting Content-Disposition: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Disposition
Skynet-Disable-Force | bool | This request header allows overruling the behaviour of the `force` parameter that can be passed in through the query string parameters. This header is useful for Skynet portal operators that would like to have some control over the requests that are being passed to siad. To avoid having to parse query string parameters and overrule them that way, this header can be set to disable the force flag and disallow overwriting the file at the given siapath.

<aside class="notice"> All request headers are optional </aside>

### Response Fields

Field | Type | Description
----- | ---- | -----------
skylink | string | This is the skylink that can be used with the `/skynet/skylink` GET endpoint to retrieve the file that has been uploaded.
merkleroot | hash | This is the hash that is encoded into the skylink.
bitfield | int | This is the bitfield that gets encoded into the skylink. The bitfield contains a version, an offset and a length in a heavily compressed and optimized format.