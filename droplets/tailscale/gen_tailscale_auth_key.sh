#!/bin/bash

curl -s --request POST \
  --url "https://api.tailscale.com/api/v2/tailnet/${TAILSCALE_TAILNET}/keys?all=true" \
  --header "Authorization: Bearer ${TAILSCALE_API_TOKEN}" \
  --header 'Content-Type: application/json' \
  --data '{
  "description": "dev access",
  "capabilities": {
    "devices": {
      "create": {
        "reusable": false,
        "ephemeral": false,
        "preauthorized": true
      }
    }
  },
  "expirySeconds": 360,
  "scopes": [
    "all:read"
  ]
}'
