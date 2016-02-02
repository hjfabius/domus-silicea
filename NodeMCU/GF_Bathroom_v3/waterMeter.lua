local waterMeter = {}
    
    print ("domus-silicea - waterMeter.lua - Script Starting") 

    local lastBounce = 0
    local counter = 0

    local function debounceWater(level)
        local now = tmr.now()
        if level == 0 then return end
        if now - lastBounce < config.Debounce_WaterMeter then return end
        lastBounce = now
        return onGPIOWaterMeterUp()
    end

    function onGPIOWaterMeterUp()
        print('domus-silicea - waterMeter - Found value 1 on pin ' .. config.GPIO_WaterMeter)
        counter = counter + 1
        MQTT.send_Message("V_WATER", counter)
    end
    

    function waterMeter.start()
        print ("domus-silicea - waterMeter.start()") 
        gpio.mode(config.GPIO_WaterMeter, gpio.INT)
        gpio.trig(config.GPIO_WaterMeter, 'up', debounceWater)
    end

  
return waterMeter
