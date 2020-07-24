# Encryption

## Creating A Skykey

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/createskykey"
```

```shell--cli
TODO
```

```javascript--browser
import { createSkykey } from "skynet-js";

const name = "testcreateskykey";

try {
  const skykey = createSkykey(portalUrl, name, "private-id");
} catch (error) {
  console.log(error)
}
```

```javascript--node
TODO
```

```python
TODO
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const name = "testcreateskykey"

	fmt.Printf("Creating skykey with name %v...\n", name)
	skykey, err := skynet.CreateSkykey(name, "private-id", skynet.DefaultCreateSkykeyOptions)
	if err != nil {
		panic("Unable to create skykey: " + err.Error())
	}
	fmt.Printf("Created skykey %v\n", skykey)
```

This function creates a skykey stored under the given name.

### Settings

Parameter | Description
--------- | -----------
`name` | Desired name of the skykey.
`id` | Desired type of the skykey. The two supported types are "public-id" and
"private-id". Users should use "private-id" skykeys unless they have a specific
reason to use "public-id" skykeys which reveal skykey IDs and show which
skyfiles are encrypted with the same skykey.

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
TODO
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

## Addding A Skykey

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "skykey=BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a" "localhost:9980/skynet/addskykey"
```

```shell--cli
TODO
```

```javascript--browser
import { addSkykey } from "skynet-js";

const skykey = "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq";

try {
  addSkykey(portalUrl, skykey);
} catch (error) {
  console.log(error)
}
```

```javascript--node
TODO
```

```python
TODO
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const skykey = "skykey:AUI0eAOXWXHwW6KOLyI5O1OYduVvHxAA8qUR_fJ8Kluasb-ykPlHBEjDczrL21hmjhH0zAoQ3-Qq"

	fmt.Printf("Adding skykey %v...\n", skykey)
	err := skynet.AddSkykey(skykey, skynet.DefaultAddSkykeyOptions)
	if err != nil {
		panic("Unable to add skykey: " + err.Error())
	}
```

This function stores the given skykey with the renter's skykey manager.

### Settings

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
TODO
```

```javascript--browser
import { getSkykeyByName } from "skynet-js";

// Assume we have a skykey name.

try {
  const skykey = getSkykeyByName(portalUrl, name);
} catch (error) {
  console.log(error)
}
```

```javascript--node
TODO
```

```python
TODO
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const name = "testcreateskykey"

	fmt.Printf("Getting skykey with name %v...\n", name)
	skykey, err := skynet.GetSkykeyByName(name, skynet.DefaultGetSkykeyOptions)
	if err != nil {
		panic("Unable to get skykey: " + err.Error())
	}
	fmt.Printf("Skykey: %#v\n", skykey)
```

This function returns the base-64 encoded skykey stored under that name.

### Settings

Parameter | Description
--------- | -----------
`name` | Name of the skykey being queried.

### Response

See [Create Skykey](.#create-skykey).

### Getting A Skykey By ID

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "id=gi5z8cf5NWbcvPBaBn0DFQ==" "localhost:9980/skynet/skykey"
```

```shell--cli
TODO
```

```javascript--browser
import { getSkykeyById } from "skynet-js";

// Assume we have a skykey ID.

try {
  const skykey = getSkykeyById(portalUrl, id);
} catch (error) {
  console.log(error)
}
```

```javascript--node
TODO
```

```python
TODO
```

```go
package main

import skynet "github.com/NebulousLabs/go-skynet"

func main() {
	const id = "pJAPPfWkWXpss3BvMDCJCw=="

	fmt.Printf("Getting skykey with id %v...\n", id)
	skykey, err = skynet.GetSkykeyByID(id, skynet.DefaultGetSkykeyOptions)
	if err != nil {
		panic("Unable to get skykey: " + err.Error())
	}
	fmt.Printf("Skykey: %#v\n", skykey)
}
```

> TODO

This function returns the base-64 encoded skykey stored under that ID.

### Settings

Parameter | Description
--------- | -----------
`id` | ID of the skykey being queried

### Response

See [Create Skykey](.#create-skykey).

## Listing Skykeys

```shell--curl
TODO
```

```shell--cli
TODO
```

```javascript--browser
import { getSkykeys } from "skynet-js";

try {
  const skykeys = getSkykeys(portalUrl);
} catch (error) {
  console.log(error)
}
```

```javascript--node
TODO
```

```python
TODO
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	fmt.Println("Listing skykeys...")
	skykeys, err := skynet.ListSkykeys(skynet.DefaultListSkykeysOptions)
	if err != nil {
		panic("Unable to get skykeys: " + err.Error())
	}
	fmt.Printf("Skykeys: %v\n", skykeys)
}
```

This function lists all skykeys on the given portal.

### Settings

None

### Response

List of Skykeys (see [Create Skykey](.#create-skykey).
