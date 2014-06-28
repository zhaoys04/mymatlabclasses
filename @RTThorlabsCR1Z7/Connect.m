function f = Connect(RT)
	% Connect() - Establish connection to stage through usb
	RT.devicePanelHandle = figure('Visible','off');
	RT.device_obj = actxcontrol('MGMOTOR.MGMotorCtrl.1',[0 0 1 1],RT.devicePanelHandle); 
	RT.device_obj.StartCtrl;
	set(RT.device_obj,'HWSerialNum',RT.serialNum);
	pause(0.1);
	RT.device_obj.Identify;
	RT.device_obj.LoadParamSet(RT.profileFile);
	pause(5);
	RT.connected = true;
	start(RT.RT_Timer);
end
