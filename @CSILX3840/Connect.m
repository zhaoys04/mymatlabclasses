function f = Connect(CS)
	try
		CS.gpib_obj = gpib('ni',0,gpib_address);
	catch
                herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
		f = -1;
		return;
	end
        if strcmp(CS.gpib_obj.Status,'closed')
		fopen(CS.gpib_obj);
           	pause(1);
		f = 1;
		return;
	else
		f = 1;
		return;
	end
	f = -1;
end
