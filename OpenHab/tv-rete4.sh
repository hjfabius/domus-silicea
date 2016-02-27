#!/bin/bash
curl -su kodi:kodi -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Player.Open","params":{"item": { "file": "plugin://plugin.video.zattoobox/?ext=LiveTV&mode=watch&id=rete-4" }},"id":1}' http://192.168.0.14:8085/jsonrpc
 