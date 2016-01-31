local gasMeter = {}
    
    print ("domus-silicea - gasMeter.lua - Script Starting") 

    local lastBounce = 0
    local counter = 0

    local function debounceGas(level)
        if level == 0 then return end
        tmr.stop(2)
        tmr.alarm(2, config.Debounce_GasMeter, 0, onGPIOGasMeterUp)
    end

    function onGPIOGasMeterUp()
        if gpio.read(config.GPIO_GasMeter) == 0 then return end
        print('domus-silicea - gasMeter - Found value 1 on pin ' .. config.GPIO_GasMeter)
        counter = counter + 1
		MQTT.send_Message("V_GAS", counter)
    end


    function gasMeter.start()
        print ("domus-silicea - gasMeter.start()") 
        gpio.mode(config.GPIO_GasMeter, gpio.INT)
        gpio.trig(config.GPIO_GasMeter, 'up', debounceGas)
    end

  
return gasMeter
