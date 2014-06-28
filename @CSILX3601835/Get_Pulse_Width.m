function f = Get_Pulse_Width(CS)
         if (~strcmp(CS.gpib_obj.TransferStatus,'idle'))
             display('previous command running while getting pulse width');
             f = -1;
             return
         end

          pw = str2num(query(CS.gpib_obj,'LAS:PW?;'));
	  CS.QCW.pw = pw;
	  f = pw;
	  return 
end
