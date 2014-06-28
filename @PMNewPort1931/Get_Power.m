function f = Get_Power(PM)
	% Get_Power() - Query the instant power reading of power meter 
	if PM.ConnectedByUSB
		PM.SendCommandviaUSB('PM:P?');
		power = PM.GetResponseviaUSB;
		PM.Power_Read = str2num(power);
		f = 1;
	else
		power = query(PM.device_obj,'PM:P?');
		PM.Power_Read = str2num(power);
		f = 1;
	end
end
