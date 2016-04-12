local ledRGB = {}

    print ("domus-silicea - ledRGB.lua - Script Starting") 

    --Accept value between 0 and 255
    function ledRGB.setRGB(R, G, B)
        if R ~= nil then
            pwm.setduty(config.GPIO_ledR, R*10)
            print("set RGB Red pin " .. config.GPIO_ledR .. " with duty " .. R*10) 
        end
        if G ~= nil then
            pwm.setduty(config.GPIO_ledG, G*10)
            print("set RGB Green pin " .. config.GPIO_ledG .. " with duty " .. G*10) 
        end
        if B ~= nil then
            pwm.setduty(config.GPIO_ledB, B*10)
            print("set RGB Blue pin " .. config.GPIO_ledB .. " with duty " .. B*10) 
        end
    end




    function ledRGB.stop()
        pwm.close(config.GPIO_ledR)
        gpio.mode(config.GPIO_ledR, gpio.OUTPUT)
        gpio.write(config.GPIO_ledR, gpio.LOW)
        
        pwm.close(config.GPIO_ledG)
        gpio.mode(config.GPIO_ledG, gpio.OUTPUT)
        gpio.write(config.GPIO_ledG, gpio.LOW)

        pwm.close(config.GPIO_ledB)
        gpio.mode(config.GPIO_ledB, gpio.OUTPUT)
        gpio.write(config.GPIO_ledB, gpio.LOW)
    end

    
    function ledRGB.start()
        print ("domus-silicea - ledRGB.start()") 
        --set RGB pin as pwm output, frequency is 200Hz, 
        pwm.setup(config.GPIO_ledR, 200, 0)
        pwm.setup(config.GPIO_ledG, 200, 0)
        pwm.setup(config.GPIO_ledB, 200, 0)

        pwm.start(config.GPIO_ledR)
        pwm.start(config.GPIO_ledG)
        pwm.start(config.GPIO_ledB)

    end        

return ledRGB
