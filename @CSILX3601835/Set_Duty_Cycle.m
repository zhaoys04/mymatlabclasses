function f = Set_Duty_Cycle(CS, dc) % in percentage
          fprintf(CS.gpib_obj,['LAS:DC ',num2str(dc),';']);
	  f = 1;
	  return 
end
