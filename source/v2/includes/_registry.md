# Registry

The registry is the low-level technology that provides the foundation for
[SkyDB](#skydb). It allows getting and setting registry entries with a user's
key and a data key (e.g. the name of an app). Registry entries contain data, the
data key, and a revision number, which is incremented by 1 every time the
registry entry is changed. The latest revision number is required when running
`setEntry`. Because data at a given revision number cannot be modified, the
registry effectively provides versioned, immutable data.

<aside class="warning">
These functions have only been implemented for Browser JS at the moment.
</aside>

## Getting Data From The Registry

```javascript--browser
import { SkynetClient, keyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey, privateKey } = keyPairFromSeed("this seed should be fairly long for security");

const dataKey = "myApp";

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
`publicKey` | `Buffer` or `Uint8Array` | User's public key. Can be generated with the `keyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.

### Response

```javascript--browser
{
  entry: {
    datakey: "HelloWorld",
    data: "abc",
    revision: 123456789
  },
  signature: "788dddf5232807611557a3dc0fa5f34012c2650526ba91d55411a2b04ba56164"
}
```

## Setting Data On The Registry

```javascript--browser
import { SkynetClient, keyPairFromSeed } from "skynet-js";

const client = new SkynetClient();
const { publicKey, privateKey } = keyPairFromSeed("this seed should be fairly long for security");

const dataKey = "myApp";
const data = "abc";
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
`privateKey` | `Buffer` or `Uint8Array` | User's private key. Can be generated with the `keyPairFromSeed` function.
`dataKey` | `string` | The key of the data to fetch for the given user.
`entry` | `RegistryEntry` | The registry entry to set. See below.

### `RegistryEntry`

This object corresponds to a versioned entry in the registry.

Field | Type | Description
----- | ---- | -----------
`datakey` | `string` | The key of the data for the given entry.
`data` | `string` | The data for this entry.
`revision` | `number` | The revision number of this entry. It must be 1 more than the latest revision number, or 0 if the entry doesn't exist.

### Response

Empty on success.
