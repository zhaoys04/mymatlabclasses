function f = Disconnect(LM)
	% Disconnect() - Disconnect the serial connection from stage
	stop(LM.LM_Timer);
	fclose(LM.device_obj);
	f = 1;
end
