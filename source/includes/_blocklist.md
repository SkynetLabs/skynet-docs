# Blocklist

## Get Blocklist

```shell--curl
curl -A "Sia-Agent" "localhost:9980/skynet/blocklist"
```

> The above command returns JSON structured like this

```json
{
  "blocklist": {
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
  }
}
```

This endpoint returns the list of merkleroots that are blocklisted.

### Response Fields

Field | Type | Description
----- | ---- | -----------
blocklist | object | The blocklist is a list of merkle roots, which are hashes, that are blocklisted.

## Edit Blocklist

```shell--curl
// add skylink
curl -A "Sia-Agent" --user "":<apipassword> --data '{"add" : ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g"]}' "localhost:9980/skynet/blocklist"

// remove skylink
curl -A "Sia-Agent" --user "":<apipassword> --data '{"remove" : ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g"]}' "localhost:9980/skynet/blocklist"
```

This endpoint allows to update the list of skylinks that should be blocklisted
from Skynet. It can be used to both add and remove skylinks from the blocklist.

### Request Body Fields

<aside class="warning">At least one of the following fields needs to be non empty</aside>

Field | Type | Description
----- | ---- | -----------
`add` | array of strings | add is an array of skylinks that should be added to the blocklist.
`remove` | array of strings | remove is an array of skylinks that should be removed from the blocklist.

### Response Fields

standard success or error response. See [standard
responses](#standard-responses).
