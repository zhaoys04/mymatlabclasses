function f = Set_Position(TDS,channel,pos)
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
	cmd = sprintf('%s:POS %f',channel,pos);
	fwrite(TDS.gpib_obj,cmd);
	f = 1;
end
