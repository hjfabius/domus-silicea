#!/bin/bash
#curl -su kodi:kodi -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Player.Open","params":{"item": { "file": "plugin://plugin.video.zattoobox/?ext=LiveTV&mode=watch&id=rsi-la2" }},"id":1}' http://192.168.0.14:8085/jsonrpc
curl -su kodi:kodi -H "Content-type: application/json" -X POST -d '{"jsonrpc":"2.0","method":"Player.Open","params":{"item": { "file": "plugin://plugin.video.teleboyNG/?station=340&mode=play_live" }},"id":1}' http://192.168.0.14:8085/jsonrpc
 