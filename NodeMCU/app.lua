local app = {}

	print ("domus-silicea - app.lua - Script Starting") 

    function app.refreshAndSend()
        DHT11.update()
        MQTT.send_Message("V_TEMP", DHT11.Temperature .. "." .. DHT11.TemperatureDec)
        MQTT.send_Message("V_HUM",  DHT11.Humidity    .. "." .. DHT11.HumidityDec)
        MQTT.send_Message("V_GAS",  gasMeter.m3Gas    .. "." .. gasMeter.m3GasDec .. "" .. gasMeter.m3GasCent)
        --MQTT.send_Message("V_TEMP", DHT11.Temperature )
    end

	function app.start()  
		print ("domus-silicea - app.start()") 
		DHT11.update()
        MQTT.start()
        --powerMeter.start()
        gasMeter.start()
        tmr.stop(1)
        tmr.alarm(1, config.app_SendMsgInterval, 1, app.refreshAndSend)

	end

	

return app 

