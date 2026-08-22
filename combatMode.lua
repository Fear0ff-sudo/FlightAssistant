local screen = peripheral.find("monitor")
local target = peripheral.find("create_target")
local link = peripheral.find("redstone_link_bridge")
local cannon = peripheral.find("cbc_cannon_mount")
local basicLib = require("basicLib")
local screenLib = require("screenLib")
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
        waitForAssemble()
        local nDisplayed = 0

        screen.clear()

        screenLib.getNextDisplayPos(screen, nDisplayed)
        screen.setTextColor(colors.lightGray)
        screen.write("CAN: ")
        screen.setTextColor(colors.white)
        if cannon.isRunning() then
            screen.setTextColor(colors.lime)
            screen.write("RDY")
        else
            screen.setTextColor(colors.gray)
            screen.write("DIS")
        end
        nDisplayed = nDisplayed + 1

        screenLib.getNextDisplayPos(screen, nDisplayed)
        screen.setTextColor(colors.white)
        if link.getLinkSignal(params.fireCannonsLink[1], params.fireCannonsLink[2]) == 15 then
            screen.setTextColor(colors.red)
            screen.write("Fire !")
        else
            screen.write("Stopped")
        end
        screen.setTextColor(colors.white)
        nDisplayed = nDisplayed + 1



        -- Combat Mode Text
        if sizeX > 15 then
            screen.setCursorPos(sizeX - 10, sizeY)
            screen.setTextColor(colors.white)
            screen.write("Combat Mode")
        else
            screen.setCursorPos(sizeX, sizeY)
            screen.setTextColor(colors.white)
            screen.write("C")
        end

        sleep(0.1)
    end
end

return api