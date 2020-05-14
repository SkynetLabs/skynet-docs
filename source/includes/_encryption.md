# Encryption

## Get Skykey

```shell
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/skykey"
curl -A "Sia-Agent"  -u "":<apipassword> --data "id=gi5z8cf5NWbcvPBaBn0DFQ==" "localhost:9980/skynet/skykey"
```

> The above command returns JSON structured like this

```json
{
  "skykey": "BAAAAAAAAABrZXkxAAAAAAAAAAQgAAAAAAAAADiObVg49-0juJ8udAx4qMW-TEHgDxfjA0fjJSNBuJ4a"
}
```

**UNSTABLE - subject to change in v1.4.9**

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


## Get Skykey ID

```shell
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/skykeyid"
```

> The above command returns JSON structured like this

```json
{
  "skykeyid": "gi5z8cf5NWbcvPBaBn0DFQ=="
}
```

**UNSTABLE - subject to change in v1.4.9**

This endpoint returns the base-64 encoded ID of the skykey stored under that
name.

### HTTP Request
`GET /skynet/skykeyid/<name>`

### URL Parameters

Parameter | Description
--------- | -----------
name | name of the skykey being queried

### Response Fields

Field | Type | Description
----- | ---- | -----------
skykeyid | string | base-64 encoded skykey ID

## Create Skykey

```shell
curl -A "Sia-Agent"  -u "":<apipassword> --data "name=key_to_the_castle" "localhost:9980/skynet/createskykey"
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