function f = Get_Voltage(CS)
	% Get_Voltage() - Query the voltage of source now
	V = str2double(query(CS.gpib_obj,'LAS:LDV?;'));
	CS.Voltage = V;
	f = V;
	return
end
