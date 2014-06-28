function f = Set_Heater(TC,Power)
	if strcmp(TC.gpib_obj.Status,'open')
	      TC.gpib_obj.EOSMode = 'write';
	      fprintf(TC.gpib_obj,['$O',num2str(Power)]);
	      TC.Heater = Power;
	end
	f = 1;
end
