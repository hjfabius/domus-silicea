local powerMeter = {}
	
	print ("domus-silicea - powerMeter.lua - Script Starting") 

    local function debounce(func)
        local last = 0
        local delay = config.Debounce_PowerMeter
        return function (...)
            local now = tmr.now()
            if now - last < delay then return end
    
            last = now
            return func(...)
        end
    end

    function onGPIOPowerMeterUp()
     print('Rilevato valore a 1 sul pin 3')
    end
    

    function powerMeter.start()
        print ("domus-silicea - powerMeter.start()") 
    	gpio.mode(config.GPIO_PowerMeter, gpio.INT)
        gpio.trig(config.GPIO_PowerMeter, 'up', debounce(onGPIOPowerMeterUp))
    	--gpio.mode(config.GPIO_PowerMeter, gpio.INPUT)
        --print(gpio.read(config.GPIO_PowerMeter))
    end

   

return powerMeter


