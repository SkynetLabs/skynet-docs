# Portals

## Get Portals

```shell
curl -A "Sia-Agent" "localhost:9980/skynet/portals"
```

> The above command returns JSON structured like this

```json
{
  "portals": [
    {
      "address": "siasky.net:443",
      "public":  true
    }
  ]
}
```

This endpoint returns the list of known Skynet portals.

### HTTP Request

`GET /skynet/portals`

### Response Fields

Field | Type | Description
----- | ---- | -----------
address | string | The IP or domain name and the port of the portal. Must be a valid network address.
public | bool | Indicates whether the portal can be accessed publicly or not.

## Edit Portals

```shell
// add portal
curl -A "Sia-Agent" --user "":<apipassword> --data '{"add" : [{"address":"siasky.net:443","public":true}]}' "localhost:9980/skynet/portals"

// remove portal
curl -A "Sia-Agent" --user "":<apipassword> --data '{"remove" : ["siasky.net:443"]}' "localhost:9980/skynet/portals"
```

This endpoint allows to update the list of known Skynet portals. It can be used
to both add and remove portals from the list.

### HTTP Request

`POST /skynet/portals`

### Request Body Fields

<aside class="warning">At least one of the following fields needs to be non empty</aside>

Field | Type | Description
----- | ---- | -----------
add | array of SkynetPortal | add is an array of portal info that should be added to the list of portals.
remove | array of strings | remove is an array of portal network addresses that should be removed from the
list of portals.

### Response Fields

standard success or error response. See [standard
responses](#standard-responses).