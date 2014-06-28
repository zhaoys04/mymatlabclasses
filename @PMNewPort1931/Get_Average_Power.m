function f = Get_Average_Power(PM)
	% Get_Average_Power() - Query the average power of power meter
	if PM.ConnectedByUSB
		PM.SendCommandviaUSB('PM:DS:CL');
		PM.SendCommandviaUSB('PM:DS:EN 1');
		pause(PM.Average_Time);
		PM.SendCommandviaUSB('PM:DS:EN 0');
		PM.SendCommandviaUSB('PM:STAT:MEAN?');
		power = PM.GetResponseviaUSB;
		PM.Power_Average = str2num(power);
		f = 1;
	else
		fprintf(PM.device_obj, 'PM:DS:CL');
		fprintf(PM.device_obj, 'PM:DS:EN 1');
		pause(PM.Average_Time);
		fprintf(PM.device_obj, 'PM:DS:EN 0');
		power = query(PM.device_obj,'PM:STAT:MEAN?');
		PM.Power_Average = str2num(power);
		f = 1;
	end
end
