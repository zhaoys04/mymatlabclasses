function f = Set_Current_Range(CS, Current_Range)
	if (Current_Range <= 2000)
		fwrite(CS.gpib_obj,'LAS:RAN 1;');
		f = 1;
	else
		fwrite(CS.gpib_obj,'LAS:RAN 3;');
		f = 3;
	end
	return
end
