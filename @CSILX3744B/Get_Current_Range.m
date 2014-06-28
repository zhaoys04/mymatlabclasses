function f = Get_Current_Range(CS)
	% Get_Current_Range() - Query the limit of current
	Current_Range = query(CS.gpib_obj,'LAS:RAN?;');
	Current_Range = Current_Range(1:end-1);
	Current_Range = str2num(Current_Range);
	if (Current_Range<3)
		CS.Current_Range = 2000;
		f = 2000;
	else
		CS.Current_Range = 4000;
		f = 4000;
    	end
	return
end
