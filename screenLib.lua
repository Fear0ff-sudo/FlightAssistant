local api = {}

function api.loadingBar(screen, percentage)
    screen.clearLine()
    screen.setTextColor(colors.blue)
    local sizeX, sizeY = screen.getSize()
    if percentage ~= 0 then
        for i = 1, math.ceil((percentage / 100) * sizeX) do
            screen.write("#")
        end
    end
    screen.setTextColor(colors.gray)
    for i = 1, math.ceil((sizeX - (percentage / 100) * sizeX)) do
        screen.write("#")
    end
    screen.setTextColor(colors.white)
end

function api.loadingBarClean(screen, percentage)
    screen.clearLine()
    screen.setBackgroundColor(colors.blue)
    local sizeX, sizeY = screen.getSize()
    local sizeX = sizeX -2
    barSize = math.floor((percentage / 100) * sizeX)
    if percentage ~= 0 then
        for i = 1, barSize do
            screen.write(" ")
        end
    end
    screen.setBackgroundColor(colors.gray)
    for i = 1, sizeX - barSize do
        screen.write(" ")
    end
    screen.setBackgroundColor(colors.black)
end

function api.centerTextScreen(screen, text)
    local sizeX, sizeY = screen.getSize()
    screen.setCursorPos(math.floor((sizeX - #text) / 2) + 1, math.floor(sizeY / 2))
    screen.write(text)
end

function api.centerTextScreenX(screen, text)
    local sizeX, sizeY = screen.getSize()
    local posX, posY = screen.getCursorPos()
    screen.setCursorPos(math.floor((sizeX - #text) / 2) + 1, posY)
    screen.write(text)
end

function api.centerTextScreenY(screen, text)
    local sizeX, sizeY = screen.getSize()
    local posX, posY = screen.getCursorPos()
    screen.setCursorPos(posX, math.floor(sizeY / 2))
    screen.write(text)
end

function api.getNextDisplayPos(screen, nDisplayed)
    local sizeX, sizeY = screen.getSize()
    if sizeX > 15 then
        local y = math.floor(nDisplayed / 3) + 1
        local x = (math.floor(sizeX / 3) * (nDisplayed % 3)) + 1
        screen.setCursorPos(x, y)
    else
        local y = nDisplayed + 1
        local x = 1
        screen.setCursorPos(x, y)
    end
end

function api.getNextDisplayPosSmall(screen, nDisplayed)
    local sizeX, sizeY = screen.getSize()
    local y = math.floor(nDisplayed / 2) + 1
    local x = (math.floor(sizeX / 2) * (nDisplayed % 2)) + 1
    screen.setCursorPos(x, y)
end

--api.getNextDisplayPos(peripheral.find("monitor"), 0)

return api