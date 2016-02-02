local powerMeter = {}
	
	print ("domus-silicea - powerMeter.lua - Script Starting") 

    local lastBounce = 0
    local counter = 0

    local function debouncePower(level)
        local now = tmr.now()
        if level == 0 then return end
        if now - lastBounce < config.Debounce_PowerMeter then return end
        lastBounce = now
        return onGPIOPowerMeterUp()
    end

    function onGPIOPowerMeterUp()
        print('domus-silicea - waterMeter - Found value 1 on pin ' .. config.GPIO_PowerMeter)
        counter = counter + 1
        MQTT.send_Message("V_POWER", counter)
    end
    

    function powerMeter.start()
        print ("domus-silicea - powerMeter.start()") 
    	gpio.mode(config.GPIO_PowerMeter, gpio.INT)
        gpio.trig(config.GPIO_PowerMeter, 'up', debouncePower)
    end

   
return powerMeter
