function f = Set_Pulse_Width(CS,pw) % in secs
	qcw_mode = CS.Get_QCW_Mode;
	if qcw_mode == 0  % constant duty cycle
		fprintf(CS.gpib_obj,['LAS:PWP ',num2str(pw),';']);
	else              % constant frequency
		fprintf(CS.gpib_obj,['LAS:PWF ',num2str(pw),';']);
	end
	f = 1;
end
