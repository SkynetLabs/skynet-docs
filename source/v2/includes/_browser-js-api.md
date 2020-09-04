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

Field | Description | Default
----- | ----------- | -------
`download` | Option to include download directive in the url that will force a download when used. | `false`

### Response

```javascript--browser
"https://siasky.net/XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"
```

Field | Description
------| -----------
`url` | The URL for the given skylink on the client portal.

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

Field | Description | Default
----- | ----------- | -------
`download` | Option to include download directive in the url that will force a download when used. | `false`

### Response

```javascript--browser
"https://siasky.net/hns/doesn"
```

Field | Description
------| -----------
`url` | The URL for the given Handshake domain on the client portal.

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

Field | Description | Default
----- | ----------- | -------
`download` | Option to include download directive in the url that will force a download when used. | `false`

### Response

```javascript--browser
"https://siasky.net/hnsres/doesn"
```

Field | Description
------| -----------
`url` | The URL for the given Handshake Resolver domain on the client portal.

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

Field | Description
----- | -----------
`string` | The string to extract a skylink from.

Currently supported string types are:

- direct skylink string, for example `"XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`
- `sia:` prefixed string, for example `"sia:XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`
- `sia://` prefixed string, for example `"sia://XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`
- skylink from url, for example `"https://siasky.net/XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg"`

### Response

```javascript--browser
"CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
```

Field | Description
------| -----------
`skylink` | See [Uploading A File](#uploading-a-file).
