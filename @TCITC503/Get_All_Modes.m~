function f = Get_All_Modes(TC)
	TC.gpib_obj.EOSMode = 'write';
	fprintf(TC.gpib_obj,'X');
	TC.gpib_obj.EOSMode = 'read';
	status = fscanf(TC.gpib_obj);
	TC.Control_Mode = str2num(status(strfind(status,'C')+1));
	TC.Heater_Mode = mod(str2num(status(strfind(status,'A')+1)),2); % 0 Manual, 1 Auto
	TC.Gas_Flow_Mode = str2num(status(strfind(status,'A')+1)) > 1; % 0 Manual, 1 Auto
	f = 1;
end
