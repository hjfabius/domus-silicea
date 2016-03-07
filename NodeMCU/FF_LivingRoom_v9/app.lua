local app = {}

	print ("domus-silicea - app.lua - Script Starting") 

    function app.refreshAndSend()
        MQTT.send_Message("V_SKETCH",      config.SketchName .. " - Version: " .. config.SketchVersion .. " - NodeID: " .. node.chipid() .. " - IP: " .. configWifi.IP)
    
        if config.GPIO_DHT11 >= 0 then
            DHT11.update()
            if DHT11.Temperature < 100 then 
                MQTT.send_Message("V_TEMP",     DHT11.Temperature   .. "." .. DHT11.TemperatureDec)
            end
            if DHT11.Humidity < 100 then 
                MQTT.send_Message("V_HUM",      DHT11.Humidity      .. "." .. DHT11.HumidityDec)
            end
        end

        if config.GPIO_WaterMeter >= 0 then
            if waterMeter.Peaks >= 0 and waterMeter.Peaks < 10000 then 
                MQTT.send_Message("V_WATER",    waterMeter.Peaks )
                waterMeter.Peaks = 0
            end
        end

        if config.GPIO_GasMeter >= 0 then
            if gasMeter.Peaks >= 0 and gasMeter.Peaks < 10000 then 
                MQTT.send_Message("V_GAS", gasMeter.Peaks)
                gasMeter.Peaks = 0
            end
        end
		
		
    end

	function app.start()  
		print ("domus-silicea - app.start()") 
        eeprom.start()
        if config.GPIO_DHT11 >= 0 then 
		    DHT11.update()
        end
        webServer.start()
        MQTT.start()
        if config.GPIO_GasMeter >= 0 then 
            gasMeter.start()
        end 
        if config.GPIO_WaterMeter >= 0 then 
            waterMeter.start()
        end
        if config.GPIO_PowerMeter >= 0 then 
            powerMeter.start()
        end

        if config.GPIO_ledR >= 0 and config.GPIO_ledG >= 0 and config.GPIO_ledB >= 0 then
            ledRGB.start()
        end

        tmr.stop(1)
        tmr.alarm(1, config.app_SendMsgInterval, 1, app.refreshAndSend)

	end

	

return app 

