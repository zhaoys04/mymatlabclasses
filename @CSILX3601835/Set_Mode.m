function f = Set_Mode(CS, Mode)
	switch Mode
		case 1  % CW
			fwrite(CS.gpib_obj,'LAS:MODE:CW;');
		case 2  % HPULSE
			fwrite(CS.gpib_obj,'LAS:MODE:HPULSE;');
		case 3  %PULSE
			fwrite(CS.gpib_obj,'LAS:MODE:PULSE;');
		case 4  %External Trigger
			fwrite(CS.gpib_obj,'LAS:MODE:TRIG;');
		otherwise
	end
	f = 1;
	return 
end
