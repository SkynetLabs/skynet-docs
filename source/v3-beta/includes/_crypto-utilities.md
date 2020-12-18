# Crypto Utilities

This page documents cryptographic utilities for generating public and private
keys as well as secure seeds. Private keys should, as the name implies, be kept
private. The seeds should also be handled carefully as they can be used to
derive public/private key pairs.

## Generating Key Pairs And Seeds

```javascript--browser
import { genKeyPairAndSeed } from "skynet-js";

const { publicKey, privateKey, seed } = genKeyPairAndSeed();
```

If you do not yet have a seed, you can generate one with this function and it
will also generate an associated key pair. The seed is generated using strong,
cryptographic-grade randomness. It is recommended that you only store the seed
for later use and re-derive the key pair with `genKeyPairFromSeed`, and that you
store it securely.

### Function

`genKeyPairAndSeed`

### Parameters

None

### Response

```javascript-browser
{
  publicKey: "f8a7da8324fabb9d57bb32c59c48d4ba304d08ee5f1297a46836cf841da71c80",
  privateKey: "c404ff07fba961000dfb25ece7477f45b109b50a5169a45f3fb239343002c1cff8a7da8324fabb9d57bb32c59c48d4ba304d08ee5f1297a46836cf841da71c80",
  seed: "c1197e1275fbf570d21dde01a00af83ed4a743d1884e4a09cebce0dd21ae254c"
}
```

## Generating Key Pairs From Seeds

```javascript--browser
import { genKeyPairFromSeed } from "skynet-js";

const { publicKey, privateKey } = genKeyPairFromSeed("this seed should be fairly long for security");
```

If you already have a seed (e.g. from a previous call to `genKeyPairAndSeed`) you
can deterministically derive the same keypair.

### Function

`genKeyPairFromSeed`

### Parameters

Field | Type | Description
----- | ---- | -----------
`seed` | `string` | The seed that should be used to generate a deterministic keypair. Can be a long and secure passphrase.

### Response

```javascript-browser
{
  publicKey: "f8a7da8324fabb9d57bb32c59c48d4ba304d08ee5f1297a46836cf841da71c80",
  privateKey: "c404ff07fba961000dfb25ece7477f45b109b50a5169a45f3fb239343002c1cff8a7da8324fabb9d57bb32c59c48d4ba304d08ee5f1297a46836cf841da71c80",
}
```

## Deriving Child Seeds

```javascript--browser
import { deriveChildSeed, genKeyPairAndSeed } from "skynet-js";

const { publicKey, privateKey, masterSeed } = genKeyPairAndSeed();
const childSeed = deriveChildSeed(masterSeed, "foo");
```

This function can be used to derive a child seed from a given master seed and
subseed. For example, the master seed can be a long and secure passphrase while
the subseed can be the name of an application.

### Function

`deriveChildSeed`

### Parameters

Field | Type | Description
----- | ---- | -----------
`masterSeed` | `string` | The master seed that should be used to generate a deterministic keypair. Can be a long and secure passphrase.
`seed` | `string` | The subseed that, in combination with the master seed, results in a deterministic keypair.

### Response

```javascript-browser
"f79cd29b92124c80a662f3085bba98955f7defbaed6e58ea891b901dc99aafc0"
```
