# Statistics


## Get Stats

```shell
curl -A "Sia-Agent" "localhost:9980/skynet/stats"
```

> The above command returns JSON structured like this

```json
{
  "uploadstats": {
    "numfiles": 2,
    "totalsize": 44527895
  },
  "versioninfo": {
    "version":     "1.4.4-master",
    "gitrevision": "cd5a83712"
  },
  "performancestats": {
  }
}
```

This endpoint returns statistical information about Skynet, e.g. number of files uploaded

### HTTP Request

`GET /skynet/stats`

### Response Fields

Field | Type | Description
----- | ---- | -----------
uploadstats | object | Uploadstats is an object with statistics about the data uploaded to Skynet.
numfiles | int | Numfiles is the total number of files uploaded to Skynet.
totalsize | int | Totalsize is the total amount of data in bytes uploaded to Skynet.
versioninfo | object | Versioninfo is an object that contains the node's version information.
version | string | Version is the siad version the node is running.
gitrevision | string | Gitrevision refers to the commit hash used to build said.
performancestats | object |  PerformanceStats is an object that contains a breakdown of performance metrics for the skynet endpoints. Things are broken down into containers based on the type of action performed. For example, there is a container for downloads less than 64kb in size. <br><br>Within each container, there is a bucket of half lives. Every time a data point is added to a container, it is put in to every bucket, counting up the total number of requests. The buckets decay at the stated half life, which means they give a good representation of how much activity there has been over twice their halflife. So for the one minute bucket, the total number of datapoints in the bucket is a good representation of how many things have happened in the past two minutes.<br><br>Within each bucket, there are several fields. For example, the n60ms field represents the number of requests that finished in under 60ms. There is an NErr field which gets incremented if there is a failure that can be attributed to siad.<br><br>Every download request will go into the TimeToFirstByte container, as well as the appropriate download container based on the size of the download. Within the chosen containers, every bucket will have the same field incremented. The field that gets incremented is the one that corresponds to the amount of time the request took.<br><br>The performance stats fields are not protected by a compatibility promise, and may change over time.