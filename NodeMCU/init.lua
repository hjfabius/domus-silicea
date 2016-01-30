print ("domus-silicea - init.lua")


function startup()
    if abort == true then
        print('startup aborted')
        return
    end
    print ("domus-silicea - init.lua - Loading Modules")
    
    config         = require "config"   
    configWifi     = require "configWifi"   
    if config.GPIO_DHT11 >=0 then 
        DHT11          = require "DHT11" 
    end
    if config.GPIO_GasMeter >=0 then 
        gasMeter       = require "gasMeter"
    end 
    if config.GPIO_WaterMeter >=0 then 
        waterMeter     = require "waterMeter"
    end
    if config.GPIO_PowerMeter >=0 then 
        powerMeter     = require "powerMeter"
    end
    WIFI           = require "WIFI"
    MQTT           = require "MQTT"
    app            = require "app"   
    
    print ("domus-silicea - init.lua - Script Starting")
    WIFI.start() 

end

abort = false
tmr.alarm(0,5000,0,startup)
print ("domus-silicea - init.lua - send 'abort=true' to stop boot")



