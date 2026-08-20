local screen = peripheral.find("monitor")
local target = peripheral.find("create_target")
local link = peripheral.find("redstone_link_bridge")
local basicLib = require("basicLib")
local params = require("params")

local api = {}

function api.flightMode()
    local sizeX, sizeY = screen.getSize()
    while mode == "flight" do
        link.sendLinkSignal(params.refreshLink[1], params.refreshLink[2], 15)
        link.sendLinkSignal(params.refreshLink[1], params.refreshLink[2], 0)
        local x, y, z = gps.locate(1, false) -- true for gps debug
        screen.clear()

        screen.setCursorPos(1, 1)
        screen.setTextColor(colors.lightBlue)
        screen.write("ALT:")
        screen.setTextColor(colors.white)
        screen.write(target.getLine(1))

        screen.setCursorPos(math.floor(sizeX / 3) + 1, 1)
        screen.setTextColor(colors.lightGray)
        screen.write("PRS:")
        screen.setTextColor(colors.white)

        screen.write(target.getLine(3))

        screen.setCursorPos(math.floor((sizeX / 3) * 2) + 1, 1)
        screen.setTextColor(colors.yellow)
        screen.write("ENG:")
        screen.setTextColor(colors.white)
        screen.write(target.getLine(4))

        screen.setCursorPos(1, 2)
        screen.setTextColor(colors.red)
        screen.write("SPE:")
        screen.setTextColor(colors.white)
        screen.write(target.getLine(2))

        screen.setCursorPos(math.floor(sizeX / 3) + 1, 2)
        screen.setTextColor(colors.lightGray)
        screen.write("THR:")
        screen.setTextColor(colors.white)
        screen.write(math.floor(basicLib.map(link.getLinkSignal(params.throttleLink[1], params.throttleLink[2]), 0, 15, 100, 0)))
        screen.write("%")

        screen.setCursorPos(1, 3)
        screen.setTextColor(colors.lightGray)
        screen.write("ECO:")
        screen.setTextColor(colors.white)
        screen.write(math.floor(((tonumber((string.gsub(target.getLine(5), ",", "")))) / 60 )) .. "mn")

        screen.setCursorPos(1, 4)
        screen.setTextColor(colors.green)
        screen.write("GPS:")
        screen.setTextColor(colors.white)
        if x ~= nil then
            screen.write(math.ceil(x) .. " " .. math.ceil(y) .. " " .. math.ceil(z))
        else
            screen.write("No service")
        end

        screen.setCursorPos(1, 5)
        screen.setTextColor(colors.blue)
        screen.write("ANG:")
        screen.setTextColor(colors.white)
        screen.write(string.gsub(target.getLine(6), " ", "") .. " " .. string.gsub(target.getLine(7), " ", ""))

        screen.setCursorPos(math.floor((sizeX / 3) * 2) + 1, sizeY - 1)
        screen.setTextColor(colors.white)
        screen.write("Flight Mode")

        sleep(0.1)
    end
end

return api