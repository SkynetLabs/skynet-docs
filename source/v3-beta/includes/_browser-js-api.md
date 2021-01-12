# Browser JS API

The following are some methods and utilities that only make sense in the
browser, and thus are only provided by the Browser JS SDK.

## Opening A File

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  client.openFile(skylink);
} catch (error) {
  console.log(error);
}
```

Use the client to open a skylink in a new browser tab. Browsers support opening
natively only limited file extensions like `.html` or `.jpg` and will fallback
to downloading the file.

### Parameters

See [Downloading A File](#downloading-a-file).

### Response

Empty on success.

## Loading A File's Contents

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skylink = "AACJjVpOpsZ6c9PBwOYvxTtDc_nmrGxTTEomHDBEEfvRhA"; // JSON File

try {
  const { data } = await client.getFileContent(skylink);
  console.log(data.fruit) //prints 'Apple'
} catch (error) {
  console.log(error);
}
```

Use the client to load a skylink's content for use by application.

### Parameters

| Field     | Description                                                                      |
| --------- | -------------------------------------------------------------------------------- |
| `skylink` | The skylink that should be downloaded. The skylink can contain an optional path. |

### Response

```javascript--browser
{
  data: { fruit: 'Apple', size: 'Large', color: 'Red' },
  contentType: 'application/json',
  metadata: {
    filename: 'example_1.json',
    length: 65,
    subfiles: { 'example_1.json': [Object] }
  },
  skylink: 'sia:AACJjVpOpsZ6c9PBwOYvxTtDc_nmrGxTTEomHDBEEfvRhA'
}
```

| Field         | Description                                                                                                                                                                                                                                                      |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `data`        | Data returned in the response body when doing a GET request for the skylink.                                                                                                                                                                                     |
| `skylink`     | This is the skylink that can be used when downloading to retrieve the file that has been uploaded. It is a 46-character base64 encoded string that consists of the merkle root, offset, fetch size, and Skylink version which can be used to access the content. |
| `contentType` | String representing the file's content type.                                                                                                                                                                                                                     |
| `metadata`    | Object returned in the `skynet-metadata` header when accessing the file                                                                                                                                                                                          |

<aside class="warning">
There are no checks in place for this method, and it is not advised to try and load the contents of excessively large files. You may want to run `getMetadata` first to check a file's size before running this method.
</aside>

## Getting The Download URL

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  const url = client.getSkylinkUrl(skylink);
} catch (error) {
  console.log(error);
}
```

Use the client to generate a direct `skylink` url.

### Parameters

See [Downloading A File](#downloading-a-file).

### Additional Options

| Field      | Description                                                                           | Default |
| ---------- | ------------------------------------------------------------------------------------- | ------- |
| `download` | Option to include download directive in the url that will force a download when used. | `false` |

### Response

```javascript--browser
"https://siasky.net/XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
```

| Field | Description                                         |
| ----- | --------------------------------------------------- |
| `url` | The URL for the given skylink on the client portal. |

## Getting A Handshake URL

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const domain = "doesn";

try {
  const url = client.getHnsUrl(domain);
} catch (error) {
  console.log(error);
}
```

Use the client to generate a direct Handshake url from a Handshake domain.

### Parameters

See [Downloading Handshake Files](#downloading-handshake-files).

### Additional Options

| Field      | Description                                                                           | Default |
| ---------- | ------------------------------------------------------------------------------------- | ------- |
| `download` | Option to include download directive in the url that will force a download when used. | `false` |

### Response

```javascript--browser
"https://siasky.net/hns/doesn"
```

| Field | Description                                                  |
| ----- | ------------------------------------------------------------ |
| `url` | The URL for the given Handshake domain on the client portal. |

## Getting A Handshake Resolver URL

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const domain = "doesn";

try {
  const url = client.getHnsresUrl(domain);
} catch (error) {
  console.log(error);
}
```

Use the client to generate a direct Handshake Resolver url from a Handshake
domain.

### Parameters

See [Resolving Handshake Domains](#resolving-handshake-domains).

### Additional Options

| Field      | Description                                                                           | Default |
| ---------- | ------------------------------------------------------------------------------------- | ------- |
| `download` | Option to include download directive in the url that will force a download when used. | `false` |

### Response

```javascript--browser
"https://siasky.net/hnsres/doesn"
```

| Field | Description                                                           |
| ----- | --------------------------------------------------------------------- |
| `url` | The URL for the given Handshake Resolver domain on the client portal. |

## Parsing Skylinks

```javascript--browser
import { parseSkylink } from "skynet-js";

const client = new SkynetClient();
const uri = "sia://XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  const skylink = parseSkylink(uri);
} catch (error) {
  console.log(error);
}
```

Extract a skylink from a string.

### Parameters

| Field    | Description                           |
| -------- | ------------------------------------- |
| `string` | The string to extract a skylink from. |

Currently supported string types are:

- direct skylink string, for example `"XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`
- `sia:` prefixed string, for example `"sia:XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`
- `sia://` prefixed string, for example `"sia://XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`
- skylink from url, for example `"https://siasky.net/XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`

### Response

```javascript--browser
"CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

| Field     | Description                                |
| --------- | ------------------------------------------ |
| `skylink` | See [Uploading A File](#uploading-a-file). |
