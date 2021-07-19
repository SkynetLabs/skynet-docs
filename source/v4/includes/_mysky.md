# MySky

MySky is a decentralized identity protocol that gives users their own empire of
data within Skynet. Everything that happens inside of that empire is under the
control of the user, but it can also be visited by anyone else and shared around
freely.

MySky provides a standard for declaring data in a way that makes it easy for
anyone in the world to discover that data. At the same time, it provides
standards for protecting that data, ensuring only data which is meant to be
found is discoverable by others.

MySky also provides simple yet powerful tooling that enables applications to
make use of the same data. For example, the profile information of a user like
their preferred name and avatar can be placed in a shared folder, and then
safely used and updated by all of the user’s applications. This tooling extends
to any type of data.

See [this blog
post](https://blog.sia.tech/mysky-your-home-on-the-global-operating-system-of-the-future-5a288f89825c)
for more information!

## Initializing MySky

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const hostApp = "host-app.hns";

async function mySkyExample() {
  try {
    // Initialize MySky.
    const mySky = await client.loadMySky(hostApp);
  } catch (error) {
    console.log(error)
  }
}
```

MySky can be initialized using the client. This creates the MySky iframe which
connects to the MySky handshake domain and takes care of operations such as
logging in silently, signing registry entries, getting the user ID, and logging
out.

<aside class="warning">
Note that an initialized MySky instance does <b>not</b> have a logged-in user
yet! See the section below on how to log in the user.
</aside>

### Parameters

Field | Description
----- | -----------
`skappDomain` | (Optional) The data domain for the skapp. MySky will automatically request permissions for this domain.

<aside class="success">
If the skapp domain matches the requestor domain (e.g. the `skappDomain` is
"app.hns" and your skapp is located at "app.hns") permission will be granted
automatically, by default.
</aside>

### Additional Options

Field | Description | Default
----- | ----------- | -------
`dev` | Whether to run MySky in dev mode (all requested permissions are granted by default, but production MySky data is not accessible). | `false`
`debug` | Whether to run MySky and all DACs with debugging messages enabled. DACs will run with the `?debug=true` query parameter set which they can use for their own purposes. | `false`

## Adding DACs

```javascript--browser
import { SkynetClient } from "skynet-js";
import { ContentRecordDAC } from "@skynetlabs/content-record-library";

const client = new SkynetClient();
const hostApp = "host-app.hns";

async function loadDacsExample() {
  try {
    const mySky = await client.loadMySky(hostApp);

    // Initialize DAC, auto-adding permissions.
    const dac = new ContentRecordDAC()
    await mySky.loadDacs(dac);
  } catch (error) {
    console.log(error)
  }
}
```

<aside class="success">
DAC stands for "Data Access Controller". Find out more about DACs at
<a href="https://blog.sia.tech/mysky-your-home-on-the-global-operating-system-of-the-future-5a288f89825c">this blog post</a>.
</aside>

This method loads the given DACs. They must have been instantiated previously
using the DAC library's constructor, which creates the iframe for the DAC. DACs
must also be loaded before they are ready to use.

Loading a DAC automatically adds its requested permissions to the permissions
list, so we do not need to add permissions for it manually. The user may have to
approve the DAC's permissions if it requests nonstandard permissions.

For an example of a DAC and its usage, see the
[content-record](https://github.com/SkynetLabs/content-record-library) DAC
library provided by SkynetLabs.

### Method

`mySky.loadDacs`

### Parameters

Field | Type | Description
----- | ---- | -----------
`...dacs` | `...DacLibrary[]` | One or more DACs. If you have an array, you can pass it in like `...dacsArray`.

## Adding Custom Permissions

```javascript--browser
import { Permission, PermCategory, PermType, SkynetClient } from "skynet-js";

const client = new SkynetClient();

async function addPermissionsExample() {
  try {
    const mySky = await client.loadMySky();

    // Add additional needed permissions before checkLogin.
    // Can be Permissions object or list of Permissions objects
    await mySky.addPermissions(new Permission("requestor.hns", "domain.hns/path", PermCategory.Hidden, PermType.Write));
  } catch (error) {
    console.log(error)
  }
}
```

This method lets you add one or more custom permissions, which are then
requested on login and must be approved by the user. It is useful to call this
if you want access to e.g. the data domain of a skapp other than your own.

Note that the requestor must be set manually in the `Permission` object. For
example, if you know that your skapp lives at `requestor.hns`, the requestor
should be `"requestor.hns"`.

You can request permission for either the entire domain or just a specific path.
For more information about valid paths please consult [MySky
Paths](#mysky-paths).

### Method

`mySky.addPermissions`

### Parameters

Field | Type | Description
----- | ---- | -----------
`...permissions` | `...Permission[]` | One or more permissions. If you have an array, you can pass it in like `...permsArray`.

### `Permission`

This object corresponds to a permission for a given requestor domain for the given path.

Field | Type | Description
----- | ---- | -----------
`requestor` | `string` | The requestor domain.
`path` | `string` | The path to grant permission for. Can be a directory or a root domain to grant permissions to all subpaths.
`category` | `PermCategory` | The permission category (see below).
`permType` | `PermType` | The permission type (see below).

### `PermCategory`

Permission category enum. All values are numbers. If you're not using
Typescript, you can use the provided constant instead of the enum value.

Value | Description | Constant
----- | ----------- | --------
`PermCategory.Discoverable` | Permission for discoverable files. | `PermDiscoverable`
`PermCategory.Hidden` | Permission for hidden files. | `PermHidden`
`PermCategory.LegacySkyID` | Permission for legacy SkyID files. | `PermLegacySkyID`

### `PermType`

Permission type enum. All values are numbers. If you're not using Typescript,
you can use the provided constant instead of the enum value.

Value | Description | Constant
----- | ----------- | --------
`PermType.Read` | Permission for reading. | `PermRead`
`PermType.Write` | Permission for writing. | `PermWrite`

## MySky Paths

When calling methods to write or get data, a path must be passed in. Paths can
point to a file or a directory; examples include
`sky-feed.hns/path/to/file.json` and `riftapp.hns/some/directory`.

All data
lives at a certain path. Likewise, all paths have associated permissions. So a
skapp cannot access a path, and its data, if it doesn't have permission with
MySky to do so.

### Path format

Paths have a specific format that they must follow. All paths must start with a
data domain, which usually is the domain of a skapp on Skynet, such as
`riftapp.hns`. **Note:** this should **not** include the portal, such as
`riftapp.hns.siasky.net`. Use `await client.extractDomain(url)` if you have a
full URL and need the domain.

The path may just be a data domain, for example when a skapp is requesting
permissions for all files at a domain. The path may also contain a path to a
file or directory after the data domain, with each path element separated by a
forward slash.

### Examples

Valid paths include:

<pre class="not_example">
"app.hns"
"app.hns/"
"app.hns/path/file.json"
"app.hns/path/"
"app.hns/path"
</pre>

Invalid paths include:

<pre class="not_example">
"/app.hns"
"/app.hns/path/"
"/"
""
</pre>

## Logging In

In order to actually use MySky the user will need to be logged in to a MySky
account. Most of the time, the user should already be logged in -- a single
sign-in should log a user into all MySky-compatible apps across the Skynet
ecosystem.

For that reason, your app should first attempt a silent login. If that fails,
you can initiate a popup login, where the user has the chance to enter his login
details or sign up. Note that this must be done *only* on button click, or the
popup window will be blocked by most popup blockers!

## Check Login (Silent Login)

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const hostApp = "host-app.hns";

async function checkLoginExample() {
  try {
    const mySky = await client.loadMySky(hostApp);

    // Try to login silently, requesting permissions for host-app.hns.
    const loggedIn = await mySky.checkLogin();
  } catch (error) {
    console.log(error)
  }
}
```

Makes an initial silent login attempt with the previously set permissions.

### Method

`mySky.checkLogin`

### Parameters

None. Any requested permissions should be set earlier through `mySky.addPermissions`.

### Response

```javascript-browser
true
```

## Request Login Access (Popup Login)

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const hostApp = "host-app.hns";

async function requestLoginAccessExample() {
  try {
    const mySky = await client.loadMySky(hostApp);

    const loggedIn = await mySky.checkLogin();

    // Add button action for login.
    if (!loggedIn) {
      document
        .getObjectByID("login-button")
        .addEventListener("click", mySky.requestLoginAccess());
    }
  } catch (error) {
    console.log(error)
  }
}
```

Popup login method to call if the silent login failed.

<aside class="warning">
Note that this must be done *only* on button click, or the popup window will be
blocked by most popup blockers!
</aside>

### Method

`mySky.requestLoginAccess`

### Parameters

None. Any requested permissions should be set earlier through `mySky.addPermissions`.

```javascript-browser
true
```

## Getting And Setting User Data

Once a user is logged in, the app will be able to get and set data in the user's
filesystem, as long as the app has permissions for the filepath it is trying to
access as well as for the type of data (Discoverable or Hidden) being read or
written.

<aside class="success">
MySky enforces that apps trying to access a user's filesystem have permission by
looking at the <i>referrer</i> for requests. The permissions provider will
determine whether permission had previously been granted to that requestor for
the requested filepath.
</aside>

## Getting Discoverable JSON

```javascript--browser
// Assume we have a logged-in mysky instance from above

async function getJSONExample() {
  try {
    // Get discoverable JSON data from the given path.
    const { data, dataLink } = await mySky.getJSON("app.hns/path/file.json");
  } catch (error) {
    console.log(error)
  }
}
```

### Method

`mySky.getJSON`

### Parameters

Field | Type | Description
----- | ---- | -----------
`path` | `string` | The data path.
`customOptions` | `Object` | Custom options to pass into this method. See below.

### Optional Parameters

Field | Description | Default
----- | ----------- | -------
`endpointGetEntry` | The relative URL path of the portal endpoint to contact. | `/skynet/registry`

### Response

```javascript-browser
{
  data: {
    example: "This is some example JSON data."
  },
  dataLink: "sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
}
```

## Setting Discoverable JSON

```javascript--browser
// Assume we have a logged-in mysky instance from above

async function setJSONExample() {
  try {
    // Set discoverable JSON data at the given path. The return type is the same as getJSON.
    const { data, dataLink } = await mySky.setJSON("app.hns/path/file.json", { message: "hello" });
  } catch (error) {
    console.log(error)
  }
}
```

### Method

`mySky.setJSON`

### Parameters

Field | Type | Description
----- | ---- | -----------
`path` | `string` | The data path.
`json` | `Object` | The data to set.
`customOptions` | `Object` | Custom options to pass into this method. See below.

### Optional Parameters

Field | Description | Default
----- | ----------- | -------
`endpointGetEntry` | The relative URL path of the portal endpoint to contact. | `/skynet/registry`
`endpointSetEntry` | The relative URL path of the portal endpoint to contact. | `/skynet/registry`

### Response

```javascript-browser
{
  data: {
    example: "This is some example JSON data."
  },
  dataLink: "sia://CABAB_1Dt0FJsxqsu_J4TodNCbCGvtFf1Uys_3EgzOlTcg"
}
```
