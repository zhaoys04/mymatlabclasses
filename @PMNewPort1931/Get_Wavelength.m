function f = Get_Wavelength(PM)
	% Get_Wavelength() - Query the wavelength the power meter is measuring 
	if PM.ConnectedByUSB
		PM.SendCommandviaUSB('PM:Lambda?');
		wavelength = PM.GetResponseviaUSB;
		PM.Wavelength = str2num(wavelength);
		f = 1;
	else
		wavelength = query(PM.device_obj,'PM:Lambda?');
		PM.Wavelength = str2num(wavelength);
		f = 1;
	end
end
