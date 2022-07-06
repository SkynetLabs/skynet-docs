# Registry

The registry allows getting and setting registry entries with a user's key and a
data key (e.g. the name of an app).

Registry entries contain data (currently capped at 113 bytes), the data key, and
a revision number. The revision number increases every time the registry entry
is changed. The latest revision number, plus at least one, is required when
calling `setEntry`. Previous revisions are not accessible once an entry has been
overwritten with a higher revision number.

<aside class="warning">
These functions have only been implemented for BrowserJS and NodeJS at the moment.
</aside>

## Getting Data From The Registry

```shell--curl
curl -X GET -G -A "Sia-Agent" -u "":<apipassword> -d "publickey=ed25519%3Ab4f9e43178222cf33bd4432dc1eca49499397ecd1f7de23b568f3fa1e72e5c7c" -d "datakey=79c05b4b67764ad99a7976a7d2fb1cfce4f196ea217ef0356af042cb5492bd5d" "https://siasky.net/skynet/registry"
```

```javascript--browser
import { SkynetClient, genKeyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";

async function getEntryExample() {
  const { entry, signature } = await client.registry.getEntry(publicKey, dataKey);
}
```

```javascript--node
const { SkynetClient, genKeyPairFromSeed } = require("@skynetlabs/skynet-nodejs");

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";

(async () => {
  const { entry, signature } = await client.registry.getEntry(publicKey, dataKey);
})();
```

### Method

`getEntry`

### Parameters

Field | Type | Description
----- | ---- | -----------
`publicKey` | `string` | User's public key as a hex-encoded string. Can be generated with the `genKeyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.
`customOptions` | `Object` | Custom options to pass into this method. See below.

### Optional Parameters

Field | Description | Default
----- | ----------- | -------
`endpointGetEntry` | The relative URL path of the portal endpoint to contact. | `/skynet/registry`
`hashedDataKeyHex` | Whether the data key is already hashed and in hex format. If not, we hash the data key. | `false`

### Response

```javascript--browser
{
  entry: {
    datakey: "foo",
    data: Uint8Array([ 98, 97, 114 ]), // corresponds to string "bar"
    revision: BigInt(0)
  },
  signature: "788dddf5232807611557a3dc0fa5f34012c2650526ba91d55411a2b04ba56164"
}
```

```javascript--node
{
  entry: {
    datakey: "foo",
    data: Uint8Array([ 98, 97, 114 ]), // corresponds to string "bar"
    revision: BigInt(0)
  },
  signature: "788dddf5232807611557a3dc0fa5f34012c2650526ba91d55411a2b04ba56164"
}
```

## Setting Data On The Registry

```shell--curl
curl -L -X POST -d '{"publickey":{"algorithm":"ed25519","key":[180,249,228,49,120,34,44,243,59,212,67,45,193,236,164,148,153,57,126,205,31,125,226,59,86,143,63,161,231,46,92,124]},"datakey":"79c05b4b67764ad99a7976a7d2fb1cfce4f196ea217ef0356af042cb5492bd5d","revision":7,"data":[65,65,65,118,74,68,105,95,101,102,75,76,101,99,83,65,112,78,56,110,89,113,84,110,122,83,106,76,116,102,66,55,80,99,69,110,81,112,75,75,101,79,88,100,54,119],"signature":[2,105,4,22,162,190,49,191,180,70,89,91,4,177,81,87,79,175,225,40,224,69,173,193,113,227,225,106,48,121,221,1,119,92,253,115,198,90,142,167,2,108,245,249,217,99,112,174,87,117,213,5,105,162,191,242,129,103,244,126,136,68,33,11]}' "https://siasky.net/skynet/registry"
```

```javascript--browser
import { SkynetClient, genKeyPairFromSeed, stringToUint8ArrayUtf8 } from "skynet-js";

const client = new SkynetClient();
const { privateKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";
const data = stringToUint8ArrayUtf8("bar");
const revision = BigInt(0);
const entry = { dataKey, data, revision };

async function setEntryExample() {
  await client.registry.setEntry(privateKey, entry);
}
```

```javascript--node
const { SkynetClient, genKeyPairFromSeed, stringToUint8ArrayUtf8 } = require("@skynetlabs/skynet-nodejs");

const client = new SkynetClient();
const { privateKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";
const data = stringToUint8ArrayUtf8("bar");
const revision = BigInt(0);
const entry = { dataKey, data, revision };

(async () => {
  await client.registry.setEntry(privateKey, entry);
})();
```

### Method

`setEntry`

### Parameters

Field | Type | Description
----- | ---- | -----------
`privateKey` | `string` | User's private key as a hex-encoded string. Can be generated with the `genKeyPairFromSeed` function or with PKI in the node-forge library on NPM. Should be kept secret.
`entry` | `RegistryEntry` | The registry entry to set. See below.
`customOptions` | `Object` | Custom options to pass into this method. See below.

### Optional Parameters

Field | Description | Default
----- | ----------- | -------
`endpointSetEntry` | The relative URL path of the portal endpoint to contact. | `/skynet/registry`
`hashedDataKeyHex` | Whether the data key is already hashed and in hex format. If not, we hash the data key. | `false`

### `RegistryEntry`

This object corresponds to a versioned entry in the registry.

Field | Type | Description
----- | ---- | -----------
`datakey` | `string` | The key of the data for the given entry.
`data` | `string` | The data for this entry. Capped at 113 bytes, but can be a skylink or an HNS domain.
`revision` | `number` | The revision number of this entry. It must be at least 1 more than the latest revision number, or 0 if the entry doesn't exist.

### Response

Empty on success.

## Getting The Entry URL

```javascript--browser
import { SkynetClient, genKeyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";

async function getEntryUrlExample() {
  const url = await client.registry.getEntryUrl(publicKey, dataKey);
}
```

```javascript--node
const { SkynetClient, genKeyPairFromSeed } = require("@skynetlabs/skynet-nodejs");

const client = new SkynetClient();
const { publicKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";

(async () => {
  const url = await client.registry.getEntryUrl(publicKey, dataKey);
})();
```

### Method

`getEntryUrl`

### Parameters

See [Getting Data From The Registry](#getting-data-from-the-registry).

### Response

```javascript--browser
"https://siasky.net/skynet/registry?publickey=ed25519%3Ac1197e1275fbf570d21dde01a00af83ed4a743d1884e4a09cebce0dd21ae254c&datakey=7c96a0537ab2aaac9cfe0eca217732f4e10791625b4ab4c17e4d91c8078713b9"
```

```javascript--node
"https://siasky.net/skynet/registry?publickey=ed25519%3Ac1197e1275fbf570d21dde01a00af83ed4a743d1884e4a09cebce0dd21ae254c&datakey=7c96a0537ab2aaac9cfe0eca217732f4e10791625b4ab4c17e4d91c8078713b9"
```
