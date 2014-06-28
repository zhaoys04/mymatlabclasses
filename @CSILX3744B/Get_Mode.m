function f = Get_Mode(CS)
	% Get_Mode() - Query the mode of current source
	laser_mode = query(CS.gpib_obj,'LAS:MODE?;');
	laser_mode = laser_mode(1:end-1);
	switch laser_mode
		case 'ILBW'
			CS.Mode = 1;
			CS.Mode_String = 'Constant Current, Low Bandpass';
			f = 1;
	    		return 
		case 'IHBW'
			CS.Mode = 2;
			CS.Mode_String = 'Constant Current, High Bandpass';
			f = 2;
		        return 
		case 'MDP'
			CS.Mode = 3;
			CS.Mode_String = 'Constant Power';
			f = 3;
		        return 
		case 'MDI'
			CS.Mode = 4;
			CS.Mode_String = 'Constant Power';
			f = 4;
		        return 
		otherwise
			CS.Mode = 0;
			CS.Mode_String = '';
			f = 0;
			return 
	    end
end
