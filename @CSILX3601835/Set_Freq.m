function f = Set_Freq(CS, freq) % in Hz
          fprintf(CS.gpib_obj,['LAS:F ',num2str(freq),';']);
	  f = 1;
	  return 
end
