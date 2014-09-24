function f = GetSpan(OS)
	cmd = 'sp?;';
	reply = query(OS.gpib_obj,cmd);
	f = str2num(reply);
end
