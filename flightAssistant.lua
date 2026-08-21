local startup = require("startup")
local flightMode = require("flightMode")
local combatMode = require("combatMode")
local link = peripheral.find("redstone_link_bridge")
local params = require("params")
local checkForPeripherics = require("checkForPeripherics")

function waitForChange()
    local change = 0
    while change == 0 do
        if link.getLinkSignal(params.changeModeLink[1], params.changeModeLink[2]) == 15 then
            sleep(0.2)
            changeMode()
            change = 1
        end
    end
end

function changeMode()
    if mode == "flight" then
        mode = "combat"
    else
        mode = "flight"
    end
end

checkForPeripherics.checkForPeripherics()
startup.startup()
sleep(1)
mode = "flight"
parallel.waitForAny(flightMode.flightMode, waitForChange)
while true do
    if mode == "flight" then
        parallel.waitForAny(flightMode.flightMode, waitForChange)
    else
        parallel.waitForAny(combatMode.combatMode, waitForChange)
    end
end

