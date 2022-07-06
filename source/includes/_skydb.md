# SkyDB

SkyDB is a framework that allows Skynet users to create decentralized accounts
and store mutable files in those accounts. It is built on top of the
[Registry](#registry), where every SkyDB entry in the Registry is a skylink that
contains the full data.

<aside class="warning">
These functions have only been implemented for Browser JS and NodeJS at the moment.
</aside>

## Getting Data From SkyDB

```shell--curl
# There are no API endpoints for SkyDB -- you must use the registry directly.
```

```javascript--browser
import { SkynetClient, genKeyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "myApp";

async function getJSONExample() {
  const { data, dataLink } = await client.db.getJSON(publicKey, dataKey);
}
```

```javascript--node
const { SkynetClient, genKeyPairFromSeed } = require("@skynetlabs/skynet-nodejs");

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "myApp";

(async () => {
  const { data, dataLink } = await client.db.getJSON(publicKey, dataKey);
})();
```

### Method

`getJSON`

### Parameters

Field | Type | Description
----- | ---- | -----------
`publicKey` | `string` | User's public key as a hex-encoded string. Can be generated with the `genKeyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.

### Response

```javascript--browser
{
  data: {
    example: "This is some example JSON data."
  },
  dataLink: "sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
}
```

```javascript--node
{
  data: {
    example: "This is some example JSON data."
  },
  dataLink: "sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
}
```

## Setting Data On SkyDB

```shell--curl
# There are no API endpoints for SkyDB -- you must use the registry directly.
```

```javascript--browser
import { SkynetClient, genKeyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { privateKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "myApp";
const json = { example: "This is some example JSON data." };

async function setJSONExample() {
  await client.db.setJSON(privateKey, dataKey, json);
}
```

```javascript--node
const { SkynetClient, genKeyPairFromSeed } = require("@skynetlabs/skynet-nodejs");

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "myApp";
const json = { example: "This is some example JSON data." };

(async () => {
  await client.db.setJSON(privateKey, dataKey, json);
})();
```

### Method

`setJSON`

### Parameters

Field | Type | Description
----- | ---- | -----------
`privateKey` | `string` | User's private key as a hex-encoded string. Can be generated with the `genKeyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.
`json` | `object` | The JSON object to set for the given private key and data key.

### Response

Empty on success.
