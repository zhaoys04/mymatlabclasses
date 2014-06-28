function f = Set_Current(CS, Current_Value) % in Amps
          fprintf(CS.gpib_obj,['LAS:LDI ',num2str(Current_Value),';']);
	  CS.Current_Set = Current_Value;
	  f = 1;
	  return 
end
