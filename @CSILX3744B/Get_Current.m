function f = Get_Current(CS)
	% Get_Current() - Query the current of source now in mA
	I = str2double(query(CS.gpib_obj,'LAS:LDI?;'));
	CS.Current_Output = I;
	f = I;
	return 
end
