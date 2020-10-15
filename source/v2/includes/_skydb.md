# SkyDB

SkyDB is a framework that allows Skynet users to create decentralized accounts
and store mutable files in those accounts.

<aside class="warning">
These functions have only been implemented for Browser JS at the moment.
</aside>

## Getting Files From SkyDB

```javascript--browser
import { FileType, NewFileID, SkynetClient, User } from "skynet-js";

const client = new SkynetClient();

const appID = "SkySkapp";
const filename = "foo.txt";
const user = User.New("john.doe@example.com", "supersecret");
const fileID = NewFileID(appID, FileType.PublicUnencrypted, filename);

async function getFileExample() {
  try {
    getFile(user, fileID);
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
  Tweak: "",
  Data: "CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg",
  Revision: 11,
  Signature: "",
}
```

## Setting Files On SkyDB

```javascript--browser
import { FileType, NewFileID, SkynetClient, SkynetFile, User } from "skynet-js";

const client = new SkynetClient();

const appID = "SkySkapp";
const filename = "foo.txt";
const user = User.New("john.doe@example.com", "supersecret");
const fileID = NewFileID(appID, FileType.PublicUnencrypted, filename);

// Must have an existing File object.

async function setFileExample() {
  try {
    setFile(user, fileID, SkyFile.New(file);
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
