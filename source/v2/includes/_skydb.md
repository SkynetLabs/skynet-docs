# SkyDB

SkyDB is a framework that allows Skynet users to create decentralized accounts
and store mutable files in those accounts. It is built on top of the [Registry](#registry).

<aside class="warning">
These functions have only been implemented for Browser JS at the moment.
</aside>

## Getting Data From SkyDB

```javascript--browser
import { SkynetClient, keyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey, privateKey } = keyPairFromSeed("this seed should be fairly long for security");

const dataKey = "myApp";

async function getJSONExample() {
  try {
    const { data, revision } = await client.db.getJSON(publicKey, dataKey);
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
`publicKey` | `Buffer or Uint8Array` | User's public key. Can be generated with the `keyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.

### Response

```javascript-browser
{
  data: {
    example: "This is some example JSON data."
  },
  revision: 11
}
```

## Setting Data On SkyDB

```javascript--browser
import { SkynetClient, keyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey, privateKey } = keyPairFromSeed("this seed should be fairly long for security");

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
`privateKey` | `Buffer or Uint8Array` | User's private key. Can be generated with the `keyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.
`json` | `object` | The JSON object to set for the given private key and data key.

### Response

Empty on success.
