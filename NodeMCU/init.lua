print ("domus-silicea - init.lua")


function startup()
    if abort == true then
        print('startup aborted')
        return
    end
    print ("domus-silicea - init.lua - Loading Modules")
    
    config         = require "config"   
    configWifi     = require "configWifi"   
    DHT11          = require "DHT11" 
    --powerMeter     = require "powerMeter"
    gasMeter       = require "gasMeter"
    WIFI           = require "WIFI"
    MQTT           = require "MQTT"
    app            = require "app"   
    
    print ("domus-silicea - init.lua - Script Starting")
    WIFI.start() 

end

abort = false
tmr.alarm(0,5000,0,startup)
print ("domus-silicea - init.lua - send 'abort=true' to stop boot")



