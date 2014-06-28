function f = Set_Temperature(TC,Temp)
    if strcmp(TC.gpib_obj.Status,'open')
	      TC.gpib_obj.EOSMode = 'write';
	      fprintf(TC.gpib_obj,['$T',num2str(Temp)]);
	      TC.Temperature_Set = Temp;
    end
end
