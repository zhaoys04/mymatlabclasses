function f = Set_CH_Scale(TDS,channel,div)
	if (~isstr(channel))
		display('Channel is invalid');
		f = -1;
		return
	end
	channel = upper(channel);
	if (~strcmp(channel,'CH1') && ~strcmp(channel,'CH2'))
		display('Channel is not supported');
		f = -1;
		return
	end
	if (div < 1e-3)
		div = 1e-3;
	else if div > 10
		div = 10;
	end
	cmd = sprintf('%s:SCALE %f',channel,div);
	fwrite(TDS.gpib_obj,cmd);
	f = 1;
end
