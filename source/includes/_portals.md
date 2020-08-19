# Portals

## Getting The List Of Portals

```shell--curl
curl -A "Sia-Agent" "localhost:9980/skynet/portals"
```

```shell--cli
Coming Soon
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();

async function getPortalsExample() {
  try {
    const portals = await client.getPortals();
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

(async () => {
	const portals = await skynet.getPortals();
})();
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

portals = skynet.get_portals()
print("Get portals successful, portals: " + portals)
```

```go
// NOTE: this function has not yet been implemented for this SDK.

package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	fmt.Println("Getting portals...")
	portals, err := skynet.GetPortals(skynet.DefaultGetPortalsOptions)
	if err != nil {
		panic("Unable to get portals: " + err.Error())
	}
	fmt.Printf("Portals: %+v\n", portals)
}
```

This function returns the list of known Skynet portals.

### Settings

None

### Response

```shell--curl
{
  "portals": [
    {
      "address": "siasky.net:443",
      "public":  true
    }
  ]
}
```

```shell--cli
Coming Soon
```

```javascript--browser
[{"address": "siasky.net:443", "public": true}]
```

```javascript--node
[{"address": "siasky.net:443", "public": true}]
```

```python
[{"address": "siasky.net:443", "public": true}]
```

```go
[{"address": "siasky.net:443", "public": true}]
```

Field | Type | Description
----- | ---- | -----------
`portals` | array of `Portal` | The list of known Skynet portals.

`Portal`:

Field | Type | Description
----- | ---- | -----------
`address` | string | The IP or domain name and the port of the portal. Must be a valid network address.
`public` | bool | Indicates whether the portal can be accessed publicly or not.

## Editing The List Of Portals

```shell--curl
// add portal
curl -A "Sia-Agent" --user "":<apipassword> --data '{"add" : [{"address":"siasky.net:443","public":true}]}' "localhost:9980/skynet/portals"

// remove portal
curl -A "Sia-Agent" --user "":<apipassword> --data '{"remove" : ["siasky.net:443"]}' "localhost:9980/skynet/portals"
```

```shell--cli
Coming Soon
```

```javascript--browser
// NOTE: this function has not yet been implemented for this SDK.

import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const additions = [
  {
    address: "https://localhost:9980",
    public: true
  }
];
const removals = ["https://localhost:997"];

async function updatePortalsExample() {
  try {
    await client.updatePortals(additions, removals);
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
// NOTE: this function has not yet been implemented for this SDK.

const skynet = require('@nebulous/skynet');

const additions = [
  {
    address: "https://localhost:9980",
    public: true
  }
];
const removals = ["https://localhost:997"];

(async () => {
	await skynet.updatePortals(additions, removals);
	console.log("Update portals successful");
```

```python
# NOTE: this function has not yet been implemented for this SDK.

import siaskynet as skynet

additions = [
	{
		address: "https://localhost:9980",
		public: true
	}
]
const removals = ["https://localhost:997"]

skynet.update_portals(additions, removals)
print("Update portals successful)
```

```go
// NOTE: this function has not yet been implemented for this SDK.

package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	var additions = []skynet.Portal{
		Portal{
			Address: "https://localhost:9980",
			Public: true,
		},
	}
	var removals = []string{"https://localhost:997"}

	err := skynet.UpdatePortals(additions, removals, skynet.DefaultUpdatePortalsOptions)
	if err != nil {
		panic("Unable to update portals: " + err.Error())
	}
	fmt.Printf("Update portals successful")
}
```

This function updates the list of known Skynet portals. It can be used to both
add and remove portals from the list.

### Settings

<aside class="warning">At least one of the following fields needs to be non empty.</aside>

Field | Type | Description
----- | ---- | -----------
`additions` | array of `Portal` | An array of portal info that should be added to the list of portals.
`removals` | array of strings | An array of portal network addresses that should be removed from the list of portals.

`Portal`:

See [Getting The List Of Portals](.#getting-the-list-of-portals).

### Response

Empty on success.
