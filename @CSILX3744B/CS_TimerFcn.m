function f = CS_TimerFcn(CS,obj,event)
	% CS_TimerFcn(obj,event) - Timer function called by timer
	oldCurrent = CS.Current_Output;
	oldVoltage = CS.Voltage;
	CS.Get_Current;
	CS.Get_Voltage;
	if (oldCurrent~=CS.Current_Output)
		notify(CS.Tonotify,'eCSILX3744BCurrentChanged');
	end
	if (oldVoltage~=CS.Voltage)
		notify(CS.Tonotify,'eCSILX3744BVoltageChanged');
    end
   % display(dec2bin(str2num(query(CS.gpib_obj,'*STB?'))));
   % display(query(CS.gpib_obj,'ERR?'));
end
