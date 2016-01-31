local WIFI = {}

	print ("domus-silicea - WIFI.lua - Script Starting") 


	local function wifi_wait_ip()  
	  if wifi.sta.getip()== nil then
		print("IP unavailable, Waiting...")
	  else
		tmr.stop(1)
		print("\n====================================")
		print("ESP8266 mode is: " .. wifi.getmode())
		print("MAC address is:  " .. wifi.ap.getmac())
		print("IP is            " .. wifi.sta.getip())
		print("====================================")
        configWifi.IP = wifi.sta.getip()
        configWifi.MAC = wifi.sta.getmac()
		app.start()
	  end
	end

    local function wifi_start(list_aps)  
        if list_aps then
            print("AP list get")
            for key,value in pairs(list_aps) do
                print(key .. " : " .. value) 
                if configWifi.SSID  and configWifi.SSID[key] then
                    wifi.setmode(wifi.STATION);
                    wifi.sta.config(key,configWifi.SSID[key])
                    wifi.sta.connect()
                    print("Connecting to " .. key .. " ...")
                    tmr.alarm(1, 2500, 1, wifi_wait_ip)
                end
            end
        else
            print("Error getting AP list")
        end
    end

    function WIFI.start()  
      --print("Configuring Wifi ...")
      --wifi.setmode(wifi.STATION)
      --tmr.delay(20000)
      --wifi.sta.getap(wifi_start)

        wifi.setmode(wifi.STATION)
        wifi.sta.config(configWifi.SSID, configWifi.PWD)
        wifi.sta.connect()  
        print("Connecting to " .. configWifi.SSID .. " ...")
        tmr.alarm(1, 2500, 1, wifi_wait_ip)
    end


return WIFI

