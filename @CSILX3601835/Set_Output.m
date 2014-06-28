function f = Set_Output(CS)
        if CS.Output == 0
		fwrite(CS.gpib_obj, 'LAS:OUT 1;');
		pause(0.1);
		CS.Get_Output;
		f = 1;
	end
end
