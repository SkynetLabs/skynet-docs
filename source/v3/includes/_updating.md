# Updating From v2

[Changelog](https://github.com/NebulousLabs/skynet-js/blob/master/CHANGELOG.md)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Updating From v2](#updating-from-v2)
    - [Installation](#installation)
    - [Breaking Changes](#breaking-changes)
        - [Entry Revisions Are Now bigint](#entry-revisions-are-now-bigint)
        - [Upload Methods Return An Object](#upload-methods-return-an-object)
        - [Upload Request Methods Were Removed](#upload-request-methods-were-removed)
        - [getMetadata Returns An Object Containing Metadata In A Subfield](#getmetadata-returns-an-object-containing-metadata-in-a-subfield)
        - [executeRequest Was Removed](#executerequest-was-removed)
        - [The Registry Timeout Has Changed](#the-registry-timeout-has-changed)
        - [getJSON Can Return Destructured Nulls Instead Of Null](#getjson-can-return-destructured-nulls-instead-of-null)
        - [getEntry Only Returns Null On Entry-Not-Found](#getentry-only-returns-null-on-entry-not-found)
    - [Other Changes](#other-changes)
        - [getFileContent](#getfilecontent)
        - [More Typechecking](#more-typechecking)

<!-- markdown-toc end -->

We recently made a breaking change from `v2` of the SDK to the newest version,
`v3`. We needed to change the data type of revision numbers in order to support
the full range of possible values. Since this was already a compatibility break,
we additionally implemented many improvements that should make the SDK easier to
use and more consistent.

We understand that updating your code to accommodate breaking changes is
inconvenient, so we put together this guide which we hope will be helpful.

## Breaking Changes

### Entry Revisions Are Now bigint

```javascript
await client.db.setJSON(privateKey, dataKey, json, 0);
revision = revision + 1;
```

> =>

```javascript
await client.db.setJSON(privateKey, dataKey, json, BigInt(0));
revision = revision + BigInt(1);
```

Entry revisions are now `bigint` instead of `number`, since `number` did not
cover the full range of available revisions.

**Note:** setting a revision to the maximum 64-bit value can be done to prevent
changes to the entry; this was not possible by using the SDK before this change.

#### Required code changes

Any explicit revision numbers must be changed from `number` to `bigint`. For
example, instead of `0` use `BigInt(0)`.

Since you cannot add `bigint`s and `number`s, any arithmetic must be fully
converted (see right).

### Upload Methods Return An Object

```javascript
const skylink = await client.uploadFile(file);
```

> =>

```javascript
const { skylink, merkleroot, bitfield } = await client.uploadFile(file);
```

The `uploadFile` and `uploadDirectory` methods now return an object instead of
only a skylink. This allowed us to remove the upload request methods (see
below), which we hope this will simplify the API while allowing us to
potentially return more information in the object in the future, without a
breaking change.

#### Required code changes

Change all calls to `uploadFile` and `uploadDirectory`. See right.

### Upload Request Methods Were Removed

```javascript
const data = await client.uploadFileRequest(file);
const merkleroot = data.merkleroot;
```

> =>

```javascript
const { merkleroot } = await client.uploadFile(file);
```

We are no longer exposing request methods and are instead returning more
information from `uploadFile` and `uploadDirectory` (see above).

#### Required code changes

Change all calls to `uploadFileRequest` to `uploadFile` and `uploadDirectoryRequest` to
`uploadDirectory`.

### getMetadata Returns An Object Containing Metadata In A Subfield

```javascript
const metadata = await client.getMetadata(skylink);
```

> =>

```javascript
const { metadata, contentType, skylink } = await client.getMetadata(skylink);
```

The `getMetadata` method now returns an object instead of only the metadata.

#### Required code changes

Change all calls to `getMetadata`. See right.

### executeRequest Was Removed

The `executeRequest` method is no longer available on the client. It was not
intended to be exported.

#### Required code changes

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

#### Required code changes

Any explicit timeout specified should be changed from milliseconds to seconds.
Note that an error will be thrown if the timeout value is greater than the
maximum accepted by `siad` (300 seconds).

If you were passing `timeout` to other API calls, it will no longer have any
effect. This was not an intended usage and we don't anticipate many users being
affected by this change.

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

#### Required code changes

It is probably easiest to demonstrate this with an example -- see right.

### getEntry Only Returns Null On Entry-Not-Found

```javascript
const { entry } = await client.registry.getEntry(publicKey, dataKey);
```

> =>

```javascript
try {
  const { entry } = await client.registry.getEntry(publicKey, dataKey);
} catch (err) {
  /* Handle the error */
}
```

Previously, `registry.getEntry` would return null when any error had occurred.
Now, it will only return null when the error from `siad` was `404`, meaning the
registry entry was not found.

#### Required code changes

You may wish to catch any errors from `getEntry` or `getJSON`, as they are
likely due to a deeper issue. Previously these errors were not caught, so
entries that actually existed may have appeared not to exist (since `null` was
returned).

## Other Changes

### getFileContent

A `getFileContent` [method](#loading-a-file-39-s-contents) has been added for
getting the content of a file from a skylink without downloading the file
in-browser.

### More Typechecking

Be aware that almost every API method now has the potential to throw. A common
cause would be wrongly-typed inputs to a method, which are now checked. You may
or may not want to manually catch thrown errors, depending on your application.

Writing your application in Typescript is a good way to prevent type errors from
being thrown at runtime.
