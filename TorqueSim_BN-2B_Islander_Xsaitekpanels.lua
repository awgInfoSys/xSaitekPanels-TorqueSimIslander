----------------------------------------------------------------------
-- Script for Xsaitekpanels with TorqueSim BN-2B Islander
-- Version: 1.01
-- Build:   4-Jul-2020
-- By: Andrew Gransden
----------------------------------------------------------------------
--Function prevents script from running with G1000 C172
----------------------------------------------------------------------
if (AIRCRAFT_FILENAME == "BN-2B Islander.acf") then
logMsg ( "FlyWithLua Info: ** Found plane TorqueSim BN-2B Islander ** ICAO " .. PLANE_ICAO .. " **" )
----------------------------------------------------------------------
--Import & Create DataRefs and Functions
----------------------------------------------------------------------
dataref("SwitchPanelCount", "bgood/xsaitekpanels/switchpanel/count", "writable")
dataref("RadioPanelCount", "bgood/xsaitekpanels/radiopanel/count", "writable")
dataref("MultiPanelCount", "bgood/xsaitekpanels/multipanel/count", "writable")
dataref("TpmPanelCount", "bgood/xsaitekpanels/tpmpanel/count", "writable")
----------------------------------------------------------------------
--Define Interger Datarefs
----------------------------------------------------------------------
dataref("Integer1", "bgood/xsaitekpanels/sharedata/integer1", "writable")
dataref("Integer2", "bgood/xsaitekpanels/sharedata/integer2", "writable")
dataref("Integer3", "bgood/xsaitekpanels/sharedata/integer3", "writable")
dataref("Integer4", "bgood/xsaitekpanels/sharedata/integer4", "writable")
dataref("Integer5", "bgood/xsaitekpanels/sharedata/integer5", "writable")
dataref("Integer6", "bgood/xsaitekpanels/sharedata/integer6", "writable")
dataref("Integer7", "bgood/xsaitekpanels/sharedata/integer7", "writable")
dataref("Integer8", "bgood/xsaitekpanels/sharedata/integer8", "writable")
dataref("Integer9", "bgood/xsaitekpanels/sharedata/integer9", "writable")
dataref("Integer10", "bgood/xsaitekpanels/sharedata/integer10", "writable")
----------------------------------------------------------------------
--Define Cockpit Lighting
----------------------------------------------------------------------
DataRef("Radio_Backlight","sim/cockpit2/switches/instrument_brightness_ratio","writable",1)
DataRef("Pedestal_Spotlight","sim/cockpit2/switches/instrument_brightness_ratio","writable",2)
DataRef("Pilot_Map_Light","sim/cockpit2/switches/panel_brightness_ratio","writable",0)
DataRef("CoPilot_Map_Light","sim/cockpit2/switches/panel_brightness_ratio","writable",1)
DataRef("Glareshield_Light","sim/cockpit2/switches/panel_brightness_ratio","writable",3)
DataRef("Panel_Lights","sim/cockpit/electrical/instrument_brightness","writable")
----------------------------------------------------------------------
--Define in Pitot Heat
----------------------------------------------------------------------
DataRef("Pitot_Heat_On","sim/cockpit/switches/pitot_heat_on","writable")
----------------------------------------------------------------------

