-- Global Configuration File --
local config = {}
	
	print ("domus-silicea - config.lua - Script Starting") 
    -- Timers
    -- 0 - Init Boot
    -- 1 - Wifi Get IP, App Msg Send interval
    -- 6 - MQTT Ping

    config.NodeName = 'Node_' .. node.chipid()
    if node.chipid() == 798202 then
        config.NodeName = 'GF_Bathroom'
    end

    config.app_SendMsgInterval  = 10000 --ms


	--print ("domus-silicea - config.lua - Config DHT11") 
	config.GPIO_DHT11           = 0

    --print ("domus-silicea - config.lua - Config Gas Meter") 
    config.GPIO_GasMeter        = 6
    config.Debounce_GasMeter    = 400000 --us 

    --print ("domus-silicea - config.lua - Config Water Meter") 
    config.GPIO_WaterMeter      = 7
    config.Debounce_WaterMeter  = 200000 --us 

    --print ("domus-silicea - config.lua - Config Power Meter") 
    config.GPIO_PowerMeter      = 8
    config.Debounce_PowerMeter  = 400000 --us 


	--print ("domus-silicea - config.lua - Config MQTT") 
	config.MQTT_Host            = "192.168.0.10" 
	config.MQTT_Port            = 1883
  
	config.MQTT_ID              = config.NodeName
	config.MQTT_EndPoint        = "domus-silicea/"
    config.MQTT_PingInterval    = 10000 --ms



return config 

