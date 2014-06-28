function f = Get_Duty_Cycle(CS)
	 % Get_Duty_Cycle(): Query the duty cycle in QCW of current source
         if (~strcmp(CS.gpib_obj.TransferStatus,'idle'))
             display('previous command running while getting duty cycle');
             f = -1;
             return
         end
          dc = str2num(query(CS.gpib_obj,'LAS:DC?;'));
	  CS.QCW.duty = dc;
	  f = dc;
	  return 
end
