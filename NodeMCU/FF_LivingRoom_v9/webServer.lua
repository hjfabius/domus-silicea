local webServer = {}

    print ("domus-silicea - webServer.lua - Script Starting") 

    local srv = nil;
    
    function webServerReceive (client,request)
        print ("domus-silicea - webServer.webServerReceive()") 
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=([%w%,%.]+)&*") do
                _GET[k] = v
            end
        end
        buf = buf.."<h1>" .. config.SketchName .. " - Version: " .. config.SketchVersion .. " - NodeID: " .. node.chipid() .. " - NodeName: " .. config.NodeName .. " - IP: " .. configWifi.IP .. "</h1>";
        buf = buf.. "<form>";
        buf = buf.. "<p>MQTT Host: <input type=\"text\" name=\"MQTTHost\" value=\"" .. config.MQTT_Host .. "\"> </p>";
        buf = buf.. "<input type=\"submit\" value=\"Submit\">";
        buf = buf.. "</form>";
        
        if (_GET.MQTTHost) then
            if _GET.MQTTHost == config.MQTT_Host then
                buf = buf.. "<p>MQTT_Host not changed</p>";
            else
                print ("domus-silicea - webServer - New MQTT_Host:" .. _GET.MQTTHost)
                eeprom.saveSetting("config.MQTT_Host", _GET.MQTTHost)
                buf = buf.. "<p>MQTT_Host updated to " .. _GET.MQTTHost .. "</p>";            
            end
        end
        
        client:send(buf);
        client:close();
        collectgarbage();
    end 
    
    function webServer.start()
        print ("domus-silicea - webServer.start()") 
        if not (srv == nil) then 
            srv:close();
        end
        srv=net.createServer(net.TCP);
        srv:listen( 80,
                    function(conn)
                            conn:on("receive", webServerReceive)
                    end
                  );
    end        

return webServer
