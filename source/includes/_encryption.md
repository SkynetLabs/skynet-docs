# Encryption



## Getting a Skykey

```shell
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/skykey"
curl -A "Sia-Agent"  -u "":<apipassword> --data "id=gi5z8cf5NWbcvPBaBn0DFQ==" "localhost:9980/skynet/skykey"
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const name = "testcreateskykey"
	const id = "pJAPPfWkWXpss3BvMDCJCw=="

	fmt.Printf("Getting skykey with name %v...\n", name)
	skykey, err := skynet.GetSkykey(name, "", skynet.DefaultGetSkykeyOptions)
	if err != nil {
		fmt.Println("Unable to get skykey:", err.Error())
		return
	}
	fmt.Printf("Skykey: %v\n", skykey)

	fmt.Printf("Getting skykey with id %v...\n", id)
	skykey, err = skynet.GetSkykey("", id, skynet.DefaultGetSkykeyOptions)
	if err != nil {
		fmt.Println("Unable to get skykey:", err.Error())
		return
	}
	fmt.Printf("Skykey: %v\n", skykey)
}
```

> The above command returns JSON structured like this

```json
{
  "skykey": "BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a"
}
```

This endpoint returns the base-64 encoded skykey stored under that name, or with
that ID.

### HTTP Request
`GET /skynet/skykey/<name|id>`

### URL Parameters

Parameter | Description
--------- | -----------
name | name of the skykey being queried
id | base-64 encoded ID of the skykey being queried

### Response Fields

Field | Type | Description
----- | ---- | -----------
skykey | string | base-64 encoded skykey

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
	const name = "testcreateskykey2"
	const skykeyType = "private-id"

	fmt.Printf("Creating skykey with name %v...\n", name)
	skykey, err := skynet.CreateSkykey(name, skykeyType, skynet.DefaultCreateSkykeyOptions)
	if err != nil {
		fmt.Println("Unable to create skykey:", err.Error())
		return
	}
	fmt.Printf("Created skykey %v\n", skykey)
```

> The above command returns JSON structured like this

```json
{
  "skykey": "BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a"
}
```

**UNSTABLE - subject to change in v1.4.9**

This endpoint creates a skykey stored under the given name.

### HTTP Request
`POST /skynet/createskykey/<name>`

### URL Parameters

Parameter | Description
--------- | -----------
name | desired name of the skykey

### Response Fields

Field | Type | Description
----- | ---- | -----------
skykey | string | base-64 encoded skykey

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
		fmt.Println("Unable to add skykey:", err.Error())
		return
	}
```

**UNSTABLE - subject to change in v1.4.9**

This endpoint stores the given skykey with the renter's skykey manager.

### HTTP Request

`POST /skynet/addskykey/<skykey>`

### URL Parameters

Parameter | Description
--------- | -----------
skykey | base-64 encoded skykey

### Response

standard success or error response. See [standard
responses](#standard-responses).

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
		fmt.Println("Unable to get skykeys:", err.Error())
		return
	}
	fmt.Printf("Skykeys: %v\n", skykeys)
}
```

**TODO**
