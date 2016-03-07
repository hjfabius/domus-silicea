local eeprom = {}

    print ("domus-silicea - eeprom.lua - Script Starting") 


    function eeprom.saveSetting(name, value)
        print("domus-silicea - eeprom.lua - Writing " .. name .. ": " .. value)
        file.open(name, 'w') -- you don't need to do file.remove if you use the 'w' method of writing
        file.writeline(value)
        file.close()
    end
    
    function eeprom.readSetting(name)
        print("domus-silicea - eeprom.lua - Reading " .. name)
        if file.open(name) then
            print("domus-silicea - eeprom.lua - File found ")
            --file.open(name)
            result = string.sub(file.readline(value), 1, -2) -- to remove newline character
            file.close()
            print("domus-silicea - eeprom.lua - Value: " ..  result)
            return result
        else
            print("domus-silicea - eeprom.lua - File not found ")
            return nil
        end
    end


    function eeprom.start()
        print ("domus-silicea - eeprom.start()") 

        local val;
        
        val = eeprom.readSetting("config.MQTT_Host")
        if val then
            config.MQTT_Host = val
        end 
    end        

return eeprom
