function f = Connect(DC)
	% Connect(): Establish connection to DC supply through gpib
	if (DC.gpib_obj == 0)
			try
				DC.gpib_obj = gpib('ni',0,DC.gpib_address);
			catch
              			herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
				return;
			end
	end
	try
		fopen(DC.gpib_obj);
           	pause(1);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot Open the device. Maybe it has been open already');
		f = 0;
	end
end
