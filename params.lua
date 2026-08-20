local api = {}
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

return api