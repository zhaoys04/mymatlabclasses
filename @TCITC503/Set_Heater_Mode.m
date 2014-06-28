function f = Set_Heater_Mode(TC,Mode)
	TC.Heater_Mode = Mode;
	TC.gpib_obj.EOSMode = 'write';
	fprintf(TC.gpib_obj,['$A',num2str(2*TC.Gas_Flow_Mode+Mode)]);
	f = 1;
end
