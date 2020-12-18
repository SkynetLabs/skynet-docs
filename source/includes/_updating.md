# Updating From v1

Users wishing to update their SDK from `v1` to `v2` should note the following:

1. All SDKs have been updated to match Browser JS and require a client. You will
   first need to create a client and then make all API calls from this client.
2. The `defaultPortalUrl` string has been renamed to `defaultSkynetPortalUrl`
   and `defaultPortalUrl` is not a function.
3. Browser JS has had the following updates:
  1. `download` and `open` were renamed to `downloadFile` and `openFile`.
  2. `upload` was renamed to `uploadFile` and the response was changed to only
     include a skylink. To obtain the full response as in the old `upload`, use
     the new `uploadFileRequest`.
  3. `uploadFile` and `uploadDirectory` now return skylinks prefixed by `sia:`.
  4. `getDownloadUrl` has been renamed to `getSkylinkUrl`.
