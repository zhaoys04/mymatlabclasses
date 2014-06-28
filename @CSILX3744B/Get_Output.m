function f = Get_Output(CS)
	% Get_Output() - Query the output status of current source
	Output_status = query(CS.gpib_obj,'LAS:OUT?;');
	Output_status =	str2num(Output_status(1:end-1));
	CS.Output = Output_status;
	f = 1;
end
