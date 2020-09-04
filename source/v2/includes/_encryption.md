# Encryption

Encryption and decryption in Skynet are performed using *skykeys*. Skykeys can
be created and queried using the functions in this section. The name or ID of a
skykey must be provided when uploading or downloading with encryption.

See also:

- [Uploading With Encryption](#uploading-with-encryption)
- [Downloading With Decryption](#downloading-with-decryption)

## Creating A Skykey

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/createskykey"
```

```shell--cli
skynet skykey create "testcreateskykey"
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const name = "testcreateskykey";

async function createSkykeyExample() {
  try {
    const skykey = await client.createSkykey(name, "private-id");
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

const client = new SkynetClient();
const name = "testcreateskykey";

(async () => {
	const skykey = await client.createSkykey(name, "private-id");
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

client = skynet.SkynetClient()
name = "testcreateskykey"

skykey = client.create_skykey(name, "private-id")
print("Create skykey successful, skykey: " + skykey)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

const name = "testcreateskykey"
var client = skynet.New()

func main() {
	fmt.Printf("Creating skykey with name %v...\n", name)
	skykey, err := client.CreateSkykey(name, "private-id", skynet.DefaultCreateSkykeyOptions)
	if err != nil {
		panic("Unable to create skykey: " + err.Error())
	}
	fmt.Printf("Created skykey %v\n", skykey)
```

This function creates a skykey stored under the given name.

### Parameters

Parameter | Description
--------- | -----------
`name` | Desired name of the skykey.
`type` | Desired type of the skykey. The two supported types are `"public-id"` and `"private-id"`. Users should use `"private-id"` skykeys unless they have a specific reason to use `"public-id"` skykeys which reveal skykey IDs and show which skyfiles are encrypted with the same skykey.

### Response

```shell--curl
{
  "skykey": "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq?name=testskykey1",
  "name": "key_to_the_castle",
  "id": "ai5z8cf5NWbcvPBaBn0DFQ==",
  "type": "private-id"
}
```

```shell--cli
Coming Soon
```

```javascript--browser
{
  "skykey": "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq?name=testskykey1",
  "name": "key_to_the_castle",
  "id": "ai5z8cf5NWbcvPBaBn0DFQ==",
  "type": "private-id"
}
```

```javascript--node
{
  "skykey": "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq?name=testskykey1",
  "name": "key_to_the_castle",
  "id": "ai5z8cf5NWbcvPBaBn0DFQ==",
  "type": "private-id"
}
```

```python
{
  "skykey": "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq?name=testskykey1",
  "name": "key_to_the_castle",
  "id": "ai5z8cf5NWbcvPBaBn0DFQ==",
  "type": "private-id"
}
```

```go
{
  "skykey": "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq?name=testskykey1",
  "name": "key_to_the_castle",
  "id": "ai5z8cf5NWbcvPBaBn0DFQ==",
  "type": "private-id"
}
```

Field | Type | Description
----- | ---- | -----------
`skykey` | string | Base-64 encoded Skykey
`name` | string | Name of the Skykey
`id` | string | ID of the Skykey
`type` | string | Desired type of the skykey. See above for more information.

## Adding A Skykey

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "skykey=BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a" "localhost:9980/skynet/addskykey"
```

```shell--cli
skynet skykey add "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq"
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const skykey = "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq";

async function addSkykeyExample() {
  try {
    await client.addSkykey(skykey);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

const client = new SkynetClient();
const skykey = "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq";

(async () => {
	await client.addSkykey(skykey);
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

client = skynet.SkynetClient()
skykey = "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq"

client.add_skykey(skykey)
print("Add skykey successful")
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

const skykey = "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq"
var client = skynet.New()

func main() {
	fmt.Printf("Adding skykey %v...\n", skykey)
	err := client.AddSkykey(skykey, skynet.DefaultAddSkykeyOptions)
	if err != nil {
		panic("Unable to add skykey: " + err.Error())
	}
```

This function stores the given skykey with the renter's skykey manager.

### Parameters

Parameter | Description
--------- | -----------
`skykey` | Base-64 encoded skykey

### Response

Error or exception on failure.

## Getting A Skykey By Name

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/skykey"
```

```shell--cli
skynet skykey get name "testcreateskykey"
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const name = "testcreateskykey";

async function getSkykeyByNameExample() {
  try {
    const skykey = await client.getSkykeyByName(name);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

const client = new SkynetClient();
const name = "testcreateskykey";

(async () => {
	const skykey = await client.getSkykeyByName(name);
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

client = skynet.SkynetClient()
name = "testcreateskykey"

skykey = client.get_skykey_by_name(name)
print("Get skykey successful, skykey: " + skykey)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

const name = "testcreateskykey"
var client = skynet.New()

func main() {
	fmt.Printf("Getting skykey with name %v...\n", name)
	skykey, err := client.GetSkykeyByName(name, skynet.DefaultGetSkykeyOptions)
	if err != nil {
		panic("Unable to get skykey: " + err.Error())
	}
	fmt.Printf("Skykey: %#v\n", skykey)
```

This function returns the base-64 encoded skykey stored under that name.

### Parameters

Parameter | Description
--------- | -----------
`name` | Name of the skykey being queried.

### Response

See [Creating A Skykey](#creating-a-skykey).

### Getting A Skykey By ID

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "id=gi5z8cf5NWbcvPBaBn0DFQ==" "localhost:9980/skynet/skykey"
```

```shell--cli
skynet skykey get id "pJAPPfWkWXpss3BvMDCJCw=="
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const id = "pJAPPfWkWXpss3BvMDCJCw==";

async function getSkykeyByIdExample() {
  try {
    const skykey = await client.getSkykeyById(id);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

const client = new SkynetClient();
const id = "pJAPPfWkWXpss3BvMDCJCw==";

(async () => {
	const skykey = await client.getSkykeyById(id);
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

client = skynet.SkynetClient()
id = "pJAPPfWkWXpss3BvMDCJCw=="

skykey = client.get_skykey_by_id(id)
print("Get skykey successful, skykey: " + skykey)
```

```go
package main

import skynet "github.com/NebulousLabs/go-skynet"

const id = "pJAPPfWkWXpss3BvMDCJCw=="
var client = skynet.New()

func main() {
	fmt.Printf("Getting skykey with id %v...\n", id)
	skykey, err := client.GetSkykeyByID(id, skynet.DefaultGetSkykeyOptions)
	if err != nil {
		panic("Unable to get skykey: " + err.Error())
	}
	fmt.Printf("Skykey: %#v\n", skykey)
}
```

This function returns the base-64 encoded skykey stored under that ID.

### Parameters

Parameter | Description
--------- | -----------
`id` | ID of the skykey being queried.

### Response

See [Creating A Skykey](#creating-a-skykey).

## Listing Skykeys

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> "localhost:9980/skynet/skykeys"
```

```shell--cli
skynet skykey list
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

async function getSkykeysExample() {
  try {
    const skykeys = await client.getSkykeys();
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

const client = new SkynetClient();

(async () => {
	const skykeys = await client.getSkykeys();
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

client = skynet.SkynetClient()

skykeys = client.get_skykeys()
print("Get skykeys successful, skykeys: " + skykeys)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

var client = skynet.New()

func main() {
	fmt.Println("Listing skykeys...")
	skykeys, err := client.ListSkykeys(skynet.DefaultListSkykeysOptions)
	if err != nil {
		panic("Unable to get skykeys: " + err.Error())
	}
	fmt.Printf("Skykeys: %v\n", skykeys)
}
```

This function lists all skykeys on the given portal.

### Parameters

None

### Response

List of Skykeys (see [Creating A Skykey](#creating-a-skykey)).
