function f = Get_Freq(CS)
	 % Get_Freq(): Query frequency in QCW of current source
         if (~strcmp(CS.gpib_obj.TransferStatus,'idle'))
             display('previous command running while getting frequency');
             f = -1;
             return
         end
          freq = str2num(query(CS.gpib_obj,'LAS:F?;'));
	  CS.QCW.freq = freq;
	  f = freq;
	  return 
end
