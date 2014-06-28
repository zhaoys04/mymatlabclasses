function f = Disconnect(LM)
	% Disconnect() - Disconnect the usb connection from attenuator
	stop(LM.LM_Timer);
	LM.connected = false;
	LM.device_obj.delete;
	delete(LM.devicePanelHandle);
	f = 1;
end
