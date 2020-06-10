# Skynet SDK Docs

Documentation for the Skynet SDKs in various languages.

## Status of SDKs

### Supported functions

The following is a list of functionality and whether it is supported by each language. Cells marked by `**` are not yet documented.

Functionality | JavaScript | Python | Go
-- | -- | -- | --
Get blacklist | **Not supported** | **Not supported** | **Not supported**
Update blacklist | **Not supported** | **Not supported** | **Not supported**
-- | -- | -- | --
Get portal | **Not supported** | **Not supported** | **Not supported**
Update portal | **Not supported** | **Not supported** | **Not supported**
-- | -- | -- | --
Upload file | `UploadFile` | `upload_file` | `UploadFile`
Upload directory | `UploadDirectory` | `upload_directory` | `UploadDirectory`
-- | -- | -- | --
Download file | ** `DownloadFile` | ** `download_file` | ** `DownloadFile`
Download skylink headers | **Not supported** | ** `metadata` | **Not supported**
-- | -- | -- | --
Get stats (e.g. number of files uploaded) | **Not supported** | **Not supported** | **Not supported**
-- | -- | -- | --
Add skykey | **Not supported** | **Not supported** | **Not supported**
List all skykeys | **Not supported** | **Not supported** | **Not supported**
Create skykey | **Not supported** | **Not supported** | **Not supported**
Get skykey by name or id | **Not supported** | **Not supported** | **Not supported**
Get skykey id by name | **Not supported** | **Not supported** | **Not supported**

### Supported constants

Constant | JavaScript | Python | Go
-- | -- | -- | --
Skynet URI prefix | **Not supported** | `uri_skynet_prefix()` | **Not supported**
Default upload options | `DefaultUploadOptions` | `default_upload_options` | `DefaultUploadOptions`
Default download options | `DefaultDownloadOptions` | `default_download_options` | `DefaultDownloadOptions`

### Unit tests

Test | JavaScript | Python | Go
-- | -- | -- | --
Directory walking | **No** | **No** | **No**

### Misc

-- | JavaScript | Python | Go
-- | -- | -- | --
Ability to set request timeout | **No** | **Open PR** | **No**

## Building the docs

For information on building the docs using [Slate](https://github.com/slatedocs/slate) see [here](https://github.com/slatedocs/slate/wiki#getting-started).
