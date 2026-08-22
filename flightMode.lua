local screen = peripheral.find("monitor")
local target = peripheral.find("create_target")
local link = peripheral.find("redstone_link_bridge")
local basicLib = require("basicLib")
local screenLib = require("screenLib")
local params = require("params")

local api = {}

function api.flightMode()
    local sizeX, sizeY = screen.getSize()
    while mode == "flight" do
        link.sendLinkSignal(params.refreshLink[1], params.refreshLink[2], 15)
        link.sendLinkSignal(params.refreshLink[1], params.refreshLink[2], 0)
        local x, y, z
        if isModem == true then
            x, y, z = gps.locate(1, false) -- true for gps debug
        end
        screen.clear()
        local nDisplayed = 0

        -- HEIGHT
        if isAltimeter then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.lightBlue)
            screen.write("ALT:")
            screen.setTextColor(colors.white)
            screen.write((math.floor((params.altimeter.getHeight() * 100) + 0.5) / 100) .. "m")
            nDisplayed = nDisplayed + 1
        elseif isAltimeterWireless then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.lightBlue)
            screen.write("ALT:")
            screen.setTextColor(colors.white)
            screen.write(string.gsub(target.getLine(params.altimeter), " ", "") ..  "m")
            nDisplayed = nDisplayed + 1
        end

        -- PRESSURE
        if isAltimeter then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.lightGray)
            screen.write("PRS:")
            screen.setTextColor(colors.white)
            screen.write((math.floor((params.altimeter.getAirPressure() * 10000) + 0.5) / 100) .. "%")
            nDisplayed = nDisplayed + 1
        elseif isPressuremeterWireless then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.lightGray)
            screen.write("PRS:")
            screen.setTextColor(colors.white)
            screen.write(target.getLine(params.pressuremeter))
            nDisplayed = nDisplayed + 1
        end

        -- ENERGY
        if isEnergyWireless then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.yellow)
            screen.write("ENE:")
            screen.setTextColor(colors.white)
            screen.write(target.getLine(params.energy))
            nDisplayed = nDisplayed + 1
        end

        -- SPEED
        if isVelocity then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.red)
            screen.write("SPE:")
            screen.setTextColor(colors.white)
            screen.write((math.floor((params.velocity.getVelocity() * 100) + 0.5) / 100) .. " m/s")
            nDisplayed = nDisplayed + 1
        elseif isVelocityWireless then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.red)
            screen.write("SPE:")
            screen.setTextColor(colors.white)
            screen.write(target.getLine(params.velocity))
            nDisplayed = nDisplayed + 1
        end

        -- Throttle
        if isThrottleLink == true then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.lightGray)
            screen.write("THR:")
            screen.setTextColor(colors.white)
            screen.write(math.floor(basicLib.map(link.getLinkSignal(params.throttleLink[1], params.throttleLink[2]), 0, 15, 100, 0)))
            screen.write("%")
            nDisplayed = nDisplayed + 1
        end

        -- Autonomy
        if isEngineWireless == true then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.orange)
            screen.write("AUT:")
            screen.setTextColor(colors.white)
            screen.write(math.floor(((tonumber((string.gsub(target.getLine(params.engine), ",", "")))) / 60 )) .. "mn")
            nDisplayed = nDisplayed + 1
        end

        -- GPS
        if isModem == true then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.green)
            screen.write("X:")
            screen.setTextColor(colors.white)
            if x ~= nil then
                screen.write(math.ceil(x))
            else
                screen.write("NS")
            end
            nDisplayed = nDisplayed + 1

            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.green)
            screen.write("Y:")
            screen.setTextColor(colors.white)
            if x ~= nil then
                screen.write(math.ceil(y))
            else
                screen.write("NS")
            end
            nDisplayed = nDisplayed + 1

            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.green)
            screen.write("Z:")
            screen.setTextColor(colors.white)
            if x ~= nil then
                screen.write(math.ceil(z))
            else
                screen.write("NS")
            end
            nDisplayed = nDisplayed + 1
        end

        -- Gimbal sensor
        if isGimbal then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.blue)
            screen.write("ANG:")
            screen.setTextColor(colors.white)
            local angs = params.gimbal.getAngles()
            local angX = angs[1]
            local angZ = angs[2]
            screen.write(math.floor((tonumber(angX) * 100) + 0.5) / 100 .. " " .. math.floor((tonumber(angZ) * 100) + 0.5) / 100)
            nDisplayed = nDisplayed + 1
        elseif isGimbalWireless then
            screenLib.getNextDisplayPos(screen, nDisplayed)
            screen.setTextColor(colors.blue)
            screen.write("ANG:")
            screen.setTextColor(colors.white)
            screen.write(string.gsub(target.getLine(params.gimbalX), " ", "") .. " " .. string.gsub(target.getLine(params.gimbalZ), " ", ""))
            nDisplayed = nDisplayed + 1
        end

        -- Flight Mode Text
        if sizeX > 15 then
            screen.setCursorPos(sizeX - 10, sizeY)
            screen.setTextColor(colors.white)
            screen.write("Flight Mode")
        else
            screen.setCursorPos(sizeX, sizeY)
            screen.setTextColor(colors.white)
            screen.write("F")
        end
        sleep(0.1)
    end
end

return api