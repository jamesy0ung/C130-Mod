
-- THIS SCRIPT IS HERE TO INITIALIZE SOME VALUES



----------------------------------- LOCATE DATAREFS OR COMMANDS -----------------------------------
canopy = find_dataref("sim/cockpit2/switches/canopy_open")





--------------------------------- CREATING FUNCTIONS TO CALL BACK ---------------------------------

-- NONE




--------------------------------- DO THIS EACH FLIGHT START ---------------------------------
function flight_start()

	-- canopy always on 
	canopy = 1

end