function f = GetCenterWL(OS)
	cmd = 'centerwl?;';
	reply = query(OS.gpib_obj,cmd);
	f = str2num(reply);
end
