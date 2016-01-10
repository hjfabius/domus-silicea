-- Global Configuration File --
local config = {}
	
	print ("domus-silicea - config.lua - Script Starting") 

	--print ("domus-silicea - config.lua - Config DHT11") 
	config.GPIO_DHT11 = 4

	--print ("domus-silicea - config.lua - Config Power Meter") 
	config.GPIO_PowerMeter = 3

	--print ("domus-silicea - config.lua - Config MQTT") 
	config.MQTT_Host     = "192.168.0.10" 
	config.MQTT_Port     = 1883
	config.MQTT_ID       = node.chipid()
	config.MQTT_EndPoint = "domus-silicea/"

return config 

