function f = Connect(TDS)
	if (TDS.gpib_obj == 0)
			try
				TDS.gpib_obj = gpib('ni',0,TDS.gpib_address,'InputBufferSize',90000);
			catch
              			herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
				return;
			end
	end
	try
%	        set(TDS.TDS_Timer, 'ExecutionMode','fixedspacing','Period',1,'TimerFcn',@TDS.TDS_TimerFcn);
		fopen(TDS.gpib_obj);
	       	pause(1);
%		start(TDS.TDS_Timer);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot Open the device. Maybe it has been open already');
		f = 0;
	end
end