----------------------------------------------------------------------
--Create Multi Panel Light DataRefs
----------------------------------------------------------------------
define_shared_DataRef("xsaitekpanels/sharedata/multi_hdg_light", "Int")
define_shared_DataRef("xsaitekpanels/sharedata/multi_nav_light", "Int")
define_shared_DataRef("xsaitekpanels/sharedata/multi_ias_light", "Int")
define_shared_DataRef("xsaitekpanels/sharedata/multi_alt_light", "Int")
define_shared_DataRef("xsaitekpanels/sharedata/multi_vs_light", "Int")
define_shared_DataRef("xsaitekpanels/sharedata/multi_apr_light", "Int")
define_shared_DataRef("xsaitekpanels/sharedata/multi_rev_light", "Int")
define_shared_DataRef("xsaitekpanels/sharedata/multi_ap_light", "Int")
----------------------------------------------------------------------
--Define Multi Panel Light DataRefs
----------------------------------------------------------------------
dataref("multi_hdg_light", "xsaitekpanels/sharedata/multi_hdg_light", "writable")
dataref("multi_nav_light", "xsaitekpanels/sharedata/multi_nav_light", "writable")
dataref("multi_ias_light", "xsaitekpanels/sharedata/multi_ias_light", "writable")
dataref("multi_alt_light", "xsaitekpanels/sharedata/multi_alt_light", "writable")
dataref("multi_vs_light", "xsaitekpanels/sharedata/multi_vs_light", "writable")
dataref("multi_apr_light", "xsaitekpanels/sharedata/multi_apr_light", "writable")
dataref("multi_rev_light", "xsaitekpanels/sharedata/multi_rev_light", "writable")
dataref("multi_ap_light", "xsaitekpanels/sharedata/multi_ap_light", "writable")
----------------------------------------------------------------------
--Define Autopilot Status Datarefs
----------------------------------------------------------------------
dataref("Autopilot_Hdg_Status", "sim/cockpit2/autopilot/heading_status", "readonly")
dataref("Autopilot_Nav_Status", "sim/cockpit2/autopilot/nav_status", "readonly")
-- ***** IAS used to indicate ALT Armed status *****
dataref("Autopilot_IAS_Status", "sim/cockpit2/autopilot/altitude_hold_armed", "readonly")
dataref("Autopilot_Alt_Status", "sim/cockpit2/autopilot/altitude_mode", "readonly")
dataref("Autopilot_VS_Status", "sim/cockpit2/autopilot/vvi_status", "readonly")
dataref("Autopilot_Apr_Status", "sim/cockpit2/autopilot/approach_status", "readonly")
dataref("Autopilot_Rev_Status", "sim/cockpit2/autopilot/backcourse_status", "readonly")
dataref("Autopilot_Test_Status", "sim/cockpit/warnings/autopilot_test_ap_lit", "writeable")
dataref("Autopilot_Fail", "sim/cockpit2/autopilot/otto_ready", "writeable")
dataref("Autopilot_Glideslope_Status", "sim/cockpit2/autopilot/glideslope_status", "readonly")
dataref("Autopilot_On", "sim/cockpit2/autopilot/autopilot_on", "readonly")
vvi_fpm = dataref_table("sim/cockpit/autopilot/vertical_velocity")
--sim/cockpit2/autopilot/glideslope_status 1 or 2
----------------------------------------------------------------------
--Create Multi Panel Button Commands
----------------------------------------------------------------------
create_command("xsaitekpanels/sharedata/multi/HDG","Multi panel HDG button","","","nav_button_pressed()")			   
create_command("xsaitekpanels/sharedata/multi/NAV","Multi panel NAV button","","","hdg_button_pressed()")
create_command("xsaitekpanels/sharedata/multi/vs_up","Multi panel Vertical Speed Up","vs_up()","","")
create_command("xsaitekpanels/sharedata/multi/vs_down","Multi panel Vertical Speed Down","vs_down()","","")
create_command("xsaitekpanels/sharedata/multi/alt_hold","Alt Hold Button","alt_button_pressed()","","")
----------------------------------------------------------------------
--Create Switch Panel DataRefs
----------------------------------------------------------------------
dataref("Engine_Starter", "afm/islander/f/switches/starter", "writeable")
dataref("Panel_Light_Knob", "afm/islander/f/knobs/cockpitLight", "writeable")
dataref("Panel_Light_Input", "sim/cockpit/electrical/cockpit_lights", "writable")
----------------------------------------------------------------------
--Create Switch Panel Commands
----------------------------------------------------------------------
----------------------------------------------------------------------
--	Cockpit Lights
----------------------------------------------------------------------
create_command("xsaitekpanels/sharedata/switch/Panel_Lights_On","Switch Panel Lights ON","panel_switch_on()","","")
create_command("xsaitekpanels/sharedata/switch/Panel_Lights_Off","Switch Panel Lights OFF","panel_switch_off()","","")
----------------------------------------------------------------------
--	Pitot Heat
----------------------------------------------------------------------
create_command("xsaitekpanels/sharedata/switch/Pitot_Heat_On","Pitot Heat ON","pitot_heat_on()","","")
create_command("xsaitekpanels/sharedata/switch/Pitot_Heat_Off","Pitot Heat OFF","pitot_heat_off()","","")

