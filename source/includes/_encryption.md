# Encryption

## Getting a Skykey By Name

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/skykey"
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

> TODO

This endpoint returns the base-64 encoded skykey stored under that name.

### Settings

Parameter | Description
--------- | -----------
`name` | Name of the skykey being queried.

### Response

```shell--curl
{
  "skykey": "BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a"
}
```

> TODO

Field | Type | Description
----- | ---- | -----------
`skykey` | Skykey | Full Skykey object

### Getting a Skykey By ID

```shell--curl
curl -A "Sia-Agent"  -u "":<apipassword> --data "id=gi5z8cf5NWbcvPBaBn0DFQ==" "localhost:9980/skynet/skykey"
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

This endpoint returns the base-64 encoded skykey stored under that ID.

### Settings

Parameter | Description
--------- | -----------
`id` | ID of the skykey being queried

### Response

```shell--curl
{
  "skykey": "BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a"
}
```

> TODO

Field | Type | Description
----- | ---- | -----------
`skykey` | Skykey | Full Skykey object

## Create Skykey

```shell
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/createskykey"
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

This endpoint creates a skykey stored under the given name.

### Settings

Parameter | Description
--------- | -----------
`name` | Desired name of the skykey.

### Response

Field | Type | Description
----- | ---- | -----------
`skykey` | Skykey | Full Skykey object.

## Add Skykey

```shell
curl -A "Sia-Agent"  -u "":<apipassword> --data "skykey=BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a" "localhost:9980/skynet/addskykey"
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

> TODO

This endpoint stores the given skykey with the renter's skykey manager.

### Settings

Parameter | Description
--------- | -----------
`skykey` | Base-64 encoded skykey

### Response

standard success or error response. See [standard responses](#standard-responses).

## List Skykeys

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

**TODO**
