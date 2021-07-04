--[[
virtual Slider - Telemetryscript

IMPORTANT: 
Do not use lua scripts for critical functions that could result in a crash if misbehaving. 
Use a fallback mixer line if applicable. See https://doc.open-tx.org/opentx-2-2-lua-reference-guide/part_i_-_script_type_overview/mix for how to do that.
Scripts need SD cards!

What does it do:
provides a basic GUI for monocrome LCD Radios to adjust vSlider values 

How does it work:
You can adjust the values of the 6 virtual sliders with the menue navigation buttons of the radio through this GUI.

How to use:
- see instructions in the affiliated Mixscript
- for navigation on the Jumper T-Lite use short clicks on Sys, Mdl, Ent and Rtn, for ajustment use up and dn buttons 
- ajust stepsizes for each vSlider as you whish (stepsize of 1024 means you basically have a 3 position switch; 512 means 5 posistions etc.)
- after that you can start manipulating the values of each vSlider. Each vSlider ranges from -1024 to 1024 (which means -100% to +100%)
All values and stepsizes are stored persistently.
(callouts do not use custom sounds right now, therefor callout "0" means ajusting a stepsize whis is not a good idea inflight, 1 means ajusting vSlider A, 2 = B, ...)
--]]

local function run_func(event)
	lcd.clear()
	lcd.drawText(10,03,"A:")
	lcd.drawText(10,13,"B:")
	lcd.drawText(10,23,"C:")
	lcd.drawText(10,33,"D:")
	lcd.drawText(10,43,"E:")
	lcd.drawText(10,53,"F:")
	lcd.drawLine(46,0,46,63,SOLID,0)
	lcd.drawLine(98,0,98,63,SOLID,0)
	lcd.drawText(50,4,"<<<<<<<<<")
	lcd.drawText(52,12,"vSliders")
	lcd.drawText(56,20,"+-1024")
	lcd.drawText(50,38,">>>>>>>>>")
	lcd.drawText(50,46,"stepsize")
	lcd.drawText(56,54,"1 .. 1024")
		
	--[[
	NAVIGATION (play sounds if item changes)
	--]]
	if event == EVT_ENTER_BREAK and vSld_type == 0 then
		vSld_selected = vSld_selected - 1
		if vSld_selected < 0 then
			vSld_selected = 0
		end
		playNumber(vSld_selected+1,0)
	elseif event == EVT_EXIT_BREAK and vSld_type == 0 then
		vSld_selected = vSld_selected + 1
		if vSld_selected > 5 then
			vSld_selected = 5
		end
		playNumber(vSld_selected+1,0)
	elseif event == 100 then
		vSld_type = vSld_type + 1
		if vSld_type > 1 then
			vSld_type = 1
		end
		--[[
		play sound "ajusting stepsize"
		--]]
		playNumber(0,0)
	elseif event == 101 then
		vSld_type = vSld_type - 1
		if vSld_type < 0 then
			vSld_type = 0
		end
		playNumber(vSld_selected+1,0)
	end
	--[[
	AJUSTMENT
	--]]
	if not (event == 0) then
		vSld_scalerunning = 0
	end
	if vSld_type == 0 then
		if event == 99 then
			if vSld_selected == 0 then
				vSld_propA = vSld_propA + vSld_adjustA
			end
			if vSld_selected == 1 then
				vSld_propB = vSld_propB + vSld_adjustB
			end
			if vSld_selected == 2 then
				vSld_propC = vSld_propC + vSld_adjustC
			end
			if vSld_selected == 3 then
				vSld_propD = vSld_propD + vSld_adjustD
			end
			if vSld_selected == 4 then
				vSld_propE = vSld_propE + vSld_adjustE
			end
			if vSld_selected == 5 then
				vSld_propF = vSld_propF + vSld_adjustF
			end
		elseif event == 98 then
			if vSld_selected == 0 then
				vSld_propA = vSld_propA - vSld_adjustA
			end
			if vSld_selected == 1 then
				vSld_propB = vSld_propB - vSld_adjustB
			end
			if vSld_selected == 2 then
				vSld_propC = vSld_propC - vSld_adjustC
			end
			if vSld_selected == 3 then
				vSld_propD = vSld_propD - vSld_adjustD
			end
			if vSld_selected == 4 then
				vSld_propE = vSld_propE - vSld_adjustE
			end
			if vSld_selected == 5 then
				vSld_propF = vSld_propF - vSld_adjustF
			end
		end
	elseif vSld_type == 1 then
		if event == 99 or vSld_scalerunning > 0 then
			if vSld_selected == 0 or vSld_scalerunning == 1 then
				vSld_adjustA = vSld_adjustA + 1
			end
			if vSld_selected == 1 or vSld_scalerunning == 2 then
				vSld_adjustB = vSld_adjustB + 1
			end
			if vSld_selected == 2 or vSld_scalerunning == 3 then
				vSld_adjustC = vSld_adjustC + 1
			end
			if vSld_selected == 3 or vSld_scalerunning == 4 then
				vSld_adjustD = vSld_adjustD + 1
			end
			if vSld_selected == 4 or vSld_scalerunning == 5 then
				vSld_adjustE = vSld_adjustE + 1
			end
			if vSld_selected == 5 or vSld_scalerunning == 6 then
				vSld_adjustF = vSld_adjustF + 1
			end
		elseif event == 98 or vSld_scalerunning < 0 then
			if vSld_selected == 0 or vSld_scalerunning == -1 then
				vSld_adjustA = vSld_adjustA - 1
			end
			if vSld_selected == 1 or vSld_scalerunning == -2 then
				vSld_adjustB = vSld_adjustB - 1
			end
			if vSld_selected == 2 or vSld_scalerunning == -3 then
				vSld_adjustC = vSld_adjustC - 1
			end
			if vSld_selected == 3 or vSld_scalerunning == -4 then
				vSld_adjustD = vSld_adjustD - 1
			end
			if vSld_selected == 4 or vSld_scalerunning == -5 then
				vSld_adjustE = vSld_adjustE - 1
			end
			if vSld_selected == 5 or vSld_scalerunning == -6 then
				vSld_adjustF = vSld_adjustF - 1
			end
		end
		if event == 131 then
			vSld_scalerunning = vSld_selected + 1
		end
		if event == 130 then
			vSld_scalerunning = -vSld_selected - 1
		end
	end
	
	--[[
	MINMAX CHECK
	--]]
	if vSld_propA > 1024 then
		vSld_propA = 1024
	end
	if vSld_propA < -1024 then
		vSld_propA = -1024
	end
	if vSld_propB > 1024 then
		vSld_propB = 1024
	end
	if vSld_propB < -1024 then
		vSld_propB = -1024
	end
	if vSld_propC > 1024 then
		vSld_propC = 1024
	end
	if vSld_propC < -1024 then
		vSld_propC = -1024
	end
	if vSld_propD > 1024 then
		vSld_propD = 1024
	end
	if vSld_propD < -1024 then
		vSld_propD = -1024
	end
	if vSld_propE > 1024 then
		vSld_propE = 1024
	end
	if vSld_propE < -1024 then
		vSld_propE = -1024
	end
	if vSld_propF > 1024 then
		vSld_propF = 1024
	end
	if vSld_propF < -1024 then
		vSld_propF = -1024
	end
	if vSld_adjustA > 1024 then
		vSld_adjustA = 1024
	end
	if vSld_adjustA < 1 then
		vSld_adjustA = 1
	end
	if vSld_adjustB > 1024 then
		vSld_adjustB = 1024
	end
	if vSld_adjustB < 1 then
		vSld_adjustB = 1
	end
	if vSld_adjustC > 1024 then
		vSld_adjustC = 1024
	end
	if vSld_adjustC < 1 then
		vSld_adjustC = 1
	end
	if vSld_adjustD > 1024 then
		vSld_adjustD = 1024
	end
	if vSld_adjustD < 1 then
		vSld_adjustD = 1
	end
	if vSld_adjustE > 1024 then
		vSld_adjustE = 1024
	end
	if vSld_adjustE < 1 then
		vSld_adjustE = 1
	end
	if vSld_adjustF > 1024 then
		vSld_adjustF = 1024
	end
	if vSld_adjustF < 1 then
		vSld_adjustF = 1
	end
	
	--[[
	PRINT ALL to lcd
	--]]
	if vSld_selected == 0 and vSld_type == 0 then
		lcd.drawText(20,03,vSld_propA, INVERS)
	else
		lcd.drawText(20,03,vSld_propA)
	end
	if vSld_selected == 1 and vSld_type == 0 then
		lcd.drawText(20,13,vSld_propB, INVERS)
	else
		lcd.drawText(20,13,vSld_propB)
	end
	if vSld_selected == 2 and vSld_type == 0 then
		lcd.drawText(20,23,vSld_propC, INVERS)
	else
		lcd.drawText(20,23,vSld_propC)
	end
	if vSld_selected == 3 and vSld_type == 0 then
		lcd.drawText(20,33,vSld_propD, INVERS)
	else
		lcd.drawText(20,33,vSld_propD)
	end
	if vSld_selected == 4 and vSld_type == 0 then
		lcd.drawText(20,43,vSld_propE, INVERS)
	else
		lcd.drawText(20,43,vSld_propE)
	end
	if vSld_selected == 5 and vSld_type == 0 then
		lcd.drawText(20,53,vSld_propF, INVERS)
	else
		lcd.drawText(20,53,vSld_propF)
	end
	if vSld_selected == 0 and vSld_type == 1 then
		lcd.drawText(100,03,vSld_adjustA, INVERS)
	else
		lcd.drawText(100,03,vSld_adjustA)
	end
	if vSld_selected == 1 and vSld_type == 1 then
		lcd.drawText(100,13,vSld_adjustB, INVERS)
	else
		lcd.drawText(100,13,vSld_adjustB)
	end
	if vSld_selected == 2 and vSld_type == 1 then
		lcd.drawText(100,23,vSld_adjustC, INVERS)
	else
		lcd.drawText(100,23,vSld_adjustC)
	end
	if vSld_selected == 3 and vSld_type == 1 then
		lcd.drawText(100,33,vSld_adjustD, INVERS)
	else
		lcd.drawText(100,33,vSld_adjustD)
	end
	if vSld_selected == 4 and vSld_type == 1 then
		lcd.drawText(100,43,vSld_adjustE, INVERS)
	else
		lcd.drawText(100,43,vSld_adjustE)
	end
	if vSld_selected == 5 and vSld_type == 1 then
		lcd.drawText(100,53,vSld_adjustF, INVERS)
	else
		lcd.drawText(100,53,vSld_adjustF)
	end
	
	--[[
	SAVE IF CHANGED
	--]]
	if not (event == 0) then
		local s = vSld_selected .. "\n" .. vSld_type .. "\n" .. vSld_scalerunning .. "\n" .. vSld_propA .. "\n" .. vSld_propB .. "\n" .. vSld_propC.. "\n" .. vSld_propD .. "\n" .. vSld_propE .. "\n" .. vSld_propF .. "\n" .. vSld_adjustA .. "\n" ..vSld_adjustB .. "\n" .. vSld_adjustC .. "\n" .. vSld_adjustD .. "\n" .. vSld_adjustE .. "\n" .. vSld_adjustF
		local settingsfile = io.open("/SCRIPTS/"..vSld_model_name.."_vSld.data", "w")
		io.write(settingsfile, s)
		io.close(settingsfile)
	end
end

return { run=run_func }