----------------------------------------------------------------------
-- Find Panels Loop (Checks for Panels)
----------------------------------------------------------------------
FindPanelsLoop = 0

function find_panels()
	if (FindPanelsLoop < 10) then
		FindPanelsLoop = FindPanelsLoop + 1
	end

	if (FindPanelsLoop == 5) then

		if (SwitchPanelCount > 0) then
			require("xsaitekpanels_switch")
			SwitchPanelFound = 1
		end

		if (RadioPanelCount > 0) then
			require("xsaitekpanels_radio1")
			Radio1PanelFound = 1
		end

		if (RadioPanelCount > 1) then
			require("xsaitekpanels_radio2")
			Radio2PanelFound = 1
		end

		if (RadioPanelCount > 2) then
			require("xsaitekpanels_radio3")
			Radio3PanelFound = 1
		end

		if (MultiPanelCount > 0) then
			require("xsaitekpanels_multi")
			MultiPanelFound = 1
		end

		if (TpmPanelCount > 0) then
			TpmPanelFound = 1
		end
	end
end
----------------------------------------------------------------------
--Start Custom BN-2B Code
----------------------------------------------------------------------
-- Delay
----------------------------------------------------------------------
--function delay(n)
--	local i = 0
--	while i < n do
--		i = i + 1
--	end
--end

----------------------------------------------------------------------
-- Engine Start
----------------------------------------------------------------------

function start_Engine_L_On()
	if (SwitchPanelFound == 1) then
		--	logMsg ( "FlyWithLua Info: awg Islander - Starter " .. Engine_Starter)
		if ((Engine_Starter > -0.1) and (Engine_Starter < 0.1)) then
			logMsg ( "FlyWithLua Info: awg Islander - start_Engine_L_On")
			command_begin("afm/islander/cmd/switches/starter_left")	
		end
	end
end
create_command("awg/islander/cmd/switches/EngL_On", "start L Engine", "start_Engine_L_On()", "", "")

function start_Engine_L_Off()
	if (SwitchPanelFound == 1) then
		--	logMsg ( "FlyWithLua Info: awg Islander - Starter " .. Engine_Starter)
		if (Engine_Starter < -0.9) then
			logMsg ( "FlyWithLua Info: awg Islander - start_Engine_L_Off")
			command_end("afm/islander/cmd/switches/starter_left")	
		end
	end
end
create_command("awg/islander/cmd/switches/EngL_Off", "cancel start L Engine", "start_Engine_L_Off()", "", "")

function start_Engine_R_On()
	if (SwitchPanelFound == 1) then
		--	logMsg ( "FlyWithLua Info: awg Islander - Starter " .. Engine_Starter)
		if ((Engine_Starter > -0.1) and (Engine_Starter < 0.1)) then
			logMsg ( "FlyWithLua Info: awg Islander - start_Engine_R_On")
			command_begin("afm/islander/cmd/switches/starter_right")	
		end
	end
end
create_command("awg/islander/cmd/switches/EngR_On", "start R Engine", "start_Engine_R_On()", "", "")

function start_Engine_R_Off()
	if (SwitchPanelFound == 1) then
		--	logMsg ( "FlyWithLua Info: awg Islander - Starter " .. Engine_Starter)
		if (Engine_Starter > 0.9) then
			logMsg ( "FlyWithLua Info: awg Islander - start_Engine_R_Off")
			command_end("afm/islander/cmd/switches/starter_right")	
		end
	end
