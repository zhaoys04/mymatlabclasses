function f = TC_TimerFcn(TC,obj,event)
	oldTemperature = TC.Temperature_Read;
	oldHeaterMode = TC.Heater_Mode;
	oldStableState = TC.Stable;
	TC.Get_Temperature;
	TC.Get_All_Modes;
	TC.Temperature_Stable;
	if oldTemperature~=TC.Temperature_Read
		notify(TC.Tonotify,'eTCITC503TemperatureChanged');
	end
	if oldHeaterMode~=TC.Heater_Mode
		notify(TC.Tonotify,'eTCITC503HeaterModeChanged');
	end
	if oldStableState~=TC.Stable
		notify(TC.Tonotify,'eTCITC503StableStateChanged');
	end
end
