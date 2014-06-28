function f = Get_Current_Limit(CS)
	 % Get_Current_Limit(): Query the current limit of current source
         if (~strcmp(CS.gpib_obj.TransferStatus,'idle'))
             display('previous command running while getting current limit');
             f = -1;
             return
         end
	Current_Limit = query(CS.gpib_obj,'LAS:LIM:I?;');
	Current_Limit = Current_Limit(1:end-1);
	Current_Limit = str2num(Current_Limit);
	CS.Current_Limit = Current_Limit;
	f = CS.Current_Limit;
	return
end
