local app = {}

	print ("domus-silicea - app.lua - Script Starting") 

    function app.refreshAndSend()
    
        if config.GPIO_DHT11 >= 0 then
            DHT11.update()
            if DHT11.Temperature < 100 then 
                MQTT.send_Message("V_TEMP",     DHT11.Temperature   .. "." .. DHT11.TemperatureDec)
            end
            if DHT11.Humidity < 100 then 
                MQTT.send_Message("V_HUM",      DHT11.Humidity      .. "." .. DHT11.HumidityDec)
            end
        end
        
        if config.GPIO_GasMeter >= 0 then 
            MQTT.send_Message("V_GAS",      gasMeter.m3Gas      .. "." .. gasMeter.m3GasDec     .. "" .. gasMeter.m3GasCent)
        end
        
        if config.GPIO_WaterMeter >= 0 then
            MQTT.send_Message("V_WATER",    waterMeter.m3Water  .. "." .. waterMeter.m3WaterDec .. "" .. waterMeter.m3WaterCent)
        end 

        if config.GPIO_PowerMeter >= 0 then 
            MQTT.send_Message("V_POWER",    powerMeter.Wh       .. "." .. powerMeter.WhDec      .. "" .. powerMeter.WhCent       .. "" .. powerMeter.WhMilli)
        end 
        --MQTT.send_Message("V_TEMP", DHT11.Temperature )
    end

	function app.start()  
		print ("domus-silicea - app.start()") 
        if config.GPIO_DHT11 >= 0 then 
		    DHT11.update()
        end
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
        tmr.stop(1)
        tmr.alarm(1, config.app_SendMsgInterval, 1, app.refreshAndSend)

	end

	

return app 

