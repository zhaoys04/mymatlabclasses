function f = Disconnect(CS)
	try
		CS.gpib_obj.Status;
	catch
                herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
		f = -1;
		return;
	end
        if strcmp(CS.gpib_obj.Status,'open')
		fclose(CS.gpib_obj);
		f = 1;
		return;
	else
		f = 1;
		return;
	end
	f = -1;
end
