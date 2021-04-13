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

## Additional Options

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

async function mySkyExample() {
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

TODO

## Adding Custom Permissions

```javascript--browser
import { Permission, PermCategory, PermType, SkynetClient } from "skynet-js";

const client = new SkynetClient();

async function mySkyExample() {
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

TODO

## Logging In

In order to actually use MySky the user will need to be logged in to a MySky
account. Most of the time, the user should already be logged in -- a single
sign-in should log a user into all MySky-compatible apps across the Skynet
ecosystem.

For that reason, your app should first attempt a silent login. If that fails,
you can initiate a popup login, where the user has the chance to enter his login
details or sign up. Note that this must be done *only* on button click, or the
popup window will be blocked by most popup blockers!

## Silent Login

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const hostApp = "host-app.hns";

async function mySkyExample() {
  try {
    const mySky = await client.loadMySky(hostApp);

    // Try to login silently, requesting permissions for host-app.hns.
    const loggedIn = await mySky.checkLogin();
  } catch (error) {
    console.log(error)
  }
}
```

TODO

## Popup Login

```javascript--browser
import { SkynetClient } from "skynet-js";

const client = new SkynetClient();
const hostApp = "host-app.hns";

async function mySkyExample() {
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

<aside class="warning">
Note that this must be done *only* on button click, or the popup window will be
blocked by most popup blockers!
</aside>

TODO

## Getting And Setting User Data

Once a user is logged in, the app will be able to get and set data in their
filesystem, as long as it has permissions for the filepath it is trying to
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

async function mySkyExample() {
  try {
    // Get discoverable JSON data from the given path.
    const { data, skylink } = await mysky.getJSON("app.hns/path/file.json");
  } catch (error) {
    console.log(error)
  }
}
```

TODO

## Setting Discoverable JSON

```javascript--browser
// Assume we have a logged-in mysky instance from above

async function mySkyExample() {
  try {
    // Set discoverable JSON data at the given path. The return type is the same as getJSON.
    const { data, skylink } = await mysky.setJSON("app.hns/path/file.json", { message: "hello" });
  } catch (error) {
    console.log(error)
  }
}
```

TODO
