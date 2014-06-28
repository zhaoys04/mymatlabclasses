function f = Disconnect(PM)
	% Disconnect() - Disconnect the connection from power meter
	if PM.ConnectedByUSB
		A = calllib('usbdll','newp_usb_uninit_system');
		disp('All USB Device from Newport is closed.');
		PM.Status = 'closed';
		f = 1;
	else
		fclose(PM.device_obj);
		PM.Status = 'closed';
		f = 1;
	end
end
