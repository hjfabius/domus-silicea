local gasMeter = {}
    
    print ("domus-silicea - gasMeter.lua - Script Starting") 

    gasMeter.Peaks = 0
    local counterLow = 0
    local counterHigh = 0
    local previousStatus = 1
    
    function onGPIOGasPollingLong()
        if counterHigh >= counterLow then
            if previousStatus == 0 then
                gasMeter.Peaks = gasMeter.Peaks + 1
                previousStatus = 1
            end
        else
            previousStatus = 0
        end
        counterLow = 0
        counterHigh = 0
    end

    function onGPIOGasPollingShort()
        if (gpio.read(config.GPIO_GasMeter) == 1) then
            counterHigh = counterHigh + 1
        else
            counterLow = counterLow + 1
        end
    end
    

    function gasMeter.start()
        print ("domus-silicea - gasMeter.start()") 
        gpio.mode(config.GPIO_GasMeter, gpio.INPUT)
        tmr.stop(2)
        tmr.alarm(2, config.PollingShort_GasMeter, 1, onGPIOGasPollingShort)
        tmr.stop(5)
        tmr.alarm(5, config.PollingLong_GasMeter, 1, onGPIOGasPollingLong)
    end

  
return gasMeter
