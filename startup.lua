local speaker = peripheral.find("speaker")
local screenLib = require("screenLib")
local screen = peripheral.find("monitor")

local function startupSound()
    speaker.playNote("harp", 1.0, 12)
    sleep(0.2)
    speaker.playNote("harp", 1.0, 14)
    sleep(0.2)
    speaker.playNote("harp", 1.0, 17)
    sleep(0.5)
    speaker.playSound("entity.player.levelup", 1.0, 1.0)
end

local function startupDisplay()
    local sizeX, sizeY = screen.getSize()
    screen.setTextScale(0.5)
    print(sizeY)
    if (sizeX <= 15 or sizeY <= 10) then
        screen.setTextScale(0.5)
    else
        screen.setTextScale(1)
    end
    local sizeX, sizeY = screen.getSize()
    screen.setBackgroundColor(colors.black)
    screen.clear()
    screen.setCursorPos(2, math.floor(sizeY / 2))

    screenLib.loadingBarClean(screen, 20)
    sleep(0.2)
    screen.setCursorPos(2, math.floor(sizeY / 2))
    screenLib.loadingBarClean(screen, 60)
    sleep(0.2)
    screen.setCursorPos(2, math.floor(sizeY / 2))
    screenLib.loadingBarClean(screen, 100)
    sleep(0.5)
    screen.setCursorPos(math.floor((sizeX - 6) / 2) + 1, math.floor((sizeY / 2) - 2))
    screen.write("Flight")
    screen.setCursorPos(math.floor((sizeX - 9) / 2) + 1, math.floor((sizeY / 2) - 1))
    screen.write("Assistant")
end

parallel.waitForAll(startupDisplay, startupSound)