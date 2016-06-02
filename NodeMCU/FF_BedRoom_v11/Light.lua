local Light = {}

    print ("domus-silicea - Light.lua - Script Starting") 

    Light.Status = 255
    local counterLow = 0
    local counterHigh = 0


    function Light.update()
        print ("Light - Execute Light.update()")
        if counterHigh >= counterLow then
            Light.Status = 1
        else
            Light.Status = 0
        end
        counterLow = 0
        counterHigh = 0
    end

    
    function onGPIOLightPolling()
        if (gpio.read(config.GPIO_Light) == 1) then
            counterHigh = counterHigh + 1
        else
            counterLow = counterLow + 1
        end
    end

    function Light.start()  
        gpio.mode(config.GPIO_Light, gpio.INPUT)
        tmr.stop(0)
        tmr.alarm(0, config.Polling_Light, 1, onGPIOLightPolling)    
    end

return Light

