print ("domus-silicea - test.lua - Loading Modules")


config         = require "config"   
configWifi 	   = require "configWifi"   
DHT11          = require "DHT11" 
gasMeter       = require "gasMeter"
waterMeter     = require "waterMeter"
powerMeter     = require "powerMeter"
WIFI  		   = require "WIFI"
MQTT           = require "MQTT"
app            = require "app"   

print ("domus-silicea - test.lua - Script Starting")
WIFI.start() 
--DHT11.update()
print ("domus-silicea - test.lua - Script Ended")


