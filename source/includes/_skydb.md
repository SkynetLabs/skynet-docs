# SkyDB

SkyDB is a framework that allows Skynet users to create decentralized accounts
and store mutable files in those accounts. It is built on top of the [Registry](#registry), where every SkyDB entry in the Registry is a skylink that contains the full data.

<aside class="warning">
These functions have only been implemented for Browser JS at the moment.
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
  try {
    const { data, skylink } = await client.db.getJSON(publicKey, dataKey);
  } catch (error) {
    console.log(error);
  }
}
```

### Function

`getJSON`

### Parameters

Field | Type | Description
----- | ---- | -----------
`publicKey` | `string` | User's public key as a hex-encoded string. Can be generated with the `genKeyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.

### Response

```javascript-browser
{
  data: {
    example: "This is some example JSON data."
  },
  skylinke: "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
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
  try {
    await client.db.setJSON(privateKey, dataKey, json);
  } catch (error) {
    console.log(error);
  }
}
```

### Function

`setJSON`

### Parameters

Field | Type | Description
----- | ---- | -----------
`privateKey` | `string` | User's private key as a hex-encoded string. Can be generated with the `genKeyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.
`json` | `object` | The JSON object to set for the given private key and data key.

### Response

Empty on success.

## Getting The Entry URL

```javascript--browser
import { SkynetClient, genKeyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";

function getEntryExample() {
  try {
    const url = client.registry.getEntryUrl(publicKey, dataKey);
  } catch (error) {
    console.log(error);
  }
}
```

### Function

`getEntryUrl`

### Parameters

See [Getting Data From The Registry](#getting-data-from-the-registry).

### Response

```javascript-browser
"https://siasky.net/skynet/registry?publickey=ed25519%3Ac1197e1275fbf570d21dde01a00af83ed4a743d1884e4a09cebce0dd21ae254c&datakey=7c96a0537ab2aaac9cfe0eca217732f4e10791625b4ab4c17e4d91c8078713b9"
```
