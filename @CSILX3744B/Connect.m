function f = Connect(CS)
	% Connect(): Establish connection to current source through gpib
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
		start(CS.CS_Timer);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot Open the device. Maybe it has been open already');
		f = 0;
	end
end
