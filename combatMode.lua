local screen = peripheral.find("monitor")
local target = peripheral.find("create_target")
local link = peripheral.find("redstone_link_bridge")
local cannon = peripheral.find("cbc_cannon_mount")
local basicLib = require("basicLib")
local params = require("params")

local api = {}

local function waitForAssemble()
    if link.getLinkSignal(params.assembleCannonsLink[1], params.assembleCannonsLink[2]) == 15 then
        if not (cannon.isRunning()) then
            cannon.assemble()
        else
            cannon.disassemble()
        end
        sleep(0.5)
    end
end

function api.combatMode()
    local sizeX, sizeY = screen.getSize()
    while mode == "combat" do
        link.sendLinkSignal(params.refreshLink[1], params.refreshLink[2], 15)
        link.sendLinkSignal(params.refreshLink[1], params.refreshLink[2], 0)
        --local x, y, z = gps.locate(1, false) -- true for gps debug
        waitForAssemble()

        screen.clear()

        screen.setCursorPos(1, 1)
        screen.setTextColor(colors.lightGray)
        screen.write("Cannons: ")
        screen.setTextColor(colors.white)
        if cannon.isRunning() then
            screen.setTextColor(colors.lime)
            screen.write("Ready")
        else
            screen.setTextColor(colors.gray)
            screen.write("Disassembled")
        end

        screen.setCursorPos(math.floor((sizeX / 3) * 2) + 1, 1)
        screen.setTextColor(colors.white)
        if link.getLinkSignal(params.fireCannonsLink[1], params.fireCannonsLink[2]) == 15 then
            screen.setTextColor(colors.red)
            screen.write("Fire !")
        else
            screen.write("Stopped")
        end
        screen.setTextColor(colors.white)



        screen.setCursorPos(math.floor((sizeX / 3) * 2) + 1, sizeY - 1)
        screen.setTextColor(colors.white)
        screen.write("Combat Mode")

        sleep(0.1)
    end
end

return api