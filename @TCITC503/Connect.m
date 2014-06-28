function f = Connect(TC)
	if (TC.gpib_obj == 0)
		TC.gpib_obj = gpib('ni',0,TC.gpib_address);
		TC.gpib_obj.EOIMode = 'off';
		TC.gpib_obj.EOSCharCode = char(13);
	end
	if strcmp(TC.gpib_obj.Status,'closed')
		try
			fopen(TC.gpib_obj);
	           	pause(0.1);
			f = 1;
		catch
			errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
			f = 0;
		end
	end
end
