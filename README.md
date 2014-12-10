# Code Union API

An HTTP API serving JSON data for Code Union resources.

## Usage

The base URL is `https://api.codeunion.com/v1/`.

As of now no authentication is required.

## Endpoints

### Search resources

Find resources whose text contains a particular query

```
GET /v1/search?:query_params
```

### Parameters

Name | Type | Description | Required
-----|------|-------------|---------
query | string | Search query | true
category | string | See supported categories in `app/models/resource.rb` | false

### Response

```json
[
  {
    "name": "overheard-server",
    "description": "Example project for a web app that stores and shares hilarious, out of context quotess and quips.",
    "private": false,
    "url": "https://github.com/codeunion/overheard-server",
    "category": "examples",
    "tags": [
      "ruby",
      "sinatra",
      "datamapper",
      "sqlite"
    ],
    "access": [
      "public",
      "students",
      "staff"
    ],
    "license": true,
    "has_wiki": false,
    "notes": ""
  }
]
```
