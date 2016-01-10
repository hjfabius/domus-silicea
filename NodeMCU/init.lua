print ("domus-silicea - init.lua")
tmr.delay(5000000)
print ("domus-silicea - init.lua - Loading Modules")


config         = require "config"   
configWifi     = require "configWifi"   
DHT11          = require "DHT11" 
--powerMeter  = require("powerMeter")
WIFI           = require "WIFI"
MQTT           = require("MQTT")
app            = require "app"   

print ("domus-silicea - init.lua - Script Starting")
WIFI.start() 
--DHT11.update()
print ("domus-silicea - init.lua - Script Ended")

