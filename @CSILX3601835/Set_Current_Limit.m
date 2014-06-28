function f = Set_Current_Limit(CS, Current_Limit)
	laser_mode = CS.Get_Mode;
	switch laser_mode
		case 1 %CW
			if Current_Limit > 18
				Current_Limit = 18;
			end
		case 2 %HPULSE
			if Current_Limit > 18
				Current_Limit = 18;
			end
		case 3 %PULSE
			if Current_Limit > 40
				Current_Limit = 40;
			end
		case 4 %EXTERNAL TRIGGER
			if Current_Limit > 40
				Current_Limit = 40;
			end
		otherwise
			if Current_Limit > 18
				Current_Limit = 18;
			end
	end
	fwrite(CS.gpib_obj, ['LAS:LIM:I ', num2str(Current_Limit),';']);
	return
end
