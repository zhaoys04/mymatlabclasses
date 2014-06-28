function f = Get_Voltage(CS)
         if (~strcmp(CS.gpib_obj.TransferStatus,'idle'))
             display('previous command running while getting voltage');
             f = -1;
             return
         end
          V = str2double(query(CS.gpib_obj,'LAS:LDV?;'));
	  CS.Voltage = V;
	  f = V;
	  return
end
