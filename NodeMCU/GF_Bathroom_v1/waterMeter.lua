local waterMeter = {}
    
    print ("domus-silicea - waterMeter.lua - Script Starting") 

    waterMeter.m3Water = 0
    waterMeter.m3WaterDec = 0
    waterMeter.m3WaterCent = 0

    local lastBounce = 0

    local function debounceWater(level)
        local now = tmr.now()
        if level == 0 then return end
        if now - lastBounce < config.Debounce_WaterMeter then return end
        lastBounce = now
        return onGPIOWaterMeterUp()
    end

    function onGPIOWaterMeterUp()
        print('Found value 1 on pin ' .. config.GPIO_WaterMeter)
        waterMeter.m3WaterCent = waterMeter.m3WaterCent + 1
        if waterMeter.m3WaterCent == 10 then
            waterMeter.m3WaterCent = 0
            waterMeter.m3WaterDec = waterMeter.m3WaterDec + 1
        end
        if waterMeter.m3WaterDec == 10 then
            waterMeter.m3WaterDec = 0
            waterMeter.m3Water = waterMeter.m3Water + 1
        end
    end
    

    function waterMeter.start()
        print ("domus-silicea - waterMeter.start()") 
        gpio.mode(config.GPIO_WaterMeter, gpio.INT)
        gpio.trig(config.GPIO_WaterMeter, 'up', debounceWater)
    end

  
return waterMeter


