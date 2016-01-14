-- Global Configuration File --
local config = {}
	
	print ("domus-silicea - config.lua - Script Starting") 
    -- Timers
    -- 0 - Init Boot
    -- 1 - Wifi Get IP, App Msg Send interval
    -- 6 - MQTT Ping

    config.app_SendMsgInterval  = 10000 --ms


	--print ("domus-silicea - config.lua - Config DHT11") 
	config.GPIO_DHT11           = 4

	--print ("domus-silicea - config.lua - Config Power Meter") 
	config.GPIO_PowerMeter      = 3
    config.Debounce_PowerMeter  = 200000 --us 

    --print ("domus-silicea - config.lua - Config Gas Meter") 
    config.GPIO_GasMeter      = 2
    config.Debounce_GasMeter  = 200000 --us 


	--print ("domus-silicea - config.lua - Config MQTT") 
	config.MQTT_Host            = "192.168.0.10" 
	config.MQTT_Port            = 1883
	config.MQTT_ID              = node.chipid()
	config.MQTT_EndPoint        = "domus-silicea/"
    config.MQTT_PingInterval    = 10000 --ms



return config 

