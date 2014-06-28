function f = Get_Current(CS)
	 % Get_Current(): Query the current of source
         if (~strcmp(CS.gpib_obj.TransferStatus,'idle'))
             display('previous command running while getting current');
             f = -1;
             return
         end
          I = str2num(query(CS.gpib_obj,'LAS:LDI?;'));
	  CS.Current_Output = I;
	  f = I;
	  return 
end
