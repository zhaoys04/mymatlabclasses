function f = Update(PM)
	set(PM.handles.hPower_Read_Text,'String',num2str(PM.Power_Read));
	set(PM.handles.hWavelength_Edit,'String',num2str(PM.Wavelength));
	set(PM.handles.hAverage_Time_Edit,'String',num2str(PM.Average_Time));
	f = 1;
end
