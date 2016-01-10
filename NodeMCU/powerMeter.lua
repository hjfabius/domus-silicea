local powerMeter = {}
	
	print ("domus-silicea - powerMeter.lua - Script Starting") 

    function powerMeter.start()
    	gpio.mode(config.GPIO_DHT11, gpio.INPUT)
    	gpio.mode(config.GPIO_DHT11, gpio.INPUT)
    
    	print(gpio.read(config.GPIO_DHT11))
    end

return powerMeter


