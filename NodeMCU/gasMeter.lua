local gasMeter = {}
    
    print ("domus-silicea - gasMeter.lua - Script Starting") 

    gasMeter.m3GasBase = 0
    gasMeter.m3GasBaseDec = 0
    gasMeter.m3GasBaseCent = 0

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


    function gasMeter.gasMeterUpdate(baseValue)
        print("domus-silicea - gasMeter.gasMeterUpdate(" .. baseValue .. ")")
        gasMeter.m3GasBase = tonumber(baseValue) / 100
        gasMeter.m3GasBaseDec = (tonumber(baseValue) / 10) % 10
        gasMeter.m3GasBaseCent = tonumber(baseValue) % 10

        gasValue = gasMeter.m3GasCent + gasMeter.m3GasDec*10 + gasMeter.m3Gas*100

        if tonumber(baseValue) > gasValue then
            gasValue = tonumber(baseValue) + gasValue
            gasMeter.m3Gas = gasValue / 100
            gasMeter.m3GasDec = (gasValue / 10) % 10
            gasMeter.m3GasCent = gasValue % 10
        end
        
    end

    function gasMeter.start()
        print ("domus-silicea - gasMeter.start()") 
        gpio.mode(config.GPIO_GasMeter, gpio.INT)
        gpio.trig(config.GPIO_GasMeter, 'up', debounceGas)
    end

  
return gasMeter


