-- Global Configuration File --
local config = {}
	
	print ("domus-silicea - config.lua - Script Starting") 
    -- Timers
    -- 0 - Init Boot
    -- 1 - Wifi Get IP, App Msg Send interval
    -- 2 - GasMeterPollingShort
    -- 3 - WaterMeterPollingShort
    -- 4 - WaterMeterPollingLong
    -- 5 - GasMeterPollingLong

    config.NodeName = 'Node_' .. node.chipid()
    config.SketchName = 'NodeMCU'
    config.SketchVersion = '10.0'
    if node.chipid() == 798202 then
        config.NodeName = 'GF_Bathroom'
	elseif node.chipid() == 14081910 then
        config.NodeName = 'FF_LivingRoom'
    end

    config.app_SendMsgInterval  = 60000 --ms
    --config.app_SendMsgInterval  = 5000 --ms
    config.GPIO_Led             = 3


	--print ("domus-silicea - config.lua - Config DHT11") 
	config.GPIO_DHT11           = -1 --2

    --print ("domus-silicea - config.lua - Config Gas Meter") 
    config.GPIO_GasMeter        = -1 --6
    config.PollingShort_GasMeter = 50 --ms 
    config.PollingLong_GasMeter  = 500 --ms 

    --print ("domus-silicea - config.lua - Config Water Meter") 
    config.GPIO_WaterMeter         = -1 --1 
    config.PollingShort_WaterMeter = 1 --ms 
    config.PollingLong_WaterMeter  = 5 --ms 

    --print ("domus-silicea - config.lua - Config Power Meter") 
    config.GPIO_PowerMeter      = -1
    config.Debounce_PowerMeter    = 100 --ms 

    --print ("domus-silicea - config.lua - Config PIR Sensor") 
    config.GPIO_PIR             = -1 --3

    --print ("domus-silicea - config.lua - Config Light Sensor") 
    config.GPIO_Light           = -1 --4
    config.GPIO_LightAnalog     = -1

    --print ("domus-silicea - config.lua - Config Gas Sensor") 
    config.GPIO_Gas             = -1 --5
    config.GPIO_GasAnalog       = -1

	--print ("domus-silicea - config.lua - Config MQTT") 
	config.MQTT_Host            = "192.168.0.10" 
	config.MQTT_Port            = 1883
  
	config.MQTT_ID              = config.NodeName
	config.MQTT_EndPoint        = "domus-silicea/"


    --print ("domus-silicea - config.lua - Config ledRGB") 
    config.GPIO_ledR            = 6
    config.GPIO_ledG            = 7
    config.GPIO_ledB            = 8

    config.GPIO_ArduinoOneWire  = -1 --4

return config 

