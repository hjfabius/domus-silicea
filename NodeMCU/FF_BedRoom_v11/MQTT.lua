local MQTT = {}

	print ("domus-silicea - MQTT.lua - Script Starting") 

	m = nil

	-- Sends a simple ping to the broker
	--local function send_ping()  
    --    --print("MQTT Ping")
	--	--MQTT.send_Message("PING",      "MQTT_ID = " .. config.MQTT_ID .. "\nIP     = " .. configWifi.IP .. "\nMAC    = " .. configWifi.MAC)
    --    MQTT.send_Message("V_SKETCH",      config.SketchName .. " - Version: " .. config.SketchVersion .. " - NodeID: " .. node.chipid() .. " - IP: " .. configWifi.IP)
	--end


	-- Sends my id to the broker for registration
	local function register_myself()  
        local strTopic = config.MQTT_EndPoint .. config.MQTT_ID .. "/#"
		m:subscribe(strTopic, 0,function(conn)
			print("Successfully subscribed to: " .. strTopic)
		end)
        --print("MQTT - register_myself")
        MQTT.send_Message("V_SKETCH",      config.SketchName .. " - Version: " .. config.SketchVersion .. " - NodeID: " .. node.chipid() .. " - IP: " .. configWifi.IP)
	end

	local function mqtt_start()  
		m = mqtt.Client(config.MQTT_ID, 120)
		-- register message callback beforehand
		m:on("message", function(conn, topic, data) 
            print("MQTT message received: " .. topic .. ": " .. data)
            if config.GPIO_ledR >= 0 and config.GPIO_ledG >= 0 and config.GPIO_ledB >= 0 then
                if topic == "domus-silicea/FF_LivingRoom/V_LIGHT_RED" then
                    ledRGB.setRGB(data, nil, nil)
                elseif topic == "domus-silicea/FF_LivingRoom/V_LIGHT_GREEN" then
                    ledRGB.setRGB(nil, data, nil)
                elseif topic == "domus-silicea/FF_LivingRoom/V_LIGHT_BLUE" then
                    ledRGB.setRGB(nil, nil, data)
                elseif topic == "domus-silicea/FF_LivingRoom/V_LIGHT_RGB" then
                    rgb = {}
                    for value in data:gmatch("%w+") do table.insert(rgb, value) end
                    ledRGB.setRGB(rgb[1], rgb[2], rgb[3])
                end
            elseif data ~= nil then
                print(topic .. ": " .. data)
                -- do something, we have received a message
            end
		end)
		-- Connect to broker
		m:connect(config.MQTT_Host, config.MQTT_Port, 0, 1, function(con) 
			register_myself()
		end) 

	end

    function MQTT.send_Message(msgType, value)  
        print("MQTT Send " .. msgType .. " = " .. value)
        m:publish(config.MQTT_EndPoint .. config.MQTT_ID .. "/" .. msgType   ,value,0,0)
    end

	function MQTT.start()  
	  mqtt_start()
	end

return MQTT

