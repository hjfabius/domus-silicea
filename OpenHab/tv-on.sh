#!/bin/bash
curl -su kodi:kodi -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Addons.ExecuteAddon","params":{"addonid":"tv-on"},"id":1}' http://192.168.0.14:8085/jsonrpc
