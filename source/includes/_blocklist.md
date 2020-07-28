# Blocklist

## Getting The Blocklist

```shell--curl
curl -A "Sia-Agent" "localhost:9980/skynet/blocklist"
```

```shell--cli
Coming Soon
```

```javascript--browser
import { getBlocklist } from "skynet-js";

try {
  const blocklist = await getBlocklist("https://siasky.net");
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const blocklist = await skynet.getBlocklist();
})();
```

```python
import siaskynet as skynet

blocklist = skynet.get_blocklist()
print("Get blocklist successful, blocklist: " + blocklist)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	fmt.Println("Getting blocklist...")
	blocklist, err := skynet.GetBlocklist(skynet.DefaultGetBlocklistOptions)
	if err != nil {
		panic("Unable to get blocklist: " + err.Error())
	}
	fmt.Printf("Blocklist: %v\n", blocklist)
}
```

This function returns the list of hashed merkleroots that are blocklisted.

### Parameters

None

### Response

```shell--curl
{
  "blocklist": {
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
  }
}
```

```shell--cli
Coming Soon
```

```javascript--browser
["QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I", "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I" "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"]
```

```javascript--node
["QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I", "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I" "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"]
```

```python
["QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I", "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I" "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"]
```

```go
["QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I", "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I" "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"]
```

Field | Type | Description
----- | ---- | -----------
`blocklist` | object | The blocklist is a list of hashed merkleroots that are blocklisted.

## Editing The Blocklist

```shell--curl
// add skylinks
curl -A "Sia-Agent" --user "":<apipassword> --data '{"add" : ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g"]}' "localhost:9980/skynet/blocklist"

// remove skylinks
curl -A "Sia-Agent" --user "":<apipassword> --data '{"remove" : ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g"]}' "localhost:9980/skynet/blocklist"
```

```shell--cli
Coming Soon
```

```javascript--browser
import { updateBlocklist } from "skynet-js";

const additions = ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g", "EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"];
const removals = ["CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"];

try {
  await updateBlocklist("https://siasky.net", additions, removals);
} catch (error) {
  console.log(error)
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

const additions = ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g", "EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"];
const removals = ["CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"];

(async () => {
	await skynet.updateBlocklist(additions, removals);
	console.log("Update blocklist successful");
})();
```

```python
import siaskynet as skynet

additions = ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g", "EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"]
removals = ["CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"]

skynet.update_blocklist(additions, removals)
print("Update blocklist successful)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	const additions = ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g", "EAAV-eT8wBIF1EPgT6WQkWWsb3mYyEO1xz9iFueK5zCtqg"]
	const removals = ["CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"]

	err := skynet.UpdateBlocklist(additions, removals, skynet.DefaultUpdateBlocklistOptions)
	if err != nil {
		panic("Unable to update blocklist: " + err.Error())
	}
	fmt.Printf("Update blocklist successful")
}
```

This function updates the list of skylinks that should be blocklisted from
Skynet. It can be used to both add and remove skylinks from the blocklist.

### Parameters

<aside class="warning">At least one of the following fields needs to be non empty.</aside>

Field | Type | Description
----- | ---- | -----------
`additions` | array of strings | An array of skylinks that should be added to the blocklist.
`removals` | array of strings | An array of skylinks that should be removed from the blocklist.

### Response

Empty on success.
