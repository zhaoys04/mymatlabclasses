function f = SendCommandviaSerial(PM,Command)
	fprintf(PM.device_obj,Command);
end
