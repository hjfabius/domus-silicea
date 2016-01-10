print ("domus-silicea - test.lua")
tmr.delay(5000000)
print ("domus-silicea - test.lua - Loading Modules")


config         = require "config"   
configWifi 	   = require "configWifi"   
DHT11          = require "DHT11" 
--powerMeter  = require("powerMeter")
WIFI  		   = require "WIFI"
MQTT        = require("MQTT")
app            = require "app"   

print ("domus-silicea - test.lua - Script Starting")
WIFI.start() 
--DHT11.update()
print ("domus-silicea - test.lua - Script Ended")


