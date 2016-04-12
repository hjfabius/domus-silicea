local arduinoOneWire = {}
    
    print ("domus-silicea - arduinoOneWire.lua - Script Starting") 

    

    function arduinoOneWire.start()
        print ("domus-silicea - arduinoOneWire.start()") 
        ow.setup(config.GPIO_ArduinoOneWire)

        count = 0
        repeat
          count = count + 1
          addr = ow.reset_search(config.GPIO_ArduinoOneWire)
          addr = ow.search(config.GPIO_ArduinoOneWire)
          tmr.wdclr()
        until((addr ~= nil) or (count > 100))
        if (addr == nil) then
          print("No more addresses.")
        else
          print(addr:byte(1,8))
          crc = ow.crc8(string.sub(addr,1,7))
          if (crc == addr:byte(8)) then
            if ((addr:byte(1) == 0x10) or (addr:byte(1) == 0x28)) then
              print("Device is a DS18S20 family device.")
            else
              print("Device family is not recognized.")
            end
          else
            print("CRC is not valid!")
          end
        end
        
    end

  
return arduinoOneWire
