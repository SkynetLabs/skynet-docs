# Browser JS Utilities

The following are some utilities that only make sense in the browser, and thus
are only provided by the Browser JS SDK.

## Open

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  client.open(skylink);
} catch (error) {
  console.log(error);
}
```

Use the client to open a skylink in a new browser tab. Browsers support opening
natively only limited file extensions like `.html` or `.jpg` and will fallback
to downloading the file.

### Parameters

See [Downloading A File](.#downloading-a-file).

### Response

Empty on success.

## Getting The Download URL

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skylink = "XABvi7JtJbQSMAcDwnUnmp2FKDPjg8_tTTFP4BwMSxVdEg";

try {
  const url = client.getDownloadUrl(skylink);
} catch (error) {
  console.log(error);
}
```

Use the client to generate a direct `skylink` url.

### Parameters

See [Downloading A File](.#downloading-a-file).

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
`skylink` | See [Uploading A File](.#uploading-a-file).
