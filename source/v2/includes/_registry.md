# Registry

The registry allows getting and setting registry entries with a user's key and a
data key (e.g. the name of an app).

Registry entries contain data (currently capped at 113 bytes), the data key, and
a revision number. The revision number is incremented by 1 every time the
registry entry is changed. The latest revision number, plus one, is required
when running `setEntry`. Because data at a given revision number cannot be
modified, the registry effectively provides versioned, immutable data.

<aside class="warning">
These functions have only been implemented for Browser JS at the moment.
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
  try {
    const { entry, signature } = await client.registry.getEntry(publicKey, dataKey);
  } catch (error) {
    console.log(error);
  }
}
```

### Function

`getEntry`

### Parameters

Field | Type | Description
----- | ---- | -----------
`publicKey` | `Buffer` or `Uint8Array` | User's public key. Can be generated with the `genKeyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.

### Response

```javascript--browser
{
  entry: {
    datakey: "foo",
    data: "bar",
    revision: 0
  },
  signature: "788dddf5232807611557a3dc0fa5f34012c2650526ba91d55411a2b04ba56164"
}
```

## Setting Data On The Registry

```shell--curl
curl -L -X POST -d '{"publickey":{"algorithm":"ed25519","key":[180,249,228,49,120,34,44,243,59,212,67,45,193,236,164,148,153,57,126,205,31,125,226,59,86,143,63,161,231,46,92,124]},"datakey":"79c05b4b67764ad99a7976a7d2fb1cfce4f196ea217ef0356af042cb5492bd5d","revision":7,"data":[65,65,65,118,74,68,105,95,101,102,75,76,101,99,83,65,112,78,56,110,89,113,84,110,122,83,106,76,116,102,66,55,80,99,69,110,81,112,75,75,101,79,88,100,54,119],"signature":[2,105,4,22,162,190,49,191,180,70,89,91,4,177,81,87,79,175,225,40,224,69,173,193,113,227,225,106,48,121,221,1,119,92,253,115,198,90,142,167,2,108,245,249,217,99,112,174,87,117,213,5,105,162,191,242,129,103,244,126,136,68,33,11]}' "https://siasky.net/skynet/registry"
```

```javascript--browser
import { SkynetClient, genKeyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { privateKey } = genKeyPairFromSeed("this seed should be fairly long for security");

const dataKey = "foo";
const data = "bar";
const revision = 0;
const entry = { datakey, data, revision };

async function setEntryExample() {
  try {
    await client.registry.setEntry(privateKey, dataKey, entry);
  } catch (error) {
    console.log(error);
  }
}
```

### Function

`setEntry`

### Parameters

Field | Type | Description
----- | ---- | -----------
`privateKey` | `Buffer` or `Uint8Array` | User's private key. Can be generated with the `genKeyPairFromSeed` function or with PKI in the node-forge library on NPM. Should be kept secret.
`entry` | `RegistryEntry` | The registry entry to set. See below.

### `RegistryEntry`

This object corresponds to a versioned entry in the registry.

Field | Type | Description
----- | ---- | -----------
`datakey` | `string` | The key of the data for the given entry.
`data` | `string` | The data for this entry. Capped at 113 bytes, but can be a skylink or an HNS domain.
`revision` | `number` | The revision number of this entry. It must be 1 more than the latest revision number, or 0 if the entry doesn't exist.

### Response

Empty on success.
