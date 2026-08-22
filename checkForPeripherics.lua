local params = require("params")
local api = {}

function api.checkForPeripherics()
    local screen = peripheral.find("monitor")
    if screen == nil then
        isScreen = false
        term.setTextColor(colors.red)
        print("No Monitor detected...")
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.green)
        print("Monitor detected !")
        term.setTextColor(colors.white)
        isScreen = true
    end

    local link = peripheral.find("redstone_link_bridge")
    if link == nil then
        isLinkBridge = false
        term.setTextColor(colors.orange)
        print("No LinkBridge detected...")
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.green)
        print("LinkBridge detected !")
        term.setTextColor(colors.white)
        isLinkBridge = true
    end

    local modem = peripheral.find("modem", function(nomDuPeripherique, objetModem)
        return objetModem.isWireless()
    end)
    if modem == nil then
        isModem = false
        term.setTextColor(colors.orange)
        print("No Wireless Modem detected...")
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.green)
        print("Wireless Modem detected !")
        term.setTextColor(colors.white)
        isModem = true
    end

    local target = peripheral.find("create_target")
    if target == nil then
        isTarget = false
        term.setTextColor(colors.orange)
        print("No Target detected...")
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.green)
        print("Target detected !")
        term.setTextColor(colors.white)
        isTarget = true
    end

    local cannon = peripheral.find("cbc_cannon_mount")
    if cannon == nil then
        isCannon = false
        term.setTextColor(colors.orange)
        print("No Cannon detected...")
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.green)
        print("Cannon detected !")
        term.setTextColor(colors.white)
        isCannon = true
    end

    local altimeter = peripheral.find("altitude_sensor")
    if altimeter == nil then
        if params.altimeter == nil then
            isAltimeter = false
            isAltimeterWireless = false
            term.setTextColor(colors.orange)
            print("No Altimeter / Pressuremeter detected...")
            term.setTextColor(colors.white)
        else
            term.setTextColor(colors.blue)
            print("Altimeter detected !")
            term.setTextColor(colors.white)
            isAltimeter = false
            isAltimeterWireless = true
            altimeter = params.altimeter
            if (params.pressuremeter ~= nil) then
                term.setTextColor(colors.blue)
                print("Pressuremeter detected !")
                term.setTextColor(colors.white)
                isPressuremeterWireless = true
            else
                term.setTextColor(colors.orange)
                print("No Pressuremeter detected...")
                term.setTextColor(colors.white)
                isPressuremeterWireless = false
            end
        end
    else
        term.setTextColor(colors.green)
        print("Altimeter / Pressuremeter detected !")
        term.setTextColor(colors.white)
        isAltimeter = true
        isAltimeterWireless = false
        params.altimeter = altimeter
    end

    local gimbal = peripheral.find("gimbal_sensor")
    if gimbal == nil then
        if (params.gimbalX == nil) or (params.gimbalZ == nil) then
            isGimbal = false
            isGimbalWireless = false
            term.setTextColor(colors.orange)
            print("No Gimbal sensor detected...")
            term.setTextColor(colors.white)
        else
            term.setTextColor(colors.blue)
            print("Gimbal sensor detected !")
            term.setTextColor(colors.white)
            isGimbal = false
            isGimbalWireless = true
            gimbal = {params.gimbalX, params.gimbalZ}
        end
    else
        term.setTextColor(colors.green)
        print("Gimbal sensor detected !")
        term.setTextColor(colors.white)
        isGimbal = true
        isGimbalWireless = false
        params.gimbal = gimbal
    end

    local velocity = peripheral.find("velocity_sensor")
    if velocity == nil then
        if params.velocity == nil then
            isVelocity = false
            isVelocityWireless = false
            term.setTextColor(colors.orange)
            print("No Velocity sensor detected...")
            term.setTextColor(colors.white)
        else
            term.setTextColor(colors.blue)
            print("Velocity sensor detected !")
            term.setTextColor(colors.white)
            isVelocity = false
            isVelocityWireless = true
            velocity = params.velocity
        end
    else
        term.setTextColor(colors.green)
        print("Velocity sensor detected !")
        term.setTextColor(colors.white)
        isVelocity = true
        isVelocityWireless = false
        params.velocity = velocity
    end

    if params.throttleLink == nil then
        isThrottleLink = false
        term.setTextColor(colors.orange)
        print("No Throttle Link detected...")
        term.setTextColor(colors.white)
    else
        isThrottleLink = true
        term.setTextColor(colors.blue)
        print("Throttle Link detected !")
        term.setTextColor(colors.white)
    end


    
    if params.energy == nil then
        isEnergyWireless = false
        term.setTextColor(colors.orange)
        print("No Energy sensor detected...")
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.blue)
        print("Energy sensor detected !")
        term.setTextColor(colors.white)
        isEnergyWireless = true
    end
    
    if params.engine == nil then
        isEngineWireless = false
        term.setTextColor(colors.orange)
        print("No Engine sensor detected...")
        term.setTextColor(colors.white)
    else
        term.setTextColor(colors.blue)
        print("Engine sensor detected !")
        term.setTextColor(colors.white)
        isEngineWireless = true
    end

    if (isScreen == false) then 
        print()
        term.setTextColor(colors.red)
        print("Connect a monitor to run the program !!")
        term.setTextColor(colors.white)
        print("Exiting...")
        return (1)
    end
    if (isLinkBridge == false) then 
        print()
        term.setTextColor(colors.red)
        print("Connect a redstone Link Bridge to run the program !!")
        term.setTextColor(colors.white)
        print("Exiting...")
        return (1)
    end
end

function api.debug()
    if isAltimeter then
        print(altimeter.getHeight())
    elseif isAltimeterWireless then
        print(target.getLine(params.altimeter))
    end

--   if isGimbal then
--        print(textutils.serialize(gimbal.getAngles()))
--    elseif isGimbalWireless then
--        print(string.gsub(gimbal[1], " ", "") .. " " .. gimbal[2])
--    end

    if isVelocity then
        print(velocity.getVelocity())
    elseif isVelocityWireless then
        print(target.getLine(params.velocity))
    end
end

return api