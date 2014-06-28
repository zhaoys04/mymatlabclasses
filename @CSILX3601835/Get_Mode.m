function f = Get_Mode(CS)
	 % Get_Mode(): Query the mode of current source, 1:CW 2:HPULSE 3:PULSE 4:TRIG
         if (~strcmp(CS.gpib_obj.TransferStatus,'idle'))
             display('previous command running while getting mode');
             f = -1;
             return
         end
	laser_mode = query(CS.gpib_obj,'LAS:MODE?;');
	laser_mode = laser_mode(1:end-1);
	switch laser_mode
		case 'CW'
			CS.Mode = 1;
			CS.Mode_String = 'CW';
			f = 1;
	    		return 
		case 'HPULSE'
			CS.Mode = 2;
			CS.Mode_String = 'Hard Pulse';
			f = 2;
		        return 
		case 'PULSE'
			CS.Mode = 3;
			CS.Mode_String = 'QCW-Pulse';
			f = 3;
		        return 
		case 'TRIG'
			CS.Mode = 4;
			CS.Mode_String = 'QCW-External Trigger';
			f = 4;
		        return 
		otherwise
			CS.Mode = 0;
			CS.Mode_String = '';
			f = 0;
			return 
	    end
end
