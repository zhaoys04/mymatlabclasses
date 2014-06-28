function f = CS_TimerFcn(CS,obj,event)
	oldCurrent = CS.Current_Output;
	oldVoltage = CS.Voltage;
	oldMode = CS.Mode;
	oldCurrentLimit = CS.Current_Limit;
  %  display('get current');
	CS.Get_Current;
%    display('get voltage');
	CS.Get_Voltage;
 %   display('get mode');
	CS.Get_Mode;
  %  display('get current limit');
	CS.Get_Current_Limit;
	if (oldCurrent~=CS.Current_Output)
		notify(CS.Tonotify,'eCSILX3601835CurrentChanged');
	end
	if (oldVoltage~=CS.Voltage)
		notify(CS.Tonotify,'eCSILX3601835VoltageChanged');
	end
	if (oldMode~=CS.Mode)
		notify(CS.Tonotify,'eCSILX3601835ModeChanged');
	end
	if (oldCurrentLimit~=CS.Current_Limit)
		notify(CS.Tonotify,'eCSILX3601835CurrentLimitChanged');
	end
	if (CS.Mode == 2 || CS.Mode == 3)
		oldPW = CS.QCW.pw;
		oldFreq = CS.QCW.freq;
		oldDC = CS.QCW.duty;
%        display('get pulse width');
		CS.Get_Pulse_Width;
 %       display('get frequency');
		CS.Get_Freq;
  %      display('get duty cycle');
		CS.Get_Duty_Cycle;
		if (oldPW~=CS.QCW.pw)
			notify(CS.Tonotify,'eCSILX3601835PulseWidthChanged');
		end
		if (oldFreq~=CS.QCW.freq)
			notify(CS.Tonotify,'eCSILX3601835FreqChanged');
		end
		if (oldDC~=CS.QCW.duty)
			notify(CS.Tonotify,'eCSILX3601835DutyCycleChanged');
		end
    end
%     display(dec2bin(str2num(query(CS.gpib_obj,'*STB?'))));
%     display(query(CS.gpib_obj,'ERR?'));
    % CS.gpib_obj.Timeout = 10;
    %  fwrite(CS.gpib_obj,'*ESE 1');
     %  fwrite(CS.gpib_obj,'*ESE?');
    %  fwrite(CS.gpib_obj,'*STB?');
     %display(fscanf(CS.gpib_obj,'%s'));
    %  display(fscanf(CS.gpib_obj,'%s'));      
end
