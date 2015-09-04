function f = Connect(MM)
	% Connect(): Establish connection to MultiMeter through gpib
	if (MM.gpib_obj == 0)
			try
				MM.gpib_obj = gpib('ni',0,MM.gpib_address);
			catch
              			herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
				return;
			end
	end
	try
		fopen(MM.gpib_obj);
           	pause(1);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot Open the device. Maybe it has been open already');
		f = 0;
	end
end
