function f = GetStartWL(OS)
	cmd = 'startwl?;';
	reply = query(OS.gpib_obj,cmd);
	f = str2num(reply);
end
