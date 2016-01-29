local gasMeter = {}
    
    print ("domus-silicea - gasMeter.lua - Script Starting") 

    gasMeter.m3Gas = 0
    gasMeter.m3GasDec = 0
    gasMeter.m3GasCent = 0

    local lastBounce = 0

    local function debounceGas(level)
        local now = tmr.now()
        if level == 0 then return end
        if now - lastBounce < config.Debounce_GasMeter then return end
        lastBounce = now
        return onGPIOGasMeterUp()
    end

    function onGPIOGasMeterUp()
        print('Found value 1 on pin ' .. config.GPIO_GasMeter)
        gasMeter.m3GasCent = gasMeter.m3GasCent + 1
        if gasMeter.m3GasCent == 10 then
            gasMeter.m3GasCent = 0
            gasMeter.m3GasDec = gasMeter.m3GasDec + 1
        end
        if gasMeter.m3GasDec == 10 then
            gasMeter.m3GasDec = 0
            gasMeter.m3Gas = gasMeter.m3Gas + 1
        end
    end
    

    function gasMeter.start()
        print ("domus-silicea - gasMeter.start()") 
        gpio.mode(config.GPIO_GasMeter, gpio.INT)
        gpio.trig(config.GPIO_GasMeter, 'up', debounceGas)
    end

  
return gasMeter


