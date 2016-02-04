local gasMeter = {}
    
    print ("domus-silicea - gasMeter.lua - Script Starting") 

    local lastBounce = 0
    local counter = 0 

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
            counter = counter + 1
            MQTT.send_Message("V_GAS", counter)
            gpio.mode(config.GPIO_Led, gpio.OUTPUT)
            gpio.write(config.GPIO_Led, gpio.LOW)
            tmr.stop(2)
            tmr.alarm(2, config.MinPeriod_GasMeter, 0, onGPIOGasMeterRestart)
        end
    end

    function onGPIOGasMeterRestart()
        print ("domus-silicea - gasMeter.onGPIOGasMeterRestart()") 
        gpio.mode(config.GPIO_Led, gpio.OUTPUT)
        gpio.write(config.GPIO_Led, gpio.HIGH)
        gpio.mode(config.GPIO_GasMeter, gpio.INT)
        gpio.trig(config.GPIO_GasMeter, 'down', debounceGas)
    end


    function gasMeter.start()
        print ("domus-silicea - gasMeter.start()") 
        onGPIOGasMeterRestart()
    end

  
return gasMeter