end
create_command("awg/islander/cmd/switches/EngR_Off", "cancel start R Engine", "start_Engine_R_Off()", "start_Engine_R_Off()", "", "")

----------------------------------------------------------------------
--	Panel Light Knob
----------------------------------------------------------------------

function panel_light_On()
	if (SwitchPanelFound == 1) then
		Panel_Light_Knob = 1.0
	end
end
create_command("awg/islander/cmd/switches/panelLight_On", "turn on panel lights", "panel_light_On()", "","")

function panel_light_Off()
	if (SwitchPanelFound == 1) then
		Panel_Light_Knob = 0
	end
end
create_command("awg/islander/cmd/switches/panelLight_Off", "turn off panel lights", "panel_light_Off()", "","")

----------------------------------------------------------------------
--	Pitch Trim
----------------------------------------------------------------------

function trim_up()
	if (MultiPanelFound == 1) then
		for i = 1, 10 do
			command_once("sim/flight_controls/pitch_trim_up_mech")
		end
	end
end
create_command("awg/islander/cmd/pitch_trim_up", "pitch trim up", "trim_up()", "", "")

function trim_down()
	if (MultiPanelFound == 1) then
		for i = 1, 10 do
			command_once("sim/flight_controls/pitch_trim_down_mech")
		end
	end
end
create_command("awg/islander/cmd/pitch_trim_down", "pitch trim down", "trim_down()", "", "")

----------------------------------------------------------------------
--	HDG Button (Enable simultaneous HDG NAV mode)
----------------------------------------------------------------------
function hdg_button_pressed()
		if (MultiPanelFound == 1) then
			if (MULTI_HDG_BTN == 0) then
				command_once("sim/autopilot/NAV")
			elseif (MULTI_HDG_BTN == 1) then
				command_once("sim/autopilot/hdg_nav")
			else 
				command_once("sim/autopilot/NAV")
			end
		end
end
----------------------------------------------------------------------
--	NAV Button (Enable simultaneous HDG NAV mode)
----------------------------------------------------------------------
function nav_button_pressed()
		if (MultiPanelFound == 1) then
			if (MULTI_NAV_BTN == 0) then
				command_once("sim/autopilot/heading")
			elseif (MULTI_NAV_BTN == 1) then
				command_once("sim/autopilot/hdg_nav")
			else 
				command_once("sim/autopilot/heading")
			end
		end
end
----------------------------------------------------------------------
--	ALT Button (Sets VS on screen to 0)
----------------------------------------------------------------------
function alt_button_pressed()
		if (MultiPanelFound == 1) then
			vvi_fpm[0] = 0
			command_once("sim/autopilot/altitude_hold")
		end
end

----------------------------------------------------------------------
--	Multi Panel Lights
----------------------------------------------------------------------
function autopilot_light()
		
	if (MultiPanelFound == 1) then
----------------------------------------------------------------------
--		HDG Light
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_hdg_light = 0		
		elseif (Autopilot_Test_Status == 1) then
			multi_hdg_light = 1		
		elseif (Autopilot_Hdg_Status == 2) and (Autopilot_On == 1) then
			multi_hdg_light = 1
		else 
			multi_hdg_light = 0	
		end
----------------------------------------------------------------------
--		NAV Light
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_nav_light = 0
		elseif (Autopilot_Test_Status == 1) then
			multi_nav_light = 1		
		elseif (Autopilot_Apr_Status == 1) and (Autopilot_On == 1) then
			multi_nav_light = 0
		elseif (Autopilot_Nav_Status == 1) and (Autopilot_On == 1) then
			multi_nav_light = 1	
		elseif (Autopilot_Nav_Status == 2) and (Autopilot_On == 1) then
			multi_nav_light = 1			
		elseif (Autopilot_IAS_Status == 2) and (Autopilot_On == 1) then
			multi_nav_light = 1
		else 
			multi_nav_light = 0	
		end
