---
title: Skynet Docs

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python
  - go

toc_footers:
  # - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - upload
  - downloading
  - encryption
  - blacklist
  - portals
  - statistics
  - authentication
  - responses

search: true
---

# Introduction

Welcome to the Skynet SDK docs!

We have SDK support for several languages. You can view code examples in the
dark area to the right. Switch to the programming language of your choice by
clicking the tabs in the top right.

> Code

```shell
curl "https://siasky.net/skynet/skyfile" -F files[]=@./images/image1.png -F files[]=@./images/image2.png
```

```python
from siaskynet import Skynet

response = Skynet.upload_directory("./images")
print(responsek)
```

```javascript
import { uploadDirectory } from "skynet-js";

const response = await uploadDirectory(portalUrl, directory, filename);
console.log(response)
```

```go
package main

import (
	skynet "github.com/NebulousLabs/go-skynet"
	"fmt"
)

func main() {
	response, err := skynet.UploadDirectory("./images", skynet.DefaultUploadOptions)
	if err != nil {
		panic(err)
	}
	fmt.Printf("%+v", response)
}
```

> The above command returns JSON structured like this

It is possible to upload a directory as a single piece of content. Doing this
will allow to address your content under one skylink, and access the files by
their path. This is especially useful for webapps.

Directory uploads works using multipart form upload.
