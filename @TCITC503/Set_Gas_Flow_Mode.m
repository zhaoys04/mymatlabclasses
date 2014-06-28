function f = Set_Gas_Flow_Mode(TC,Mode)
	TC.Gas_Flow_Mode = Mode;
	TC.gpib_obj.EOSMode = 'write';
	fprintf(TC.gpib_obj,['$A',num2str(2*Mode+TC.Heater_Mode)]);
	f = 1;
end
