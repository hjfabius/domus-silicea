local gasMeter = {} 
    
    print ("domus-silicea - gasMeter.lua - Script Starting") 

	gasMeter.Peaks = 0

    local function debounceGas(level)
        if level == 1 then return end
        gpio.mode(config.GPIO_GasMeter, gpio.INPUT)
        tmr.stop(2)
        tmr.alarm(2, config.Debounce_GasMeter, 0, onGPIOGasMeterUp)
    end

    function onGPIOGasMeterUp()
        if gpio.read(config.GPIO_GasMeter) == 1 then 
            onGPIOGasMeterRestart()
        else
            print('domus-silicea - gasMeter - Found value 0 on pin ' .. config.GPIO_GasMeter)
			gasMeter.Peaks = gasMeter.Peaks + 1
            gpio.mode(config.GPIO_Led, gpio.OUTPUT)
            gpio.write(config.GPIO_Led, gpio.LOW)
            tmr.stop(2)
            tmr.alarm(2, config.MinPeriod_GasMeter, 0, onGPIOGasMeterRestart)
        end
    end

    function onGPIOGasMeterRestart() 
        print ("domus-silicea - gasMeter.onGPIOGasMeterRestart()") 
        -- Gas counter stop on "6" (pin = 0) so I cannot reactivate interrupt otherwise I'll generate a loop.
        gpio.mode(config.GPIO_GasMeter, gpio.INPUT)
        if gpio.read(config.GPIO_GasMeter) == 1 then 
            gpio.mode(config.GPIO_Led, gpio.OUTPUT)
            gpio.write(config.GPIO_Led, gpio.HIGH)
            gpio.mode(config.GPIO_GasMeter, gpio.INT)
            gpio.trig(config.GPIO_GasMeter, 'down', debounceGas)
        else
            tmr.stop(2)
            tmr.alarm(2, config.MinPeriod_GasMeter, 0, onGPIOGasMeterRestart)
        end
    end


    function gasMeter.start()
        print ("domus-silicea - gasMeter.start()") 
        onGPIOGasMeterRestart()
    end

  
return gasMeter
