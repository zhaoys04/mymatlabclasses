function f = GetStopWL(OS)
	cmd = 'stopwl?;';
	reply = query(OS.gpib_obj,cmd);
	f = str2num(reply);
end
