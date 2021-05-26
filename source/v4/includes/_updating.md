# Updating From v3

[Changelog](https://github.com/SkynetLabs/skynet-js/blob/master/CHANGELOG-BETA.md)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Updating From v3](#updating-from-v3)
    - [Upgrading](#upgrading)
    - [Installing a DAC](#installing-a-dac)
    - [Breaking Changes](#breaking-changes)
        - [SkyDB getJSON returns a data link instead of a revision number](#skydb-getjson-returns-a-data-link-instead-of-a-revision-number)
        - [SkyDB setJSON no longer accepts an optional revision number](#skydb-setjson-no-longer-accepts-an-optional-revision-number)
        - [getSkylinkUrl, downloadFile, openFile, and the HNS equivalents are all now async](#getskylinkurl-downloadfile-openfile-and-the-hns-equivalents-are-all-now-async)
        - [portalUrl is now an async method instead of a variable](#portalurl-is-now-an-async-method-instead-of-a-variable)
        - [Renamed RegistryEntry datakey to dataKey for consistency](#renamed-registryentry-datakey-to-datakey-for-consistency)
        - [The getEntry timeout option has been removed as it no longer has an effect](#the-getentry-timeout-option-has-been-removed-as-it-no-longer-has-an-effect)
        - [getFileContent and getFileContentHns no longer return metadata](#getfilecontent-and-getfilecontenthns-no-longer-return-metadata)
        - [getMetadata no longer returns contentType](#getmetadata-no-longer-returns-contenttype)
        - [Registry entries now take data that is type Uint8Array instead of string](#registry-entries-now-take-data-that-is-type-uint8array-instead-of-string)
        - [The sia: skylink prefix has been changed to sia://](#the-sia-skylink-prefix-has-been-changed-to-sia)
        - [Skylinks returned from SkyDB all start with sia://](#skylinks-returned-from-skydb-all-start-with-sia)

<!-- markdown-toc end -->

We recently made a breaking change from `v3` of the SDK to the newest version,
`v4`. We needed to make some non-async methods async, and to remove `revision` from SkyDB and change the return
types of the SkyDB methods. Additionally, this version marks the release of
MySky and Data Access Controllers (DACs).

We understand that updating your code to accommodate breaking changes is
inconvenient, so we put together this guide which we hope will be helpful.

## Upgrading

```sh
npm install skynet-js@4.0.1-beta
```

To upgrade to v4 (see right):

Note that just `npm install` will not work. This is by design: you must
explicitly opt-in to new major versions as they contain breaking changes.

## Installing a DAC

To use MySky to its fullest potential you may additionally want to install a
DAC. These are used through libraries which can be installed and imported from
like regular libraries.

```sh
npm install @skynetlabs/content-record-library
```

For example, to install SkynetLabs's official Content Record DAC (see right):

Usage instructions can be found [here](https://github.com/SkynetLabs/content-record-library).

## Breaking Changes

### SkyDB getJSON returns a data link instead of a revision number

```javascript
const { data, revision } = await client.db.getJSON(publicKey, dataKey);
```

> =>

```javascript
const { data, dataLink } = await client.db.getJSON(publicKey, dataKey);
```

Revision numbers have been removed from SkyDB and the return value of `getJSON`
changed according. See right.

#### Required code changes

Please do a search for `getJSON` in your code and double-check that you are not
using the returned `revision`, and remove it if you are. You no longer need to
pass `revision` into `setJSON` (see below).

### SkyDB setJSON no longer accepts an optional revision number

```javascript
await client.db.setJSON(privateKey, dataKey, json, revision, customOptions);
```

> =>

```javascript
await client.db.setJSON(privateKey, dataKey, json, customOptions);
```

**Note:** `setJSON` also has been changed to have the same return type as `getJSON`.

#### Required code changes

Please do a search for `setJSON` in your code and double-check that you are not
passing in `revision`, and remove it if you are. You no longer need to pass
`revision` into `setJSON`.

### getSkylinkUrl, downloadFile, openFile, and the HNS equivalents are all now async

```javascript
const skylinkUrl = client.getSkylinkUrl(skylink);
downloadFile(skylink);
openFile(skylink);
```

> =>

```javascript
const skylinkUrl = await client.getSkylinkUrl(skylink);
await downloadFile(skylink);
await openFile(skylink);
// ... same with HNS versions of these methods.
```

The Skynet Client now silently fetches the portal API URL the first time it is
needed (you can trigger this manually with the new `client.initPortalUrl()`).
This means that all methods that take skylinks or operate on them internally
must be async.

#### Required code changes

Please do a search for affected functions in your code and make sure you prepend
`async` if you expect the functions to be blocking.

### portalUrl is now an async method instead of a variable

```javascript
const portalUrl = client.portalUrl;
```

> =>

```javascript
const portalUrl = await client.portalUrl();
```

In line with the above change, `client.portalUrl` is now an async method as it
will make a request for the portal API URL the first time it is called.

#### Required code changes

Please do a search for where you may be using `client.portalUrl` in your code
and make the necessary changes, as shown on the right.

### Renamed RegistryEntry datakey to dataKey for consistency

```javascript
const dataKey = "abcd";
const entry = { datakey: dataKey, data, revision };
```

> =>

```javascript
const dataKey = "abcd";
const entry = { dataKey, data, revision };
```

The `RegistryEntry` "datakey" field has been renamed to "dataKey" for
consistency with the rest of the codebase.

#### Required code changes

Please do a search for any instance of `datakey` (case-sensitive) in your code
and replace it with `dataKey`.

### The getEntry timeout option has been removed as it no longer has an effect

```javascript
await client.registry.getEntry(publicKey, dataKey, { timeout: 10 });
```

> =>

```javascript
await client.registry.getEntry(publicKey, dataKey);
```

The `timeout` optional option has been removed.

#### Required code changes

Please do a search for "timeout" in your code and remove it if using as an
option to `getEntry`. You will get a runtime error if you don't make the change.

### getFileContent and getFileContentHns no longer return metadata

```javascript
const { skylink, metadata } = await client.getFileContent(skylink);
```

> =>

```javascript
const { skylink } = await client.getFileContent(skylink);
const { metadata } = await client.getMetadata(skylink);
```

The metadata was too large to be returned in headers. It now has its own method
and can only be obtained with `getMetadata`.

#### Required code changes

The metadata is no longer returned from these methods. Use the dedicated `getMetadata` method to get the metadata. See right.

### getMetadata no longer returns contentType

The `getMetadata` method no longer returns a separate `contentType` field as it
is now a part of the metadata itself.

### Registry entries now take data that is type Uint8Array instead of string

```javascript
const entry = RegistryEntry { dataKey, data: "hello", revision };
await client.registry.setEntry(privateKey, entry);
const { entry } = client.registry.getEntry(publicKey, dataKey);
const data = entry.data; // Previously, this was a string.
```

> =>

```javascript
import { stringToUint8ArrayUtf8, uint8ArrayToStringUtf8 } from "skynet-js";

const entry = RegistryEntry { dataKey, data: stringToUint8ArrayUtf8("hello"), revision };
await client.registry.setEntry(privateKey, entry);
const { entry } = client.registry.getEntry(publicKey, dataKey);
const data = uint8ArrayToStringUtf8(entry.data); // Now, this is a Uint8Array
```

The type of `RegistryEntry.data` has changed. In order to maintain
compatibility, please make sure you convert any string data to `Uint8Array` before
calling `setEntry`, and that you convert `Uint8Array` back to a string on the
returned data after calling `getEntry`.

You should still be able to read entries set using older versions of the SDK,
including SkyDB entries, but older versions may no longer be able to read
entries set using the new version.

#### Required code changes

Please use the provided conversion functions `stringToUint8ArrayUtf8` and
`uint8ArrayToStringUtf8` if you wish to continue using strings instead of raw
bytes when working with entry data. See right.

### The sia: skylink prefix has been changed to sia://

Please be aware of this change when working with any skylinks returned from the
API.

### Skylinks returned from SkyDB all start with sia://

Previously, some skylinks returned from SkyDB did not contain either the `sia:`
or the `sia://` prefix. Please be aware that they now start with the new prefix
(see above).
