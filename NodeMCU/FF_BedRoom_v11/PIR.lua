local PIR = {}

    print ("domus-silicea - PIR.lua - Script Starting") 

    PIR.Status = 255
    local counterLow = 0
    local counterHigh = 0


    function PIR.update()
        print ("PIR - Execute PIR.update()")
        if counterHigh >= counterLow then
            PIR.Status = 1
        else
            PIR.Status = 0
        end
        counterLow = 0
        counterHigh = 0
    end


    function onGPIOPIRPolling()
        if (gpio.read(config.GPIO_PIR) == 1) then
            counterHigh = counterHigh + 1
        else
            counterLow = counterLow + 1
        end
    end

    function PIR.start()  
        gpio.mode(config.GPIO_PIR, gpio.INPUT)
        tmr.stop(6)
        tmr.alarm(6, config.Polling_PIR, 1, onGPIOPIRPolling)
        
    end

return PIR

