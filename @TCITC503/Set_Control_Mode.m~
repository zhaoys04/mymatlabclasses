function f = Set_Control_Mode(TC,Mode)
	TC.Control_Mode = Mode;
	TC.gpib_obj.EOSMode = 'write';
	fprintf(TC.gpib_obj,['$C',num2str(Mode)]);
	f = 1;
end
