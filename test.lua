local screen = peripheral.find("monitor")
local target = peripheral.find("create_target")

local api = {}

function api.test()
    while true do
        screen.clear()
        screen.setCursorPos(1, 1)
        screen.write("Altitude: " .. target.getLine(1))
        screen.setCursorPos(1, 2)
        screen.write("Pressure: " .. target.getLine(3))
        screen.setCursorPos(1, 3)
        screen.write("Speed: " .. target.getLine(2))
        sleep(0.1)
    end
end

return api