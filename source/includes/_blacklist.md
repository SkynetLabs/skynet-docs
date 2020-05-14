# Blacklist

## Get Blacklist

```shell
curl -A "Sia-Agent" "localhost:9980/skynet/blacklist"
```

> The above command returns JSON structured like this

```json
{
  "blacklist": {
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
    "QAf9Q7dBSbMarLvyeE6HTQmwhr7RX9VMrP9xIMzpU3I"
  }
}
```

This endpoint returns the list of merkleroots that are blacklisted.

### HTTP Request

`GET /skynet/blacklist`

### Response Fields

Field | Type | Description
----- | ---- | -----------
blacklist | object | The blacklist is a list of merkle roots, which are hashes, that are blacklisted.

## Edit Blacklist

```shell
// add skylink
curl -A "Sia-Agent" --user "":<apipassword> --data '{"add" : ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g"]}' "localhost:9980/skynet/blacklist"

// remove skylink
curl -A "Sia-Agent" --user "":<apipassword> --data '{"remove" : ["GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g","GAC38Gan6YHVpLl-bfefa7aY85fn4C0EEOt5KJ6SPmEy4g"]}' "localhost:9980/skynet/blacklist"
```

This endpoint allows to update the list of skylinks that should be blacklisted
from Skynet. It can be used to both add and remove skylinks from the blacklist.

### HTTP Request

`POST /skynet/blacklist`

### Request Body Fields

<aside class="warning">At least one of the following fields needs to be non empty</aside>

Field | Type | Description
----- | ---- | -----------
add | array of strings | add is an array of skylinks that should be added to the blacklist.
remove | array of strings | remove is an array of skylinks that should be removed from the blacklist.


### Response Fields

standard success or error response. See [standard
responses](#standard-responses).