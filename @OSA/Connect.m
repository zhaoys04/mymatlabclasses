function f = Connect(OS)
	% Connect(): connect to OSA
	% 	Try to connect to OSA through gpib 	
	%	hOS_Object.Connect()
	%
	if (OS.gpib_obj == 0)
			try
				OS.gpib_obj = gpib('ni',0,OS.gpib_address);
			catch
              			herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
				return;
			end
	end
	try
		fopen(OS.gpib_obj);
		pause(1);
		fprintf(OS.gpib_obj, '*ESE 1;');
		start(OS.OS_Timer);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot Open the device. Maybe it has been open already');
		f = 0;
	end
end
