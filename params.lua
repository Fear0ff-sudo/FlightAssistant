local target = peripheral.find("create_target")

local api = {}
-- #####################################################
-- #                  CONFIGURATION:                   #
-- #####################################################

-- Welcome to the configuration file !

-- Please edit the values you need. Do not touch the other values.

-- If you want to use your own redstone links channels, edit them 
-- following the guide in the section below.

-- If you want to connect wirelessly with display links sensors,
-- go to the display link / wireless section.

-- #####################################################
-- #         REDSTONE LINKS CONFIGURATION:             #
-- #####################################################

-- HOW TO ADD YOUR LINKS TO THE CONFIGURATION:
-- Modify the links values following the pattern:
-- api.nameOfTheLink = {"mod:bloc", "mod:bloc"}
--
--Exemple:
-- api.throttleLink = {"minecraft:white_wool", "simulated:analog_transmission"}

api.throttleLink = {"minecraft:white_wool", "simulated:analog_transmission"} -- throttle link for your ship 
api.refreshLink = {"minecraft:observer", "minecraft:observer"} -- refresh link to refresh the display links
api.changeModeLink = {"computercraft:monitor_advanced", "minecraft:lever"} -- change between flightMode and other modes
api.assembleCannonsLink = {"computercraft:monitor_advanced", "createbigcannons:cannon_mount"} -- assemble and disassemble all the cannons 
api.fireCannonsLink = {"computercraft:monitor_advanced", "createbigcannons:solid_shot"} -- fires all the cannons 

-- #####################################################
-- #             DISPLAY LINKS / WIRELESS:             #
-- #####################################################

-- HOW TO ADD YOUR LINKS TO THE CONFIGURATION:
-- Modify the links values following the pattern:
-- api.nameOfTheLink = NUMBER
--
--Exemple:
-- api.velocity = 2

-- NOTE: Please note that the wire connected devices will be
-- the one used if you have multiple devices of the same type.
-- ALL the devices not connected by wire must be added here,
-- by decommenting and editing the corresponding line, otherwise,
-- the device data will not show up at all on the monitor.

-- All devices connected wirelessly will show up in blue,
-- after the execution of the checkForPeripherics command. (will execute automaticly)

if target == nil then 
    term.setTextColor(colors.orange)
    print("No Target block, No wireless communication possible !")
    term.setTextColor(colors.white)
else
    api.altimeter = 1 -- put a display link on the altimeter in "Height" mode
    api.pressuremeter = 3 -- put a second display link on the altimeter in "pressure" mode (Need both altitudemeter and pressuremeter to work)
--    api.gimbalX = 6 -- put a display link on the gimbal in "X Angle" mode
--    api.gimbalZ = 7 -- put a second display link on the gimbal in "Z Angle" mode
--    api.engine = 5 -- put a display link on the engine in "total burn time" mode
    api.energy = 4 -- put a display link on the Threshold Switch connected to the fuel container
    api.velocity = 2 -- put a display link on the Velocity sensort connected to the fuel container
end

return api