#!/bin/bash
curl -su kodi:kodi -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Input.Home","params":{},"id":1}' http://192.168.0.14:8085/jsonrpc

curl -su kodi:kodi -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Addons.ExecuteAddon","params":{"addonid":"plugin.video.teleboyNG"},"id":1}' http://192.168.0.14:8085/jsonrpc

curl -su kodi:kodi -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Input.Select","params":{},"id":1}' http://192.168.0.14:8085/jsonrpc

