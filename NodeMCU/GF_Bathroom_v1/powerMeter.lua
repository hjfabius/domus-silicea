local powerMeter = {}
	
	print ("domus-silicea - powerMeter.lua - Script Starting") 

    powerMeter.Wh = 0
    powerMeter.WhDec = 0
    powerMeter.WhCent = 0
    powerMeter.WhMilli = 0

    local lastBounce = 0

    local function debouncePower(level)
        local now = tmr.now()
        if level == 0 then return end
        if now - lastBounce < config.Debounce_PowerMeter then return end
        lastBounce = now
        return onGPIOPowerMeterUp()
    end

    function onGPIOPowerMeterUp()
        print('Found value 1 on pin ' .. config.GPIO_PowerMeter)
        powerMeter.WhMilli = powerMeter.WhMilli + 1
        if powerMeter.WhMilli == 10 then
            powerMeter.WhMilli = 0
            powerMeter.WhCent = powerMeter.WhCent + 1
        end
        if powerMeter.WhCent == 10 then
            powerMeter.WhCent = 0
            powerMeter.WhDec = powerMeter.WhDec + 1
        end
        if powerMeter.WhDec == 10 then
            powerMeter.WhDec = 0
            powerMeter.Wh = powerMeter.Wh + 1
        end
    end
    

    function powerMeter.start()
        print ("domus-silicea - powerMeter.start()") 
    	gpio.mode(config.GPIO_PowerMeter, gpio.INT)
        gpio.trig(config.GPIO_PowerMeter, 'up', debouncePower)
    end

   

return powerMeter


