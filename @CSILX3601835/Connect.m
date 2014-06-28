function f = Connect(CS)
	% Connect(): connect to current source
	% 	Try to connect to current source through gpib and then start the
	% 	timer function
	%	
	%	hCS_Object.Connect()
	%
	if (CS.gpib_obj == 0)
			try
				CS.gpib_obj = gpib('ni',0,CS.gpib_address);
			catch
              			herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
				return;
			end
	end
	try
		fopen(CS.gpib_obj);
		pause(1);
		fprintf(CS.gpib_obj, '*ESE 1;');
		start(CS.CS_Timer);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot Open the device. Maybe it has been open already');
		f = 0;
	end
end
