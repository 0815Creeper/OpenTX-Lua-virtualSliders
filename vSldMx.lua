--[[
virtual Slider - Mixscript

IMPORTANT: 
Do not use lua scripts for critical functions that could result in a crash if misbehaving. 
Use a fallback mixer line if applicable. See https://doc.open-tx.org/opentx-2-2-lua-reference-guide/part_i_-_script_type_overview/mix for how to do that
Scripts need SD cards!

What does it do:
generates 6 additional virtual proportional input sources (similar to silders) named A, B, C, D, E and F.
Useful in particular for radios like jumper t-lite where there are not enough inputs like switches and sliders

How does it work:
If the virtual Slider Telemetryscript is runnig, you can adjust the values of the 6 virtual sliders with the menue navigation buttons of the radio.
See affiliated virtual Slider Telemetryscipt for details on how to do that.

How to use:
- make shure your model has a destict name (not the default MODEL X of optentx). changing the model name will result in the settings of vSlider getting reset (ajust the filename of the model_vSld.data file in the scripts folder to restore the settings)  
- enable this Mixscript in the custom scripts tab of the model
- select the LUA A through F sources as mixer or other sources as you whish (keep in mind to give fallback mixlines in case the lua sandbox gets terminated by OpenTx)
- enable the virtual Slider Telemetryscript in the Telemetry/Display menue
- access the telemetryscipt from the homescreen and ajust stepsize and values as you whish

--]]

function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
		local i=0
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
			i = i + 1
        end
        return t
end

vSld_model_name = "null"
vSld_selected = 0
vSld_type = 0
vSld_scalerunning = 0
vSld_propA = 0
vSld_propB = 0
vSld_propC = 0
vSld_propD = 0
vSld_propE = 0
vSld_propF = 0
vSld_adjustA = 1024
vSld_adjustB = 1024
vSld_adjustC = 1024
vSld_adjustD = 1024
vSld_adjustE = 1024
vSld_adjustF = 1024

local input = {}

local output = { "A","B","C","D","E","F" }

local function init_func()
	vSld_model_name = model.getInfo().name
	local settingsfile = io.open("/SCRIPTS/"..vSld_model_name.."_vSld.data", "r")
	local settingsstring = io.read(settingsfile, 128)
	io.close(settingsfile)
	if not (settingsstring == "") then
		local t = mysplit(settingsstring,"\n")
		if not (t[0] == nil or t[1] == nil or t[2] == nil or t[3] == nil or t[4] == nil or t[5] == nil or t[6] == nil or t[7] == nil or t[8] == nil or t[9] == nil or t[10] == nil or t[11] == nil or t[12] == nil or t[13] == nil or t[14] == nil) then
			vSld_selected = tonumber(t[0])
			vSld_type = tonumber(t[1])
			vSld_scalerunning = tonumber(t[2])
			vSld_propA = tonumber(t[3])
			vSld_propB = tonumber(t[4])
			vSld_propC = tonumber(t[5])
			vSld_propD = tonumber(t[6])
			vSld_propE = tonumber(t[7])
			vSld_propF = tonumber(t[8])
			vSld_adjustA = tonumber(t[9])
			vSld_adjustB = tonumber(t[10])
			vSld_adjustC = tonumber(t[11])
			vSld_adjustD = tonumber(t[12])
			vSld_adjustE = tonumber(t[13])
			vSld_adjustF = tonumber(t[14])
		end
	end
end

local function run_func()
	return vSld_propA, vSld_propB, vSld_propC, vSld_propD, vSld_propE, vSld_propF
end

return { input=input, output=output, run=run_func, init=init_func }