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
		m:subscribe(config.MQTT_EndPoint .. config.MQTT_ID .. "/" .. config.MQTT_ServerEndPoint .. "/#",0,function(conn)
			print("Successfully subscribed to data endpoint")
            MQTT.send_Message("V_SKETCH",      config.SketchName .. " - Version: " .. config.SketchVersion .. " - NodeID: " .. node.chipid() .. " - IP: " .. configWifi.IP)
		end)
	end

	local function mqtt_start()  
		m = mqtt.Client(config.MQTT_ID, 120)
		-- register message callback beforehand
		m:on("message", function(conn, topic, data) 
		  if data ~= nil then
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

