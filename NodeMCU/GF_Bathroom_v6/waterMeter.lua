local waterMeter = {}
    
    print ("domus-silicea - waterMeter.lua - Script Starting") 

    waterMeter.Peaks = 0
    local counterLow = 0
    local counterHigh = 0
    local previousStatus = 0
    
    function onGPIOWaterPollingLong()
        if counterHigh >= counterLow then
            if previousStatus == 0 then
                waterMeter.Peaks = waterMeter.Peaks + 1
                previousStatus = 1
            end
        else
            previousStatus = 0
        end
        counterLow = 0
        counterHigh = 0
    end

    function onGPIOWaterPollingShort()
        if (gpio.read(config.GPIO_WaterMeter) == 1 then
            counterHigh = counterHigh + 1
        else
            counterLow = counterLow + 1
        end
    end
    

    function waterMeter.start()
        print ("domus-silicea - waterMeter.start()") 
        gpio.mode(config.GPIO_WaterMeter, gpio.INPUT)
        tmr.stop(3)
        tmr.alarm(3, config.PollingShort_WaterMeter, 1, onGPIOWaterPollingShort)
        tmr.stop(4)
        tmr.alarm(4, config.PollingLong_WaterMeter, 1, onGPIOWaterPollingLong)
    end

  
return waterMeter
