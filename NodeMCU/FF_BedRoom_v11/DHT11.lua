local DHT11 = {}

    print ("domus-silicea - DHT11.lua - Script Starting") 

    DHT11.Humidity = 255
    DHT11.HumidityDec=255
    DHT11.Temperature = 255
    DHT11.TemperatureDec=255


    -- Measure temperature, humidity of DHT11
    function DHT11.update()
        print ("DHT - Execute DHT11.update()")
        status, tmpTemperature, tmpHumidity, tmpTemperatureDec, tmpHumidityDec = dht.read(config.GPIO_DHT11)
        if status == dht.OK then
            -- Integer firmware using this example
            print(string.format("DHT - Temperature:%d.%02d; Humidity:%d.%02d\r\n",
                  math.floor(tmpTemperature),
                  tmpTemperatureDec,
                  math.floor(tmpHumidity),
                  tmpHumidityDec
            ))
            DHT11.Humidity = tmpHumidity
            DHT11.HumidityDec = tmpHumidityDec
            DHT11.Temperature = tmpTemperature
            DHT11.TemperatureDec = tmpTemperatureDec
        elseif status == dht.ERROR_CHECKSUM then
            print( "DHT - Checksum error." )
            DHT11.Humidity = 255
            DHT11.HumidityDec = 255
            DHT11.Temperature = 255
            DHT11.TemperatureDec = 255
        elseif status == dht.ERROR_TIMEOUT then
            print( "DHT - timed out." )
            DHT11.Humidity = 255
            DHT11.HumidityDec = 255
            DHT11.Temperature = 255
            DHT11.TemperatureDec = 255
        end
    end

return DHT11

