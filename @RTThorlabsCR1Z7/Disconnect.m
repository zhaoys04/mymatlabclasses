function f = Disconnect(RT)
	% Disconnect() - Disconnect the usb connection from stage
	stop(RT.RT_Timer);
	RT.device_obj.delete;
	delete(RT.devicePanelHandle);
	RT.connected = false;
	f = 1;
end
