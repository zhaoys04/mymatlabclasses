function f = Get_Temperature(TC)
	if strcmp(TC.gpib_obj.Status,'open')
		TC.gpib_obj.EOSMode = 'write';
		fprintf(TC.gpib_obj,'R1');
		TC.gpib_obj.EOSMode = 'read';
		current_temp = fscanf(TC.gpib_obj);
		TC.Temperature_Read = str2num(current_temp(2:end-1));
	end
	f = 1;
end
