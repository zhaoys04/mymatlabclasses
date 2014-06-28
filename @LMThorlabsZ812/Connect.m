function f = Connect(LM)
	% Connect() - Establish connection to attenuator through usb
	LM.devicePanelHandle = figure('Visible','off');
	LM.device_obj = actxcontrol('MGMOTOR.MGMotorCtrl.1',[0 0 1 1],LM.devicePanelHandle); 
	LM.device_obj.StartCtrl;
	set(LM.device_obj,'HWSerialNum',LM.serialNum);
	pause(0.1);
	LM.device_obj.Identify;
	LM.device_obj.LoadParamSet(LM.profileFile);
	pause(0.1);
	LM.connected = true;
	start(LM.LM_Timer);
end
