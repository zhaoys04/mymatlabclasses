function f = Set_Mode(CS, Mode)
	switch Mode
		case 1  %Constant I, Low bandpass
			CS.Mode = 1;
			CS.Mode_String = 'Constant Current, Low Bandpass';
			fwrite(CS.gpib_obj,'LAS:MODE:ILBW;');
		case 2  %Constant I, High bandpass
			CS.Mode = 2;
			CS.Mode_String = 'Constant Current, High Bandpass';
			fwrite(CS.gpib_obj,'LAS:MODE:IHBW;');
		case 3  %Constant P
			CS.Mode = 3;
			CS.Mode_String = 'Constant Power';
			fwrite(CS.gpib_obj,'LAS:MODE:MDP;');
		otherwise
	end
	f = 1;
	return 
end
