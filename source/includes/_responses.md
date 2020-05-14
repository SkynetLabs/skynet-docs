# Standard Responses

## Success
The standard response indicating the request was successfully processed is HTTP
status code `204 No Content`. If the request was successfully processed and the
server responded with JSON the HTTP status code is `200 OK`. Specific endpoints
may specify other 2xx status codes on success.

## Error

```go
{
    "message": String

    // There may be additional fields depending on the specific error.
}
```

The standard error response indicating the request failed for any reason, is a
4xx or 5xx HTTP status code with an error JSON object describing the error.