# SkyDB

SkyDB is a framework that allows Skynet users to create decentralized accounts
and store mutable files in those accounts.

<aside class="warning">
These functions are in beta and may change in the coming weeks.
</aside>

<aside class="warning">
These functions have only been implemented for Browser JS at the moment.
</aside>

## Getting Files From SkyDB

```javascript--browser
import { FileID, FileType, SkynetClient, User } from "skynet-js";

const client = new SkynetClient();

const appID = "SkySkapp";
const filename = "foo.txt";
const user = User.New("john.doe@example.com", "supersecret");
const fileID = new FileID(appID, FileType.PublicUnencrypted, filename);

async function getFileExample() {
  try {
    client.getFile(user, fileID);
  } catch (error) {
    console.log(error)
  }
}
```

### Parameters

Field | Type | Description
----- | ---- | -----------
`user` | `User` | User's public key, as a hex-encoded string (see below).
`fileID` | `FileID` | The file identification object (see below).

### User

User's public key, as a hex-encoded string. See the examples for calculating this string from a username and password.

### FileID

FileID identifies a file.

Field | Type | Description
----- | ---- | -----------
`version` | number | The version of the `fileID` object being used. Currently `1` is expected.
`applicationID` | string | The application ID.
`fileType` | `FileType` | The type of the file (see below).
`filename` | string | The filename.

### FileType

`FileType` is an enum denoting the type of the file.

Enum | Value | Description
---- | ----- | -----------
`Invalid` | `0` | Invalid file type.
`PublicUnencrypted` | `1` | Public unencrypted file.

### Response

```javascript-browser
{
  tweak: "3b0f02e66373877503325e44b6973279d2e2a9c21e75b17adccb378d05cf40ae",
  data: "41414333544f713757324a516c6a507567744d6a453555734a676973696b59624538465571677069646659486751",
  revision: 11,
  signature: "7a971e1df2ddbb8ef1f8e71e28a5a64ffe1e5dfcb7eebb19e6c238744133ddeefc4f286488dd4500c33610711e3447b49e5a30df2e590e27ad00e56ebf3baf04",
}
```

## Setting Files On SkyDB

```javascript--browser
import { FileID, FileType, SkynetClient, SkynetFile, User } from "skynet-js";

const client = new SkynetClient();

const appID = "SkySkapp";
const filename = "foo.txt";
const user = User.New("john.doe@example.com", "supersecret");
const fileID = new FileID(appID, FileType.PublicUnencrypted, filename);

// Must have an existing File object.

async function setFileExample() {
  try {
    client.setFile(user, fileID, SkyFile.New(file);
  } catch (error) {
    console.log(error)
  }
}
```

### Parameters

Field | Type | Description
----- | ---- | -----------
`user` | string | User's public key, as a hex-encoded string. See [Getting A File From SkyDB](#getting-files-from-skydb).
`fileID` | `FileID` | The file identification object. See [Getting A File From SkyDB](#getting-files-from-skydb).
`file` | `SkyFile` | The file to set (see below).

### SkyFile

At the moment, a simple wrapper around regular `File`s. See the examples.

### Response

None on success.
