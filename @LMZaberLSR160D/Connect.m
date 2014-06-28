function f = Connect(LM)
	% Connect() - Establish connection to stage through serial
	if LM.device_obj == 0
		LM.device_obj = serial(LM.serialPort);
	end
	try
		fopen(LM.device_obj);
		SetMode = [0 40 1 0 0 0];
		fwrite(LM.device_obj,SetMode,'uint8');
		start(LM.LM_Timer);
		f = 1;
	catch
	end
end
