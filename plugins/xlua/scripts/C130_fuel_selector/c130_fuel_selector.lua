
--
-- THIS SCRIPT CREATE CUSTOM COMMANDS TO CYCLE THE FUEL SELECTOR FROM LEFT, BOTH AND RIGHT (1,4,3)
-- AND REPLACE SHUT-DOWN COMMAND WITH FUEL SELECTION NONE (0)
--
-- THEN HANDLE THE R & L FUEL LEVEL GAUGES, SO THEY WILL SAY ZERO IF NO ELECTRICAL POWER AND ANIMATE SLOWLY
--


----------------------------------- LOCATE AND/OR CREATE DATAREFS -----------------------------------
fuel_tank_selector = find_dataref("sim/cockpit2/fuel/fuel_tank_selector") -- (0=none,1=left,2=center,3=right,4=all)


fuel_tank_selector_c130 = create_dataref("C130/fuel/fuel_tank_selector","number") -- (0=none,1=left,2=center,3=right,4=all)
fuel_cutoff_selector = create_dataref("C130/fuel/fuel_cutoff_selector","number") -- (0=none,1=fuel cutoff)




------------------------------- FUNCTIONS -------------------------------



------------------------------- FUNCTIONS: COMMANDS CALLBACK -------------------------------

function cmd_fuel_selector_up(phase, duration)
	if phase == 0 then
		if (fuel_tank_selector_c130 == 1) then
			fuel_tank_selector_c130 = 4
		elseif (fuel_tank_selector_c130 == 4) then
			fuel_tank_selector_c130 = 3
		elseif (fuel_tank_selector_c130 == 3) then
			fuel_tank_selector_c130 = 3
		else
			fuel_tank_selector_c130 = 4
		end
		if (fuel_cutoff_selector) == 0 then
			fuel_tank_selector = fuel_tank_selector_c130
		end
	end
end

function cmd_fuel_selector_dwn(phase, duration)
	if phase == 0 then
		if (fuel_tank_selector_c130 == 1) then
			fuel_tank_selector_c130 = 1
		elseif (fuel_tank_selector_c130 == 4) then
			fuel_tank_selector_c130 = 1
		elseif (fuel_tank_selector_c130 == 3) then
			fuel_tank_selector_c130 = 4
		else
			fuel_tank_selector = 4
		end
		if (fuel_cutoff_selector) == 0 then
			fuel_tank_selector = fuel_tank_selector_c130
		end
	end
end



function cmd_fuel_cutoff(phase, duration)
	if phase == 0 then
		if (fuel_cutoff_selector == 0) then
			fuel_cutoff_selector = 1
			fuel_tank_selector = 0
		else
			fuel_cutoff_selector = 0
			fuel_tank_selector = fuel_tank_selector_c130
		end
	end
end


------------------------------- LOCATE AND/OR CREATE COMMANDS -------------------------------

-- not used:
-- cmd_fuel_sel_left = find_command("sim/fuel/fuel_selector_lft")
-- cmd_fuel_sel_both = find_command("sim/fuel/fuel_selector_all")
-- cmd_fuel_sel_right = find_command("sim/fuel/fuel_selector_rgt")

cmdcustomfuelup = create_command("C130/fuel_selector_up","Move the fuel selector up one",cmd_fuel_selector_up)
cmdcustomfueldwn = create_command("C130/fuel_selector_dwn","Move the fuel selector down one",cmd_fuel_selector_dwn)

cmdfuelshutoff = replace_command("sim/starters/shut_down",cmd_fuel_cutoff)







----------------------------------- RUNTIME CODE -----------------------------------


-- DO THIS EACH FLIGHT START
function flight_start()
	fuel_cutoff_selector = 0
	--fuel_tank_selector = 4
	--fuel_tank_selector_c130 = 4
	fuel_tank_selector_c130 = fuel_tank_selector
end




-- REGULAR RUNTIME
function after_physics()



	-- KEEP UPDATED THE FUEL HANDLE
	if fuel_tank_selector_c130 ~= fuel_tank_selector and fuel_tank_selector ~= 0 then
		fuel_tank_selector_c130 = fuel_tank_selector
	end

end


