# Updating From v2

[Changelog](https://github.com/NebulousLabs/skynet-js/blob/master/CHANGELOG.md)

Users wishing to update their SDK from `v2` to `v3` should note the following:

## Breaking Changes

```javascript
await client.db.setJSON(privateKey, dataKey, json, 0);
revision = revision + 1;
```

> =>

```javascript
await client.db.setJSON(privateKey, dataKey, json, BigInt(0));
revision = revision + BigInt(1);
```

### Entry Revisions Are Now bigint

Entry revisions are now `bigint` instead of `number`, since `number` did not
cover the full range of available revisions.

**Note:** setting a revision to the maximum 64-bit value can be done to prevent
changes to the entry; this was not possible by using the SDK before this change.

#### Code changes

Any explicit revision numbers must be changed from `number` to `bigint`. For
example, instead of `0` use `BigInt(0)`.

Since you cannot add `bigint`s and `number`s, any arithmetic must be fully
converted (see right).

### executeRequest Was Removed

The `executeRequest` method is no longer available on the client. It was not
intended to be exported.

#### Code changes

A possible use case was getting the raw contents of a file -- you may now
achieve this with `getFileContent`.

### The Registry Timeout Has Changed

```javascript
await client.db.getJSON(publicKey, dataKey, { timeout: 60_000 });
```

> =>

```javascript
await client.db.getJSON(publicKey, dataKey, { timeout: 60 });
```

The registry `timeout` parameter was previously interpreted as milliseconds. It
has been changed to seconds, as the timeout is now passed to `siad` which
accepts seconds.

It was also possible to set the timeout for all API requests, but now it is only
accepted by `registry.getEntry` and `db.getJSON`.

#### Code changes

Any explicit timeout specified should be changed from milliseconds to seconds.
Note that an error will be thrown if the timeout value is greater than the
maximum accepted by `siad` (300 seconds).

If you were passing `timeout` to other API calls, it will no longer have any
effect. This was not an intended usage and we don't anticipate many users being
affected by this deprecation.

### getJSON Can Return Destructured Nulls Instead Of Null

```javascript
const result = await client.db.getJSON(publicKey, dataKey);
if (result !== null) {
  const data = result.data;
  const revision = result.revision;
  /* Do something with the result */
}
```

> =>

```javascript
const { data, revision } = await client.db.getJSON(publicKey, dataKey, { timeout: 60 });
if (data !== null) {
  /* Do something with the result */
}
```

Instead of returning either an object or `null`, `db.getJSON` now always returns
an object, whose elements may be `null`. This means you can always destructure
the result without worrying about errors in the null-case. This matches the
existing behavior of `registry.getEntry`.

#### Code changes

It is probably easiest to demonstrate this with an example -- see right.

### getEntry Only Returns Null On Entry-Not-Found

Previously, `registry.getEntry` would return null when any error had occurred.
Now, it will only return null when the error from `siad` was `404`, meaning the
registry entry was not found.

#### Code changes

You may wish to catch any errors from `getEntry` or `getJSON`, as they are
likely due to a deeper issue. Previously these errors were not caught, so
entries that actually existed may have appeared not to exist (since `null` was
returned).

## Other Changes

### getFileContent

A `getFileContent` method has been added for getting the content of a file from
a skylink without downloading the file in-browser.

### More Typechecking

Be aware that almost every API method now has the potential to throw. A common
cause would be wrongly-typed inputs to a method, which are now checked. You may
or may not want to manually catch thrown errors, depending on your application.
