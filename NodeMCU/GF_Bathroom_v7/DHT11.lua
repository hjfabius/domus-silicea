local DHT11 = {}

    print ("domus-silicea - DHT11.lua - Script Starting") 

    DHT11.Humidity = 255
    DHT11.HumidityDec=255
    DHT11.Temperature = 255
    DHT11.TemperatureDec=255


    -- Measure temperature, humidity of DHT11
    function DHT11.update()
        print ("Execute updateDHT11()")
        tmpHumidity = 0
        tmpHumidityDec=0
        tmpTemperature = 0
        tmpTemperatureDec=0
        Checksum = 0
        ChecksumTest=0

        --Data stream acquisition timing is critical. There's
        --barely enough speed to work with to make this happen.
        --Pre-allocate vars used in loop.
        bitStream = {}
        for j = 1, 40, 1 do
             bitStream[j]=0
        end
        bitlength=0

        gpio.mode(config.GPIO_DHT11, gpio.OUTPUT)
        gpio.write(config.GPIO_DHT11, gpio.HIGH)
        tmr.delay(2000)
        gpio.mode(config.GPIO_DHT11, gpio.OUTPUT)
        gpio.write(config.GPIO_DHT11, gpio.LOW)
        tmr.delay(20000)
        --Use Markus Gritsch trick to speed up read/write on GPIO
        gpio_read=gpio.read
        gpio_write=gpio.write

        gpio.mode(config.GPIO_DHT11, gpio.INPUT)
        --bus will always let up eventually, don't bother with timeout
        while (gpio_read(config.GPIO_DHT11)==0 ) do end

        c=0
        while (gpio_read(config.GPIO_DHT11)==1 and c<100) do c=c+1 end

        --bus will always let up eventually, don't bother with timeout
        while (gpio_read(config.GPIO_DHT11)==0 ) do end

        c=0
        while (gpio_read(config.GPIO_DHT11)==1 and c<100) do c=c+1 end

        --acquisition loop
        for j = 1, 40, 1 do
             while (gpio_read(config.GPIO_DHT11)==1 and bitlength<10 ) do
                  bitlength=bitlength+1
             end
             bitStream[j]=bitlength
             bitlength=0
             --bus will always let up eventually, don't bother with timeout
             while (gpio_read(config.GPIO_DHT11)==0) do end
        end

        --DHT data acquired, process.
        for i = 1, 8, 1 do
             if (bitStream[i+0] > 2) then
                  tmpHumidity = tmpHumidity+2^(8-i)
             end
        end
        for i = 1, 8, 1 do
             if (bitStream[i+8] > 2) then
                  tmpHumidityDec = tmpHumidityDec+2^(8-i)
             end
        end
        for i = 1, 8, 1 do
             if (bitStream[i+16] > 2) then
                  tmpTemperature = tmpTemperature+2^(8-i)
             end
        end
        for i = 1, 8, 1 do
             if (bitStream[i+24] > 2) then
                  tmpTemperatureDec = tmpTemperatureDec+2^(8-i)
             end
        end
        for i = 1, 8, 1 do
             if (bitStream[i+32] > 2) then
                  Checksum = Checksum+2^(8-i)
             end
        end
        
        ChecksumTest=(tmpHumidity + tmpHumidityDec + tmpTemperature + tmpTemperatureDec) % 0xFF
        --print ("Temperature:       "  .. tmpTemperature .. "." .. tmpTemperatureDec)
        --print ("Humidity:          "  .. tmpHumidity    .. "." .. tmpHumidityDec)

        if ChecksumTest == Checksum then
            DHT11.Humidity = tmpHumidity
            DHT11.HumidityDec = tmpHumidityDec
            DHT11.Temperature = tmpTemperature
            DHT11.TemperatureDec = tmpTemperatureDec
        else
            DHT11.Humidity = 255
            DHT11.HumidityDec = 255
            DHT11.Temperature = 255
            DHT11.TemperatureDec = 255
        end
    
        
        return ChecksumTest == Checksum
    end

return DHT11

