-- Global Configuration File --
local config = {}
	
	print ("domus-silicea - config.lua - Script Starting") 
    -- Timers
    -- 0 - Init Boot
    -- 1 - Wifi Get IP, App Msg Send interval
    -- 2 - GasMeterDebounce
    -- 3 - WaterMeterPollingShort
    -- 4 - WaterMeterPollingLong
    -- 6 - MQTT Ping

    config.NodeName = 'Node_' .. node.chipid()
    config.SketchName = 'NodeMCU'
    config.SketchVersion = '6.0'
    if node.chipid() == 798202 then
        config.NodeName = 'GF_Bathroom'
    end

    config.app_SendMsgInterval  = 60000 --ms
    config.GPIO_Led             = 0


	--print ("domus-silicea - config.lua - Config DHT11") 
	config.GPIO_DHT11           = 2

    --print ("domus-silicea - config.lua - Config Gas Meter") 
    config.GPIO_GasMeter        = 6
    config.Debounce_GasMeter    = 100 --ms 
    config.MinPeriod_GasMeter   = 2000 --ms  

    --print ("domus-silicea - config.lua - Config Water Meter") 
    config.GPIO_WaterMeter         = 1
    config.PollingShort_WaterMeter = 1 --ms 
    config.PollingLong_WaterMeter  = 5 --ms 

    --print ("domus-silicea - config.lua - Config Power Meter") 
    config.GPIO_PowerMeter      = -1
    config.Debounce_PowerMeter  = 200 --ms 

    --print ("domus-silicea - config.lua - Config PIR Sensor") 
    config.GPIO_PIR             = 3

    --print ("domus-silicea - config.lua - Config Light Sensor") 
    config.GPIO_Light           = 4
    config.GPIO_LightAnalog    = -1

    --print ("domus-silicea - config.lua - Config Gas Sensor") 
    config.GPIO_Gas             = 5
    config.GPIO_GasAnalog       = -1

	--print ("domus-silicea - config.lua - Config MQTT") 
	config.MQTT_Host            = "192.168.0.11" 
	config.MQTT_Port            = 1883
  
	config.MQTT_ID              = config.NodeName
	config.MQTT_EndPoint        = "domus-silicea/"
    config.MQTT_ServerEndPoint  = "OPENHAB"
    config.MQTT_PingInterval    = 60000 --ms



return config 

