# Statistics

## Getting Statistics

```shell--curl
curl -A "Sia-Agent" "localhost:9980/skynet/stats"
```

```shell--cli
skynet stats
```

```javascript--browser
import { SkynetClient } from "skynet-js";

async function getStatsExample() {
  try {
    const client = new SkynetClient();
    const stats = await client.getStats();
  } catch (error) {
    console.log(error)
  }
}
```

```javascript--node
const skynet = require('@nebulous/skynet');

(async () => {
	const stats = await skynet.getStats();
})();
```

```python
import siaskynet as skynet

stats = skynet.get_stats()
print("Get stats successful, stats: " + stats)
```

```go
package main

import (
	"fmt"
	skynet "github.com/NebulousLabs/go-skynet"
)

func main() {
	fmt.Println("Getting statistics...")
	stats, err := skynet.GetStats(skynet.DefaultGetStatsOptions)
	if err != nil {
		panic("Unable to get stats: " + err.Error())
	}
	fmt.Printf("Stats: %v\n", stats)
}
```

This function returns statistical information about Skynet, e.g. number of files
uploaded, total size, etc.

### Parameters

None

### Response

```shell--curl
{
  "uptime": 1234,
  "uploadstats": {
    "numfiles": 2,
    "totalsize": 44527895
  },
  "versioninfo": {
    "version":     "1.4.4-master",
    "gitrevision": "cd5a83712"
  },
  "performancestats": {
    // Fields omitted
  }
}
```

```shell--cli
Coming Soon
```

```javascript--browser
{
  "uptime": 1234,
  "uploadstats": {
    "numfiles": 2,
    "totalsize": 44527895
  },
  "versioninfo": {
    "version":     "1.4.4-master",
    "gitrevision": "cd5a83712"
  },
  "performancestats": {
    // Fields omitted
  }
}
```

```javascript--node
{
  "uptime": 1234,
  "uploadstats": {
    "numfiles": 2,
    "totalsize": 44527895
  },
  "versioninfo": {
    "version":     "1.4.4-master",
    "gitrevision": "cd5a83712"
  },
  "performancestats": {
    // Fields omitted
  }
}
```

```python
{
  "uptime": 1234,
  "uploadstats": {
    "numfiles": 2,
    "totalsize": 44527895
  },
  "versioninfo": {
    "version":     "1.4.4-master",
    "gitrevision": "cd5a83712"
  },
  "performancestats": {
    // Fields omitted
  }
}
```

```go
{
  "uptime": 1234,
  "uploadstats": {
    "numfiles": 2,
    "totalsize": 44527895
  },
  "versioninfo": {
    "version":     "1.4.4-master",
    "gitrevision": "cd5a83712"
  },
  "performancestats": {
    // Fields omitted
  }
}
```

Field | Type | Description
----- | ---- | -----------
`uptime` | int | The amount of time in seconds that siad has been running.
`uploadstats` | `UploadStats` object | An object with statistics about the data uploaded to Skynet.
`versioninfo` | `VersionInfo` object | An object that contains the node's version information.
`performancestats` | `PerformanceStats` object | An object that contains a breakdown of performance metrics for the skynet endpoints. Things are broken down into containers based on the type of action performed. For example, there is a container for downloads less than 64kb in size. For more information, see [the Sia Docs](https://sia.tech/docs/#skynet-stats-get).

`UploadStats`:

Field | Type | Description
----- | ---- | -----------
`numfiles` | int | The total number of files uploaded to Skynet.
`totalsize` | int | The total amount of data in bytes uploaded to Skynet.

`VersionInfo`:

Field | Type | Description
----- | ---- | -----------
`version` | string | The siad version the node is running.
`gitrevision` | string | The commit hash used to build `siad`.

`PerformanceStats`:

See [the Sia Docs](https://sia.tech/docs/#skynet-stats-get).