----------------------------------------------------------------------
--		IAS Light ***** Indicates ALT Armed *****
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_ias_light = 0
		elseif (Autopilot_Test_Status == 1) then
			multi_ias_light = 1		
		elseif (Autopilot_IAS_Status == 1) and (Autopilot_On == 1) then
			multi_ias_light = 1			
		elseif (Autopilot_IAS_Status == 2) and (Autopilot_On == 1) then
			multi_ias_light = 1
		else 
			multi_ias_light = 0	
		end
----------------------------------------------------------------------
--		ALT Light
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_alt_light = 0
		elseif (Autopilot_Test_Status == 1) then
			multi_alt_light = 1	
		elseif (Autopilot_Glideslope_Status == 1) and (Autopilot__On == 1) then 	
			multi_alt_light = 1
		elseif (Autopilot_Glideslope_Status == 2) and (Autopilot_On == 1) then 	
			multi_alt_light = 1		
		elseif (Autopilot_Alt_Status == 6) and (Autopilot_On == 1) then
			multi_alt_light = 1
		else 
			multi_alt_light = 0
		end
----------------------------------------------------------------------
--		VS Light & VS display clear function
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_vs_light = 0
			vvi_fpm[0] = 0
		elseif (Autopilot_Test_Status == 1) then
			multi_vs_light = 1
			vvi_fpm[0] = 0			
		elseif (Autopilot_VS_Status == 2) and (Autopilot_On == 1) then
			multi_vs_light = 1
		else multi_vs_light = 0	
			vvi_fpm[0] = 0
		end
----------------------------------------------------------------------
--		APR Light
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_apr_light = 0
		elseif (Autopilot_Test_Status == 1) then
			multi_apr_light = 1
		elseif (Autopilot_IAS_status == 1) then -- ALT Armed
			multi_apr_light = 0
		elseif (Autopilot_Apr_Status == 1) and (Autopilot_On == 1) then
			multi_apr_light = 1
		elseif (Autopilot_Apr_Status == 2) and (Autopilot_On == 1) then
			multi_apr_light = 1
		else 
			multi_apr_light = 0	
		end
----------------------------------------------------------------------
--		REV Light
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_rev_light = 0
		elseif (Autopilot_Test_Status == 1) then
			multi_rev_light = 1
		elseif (Autopilot_Rev_Status == 1) and (Autopilot_On == 1) then
			multi_rev_light = 1
		elseif (Autopilot_Rev_Status == 2) and (Autopilot_On == 1) then
			multi_rev_light = 1
		else 
			multi_rev_light = 0	
		end
----------------------------------------------------------------------
--	AP Light
----------------------------------------------------------------------
		if (Autopilot_Fail == 1) then
			multi_ap_light = 0
		elseif (Autopilot_Test_Status == 1) then
			multi_ap_light = 1
		elseif (Autopilot_On == 1) then
			multi_ap_light = 1
		else 
			multi_ap_light = 0
		end
----------------------------------------------------------------------
	end
end
----------------------------------------------------------------------

----------------------------------------------------------------------
--	Pitot Heat Toggle
----------------------------------------------------------------------
--		Pitot Heat ON
----------------------------------------------------------------------
function pitot_heat_on()
	Pitot_Heat_On = 1
end
----------------------------------------------------------------------
--		Pitot Heat OFF
----------------------------------------------------------------------
function pitot_heat_off()
	Pitot_Heat_On = 0
end
----------------------------------------------------------------------
--	Vertical Speed Functions
----------------------------------------------------------------------
--		Vertical Speed Up
----------------------------------------------------------------------
function vs_up()
	if multi_vs_light == 2 then
		command_once("sim/autopilot/vertical_speed_up")
	end
end
----------------------------------------------------------------------
--		Vertical Speed Down
----------------------------------------------------------------------
function vs_down()
	if multi_vs_light == 2 then
		command_once("sim/autopilot/vertical_speed_down")
	end
end
----------------------------------------------------------------------

----------------------------------------------------------------------
--	Functions requiring constant updating
----------------------------------------------------------------------
do_every_frame ("find_panels()")
do_every_frame ("autopilot_light()")
----------------------------------------------------------------------
--End Function
----------------------------------------------------------------------
end