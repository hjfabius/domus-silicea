local gasMeter = {}
    
    print ("domus-silicea - gasMeter.lua - Script Starting") 

    gasMeter.m3Gas = 0
    gasMeter.m3GasDec = 0
    gasMeter.m3GasCent = 0

    local function debounce2(func)
        local last = 0
        local delay = config.Debounce_GasMeter
        return function (...)
            local now = tmr.now()
            if now - last < delay then return end
    
            last = now
            return func(...)
        end
    end

    function onGPIOGasMeterUp()
        print('Rilevato valore a 1 sul pin 3')
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
        gpio.trig(config.GPIO_GasMeter, 'up', debounce2(onGPIOGasMeterUp))
    end

  
return gasMeter


