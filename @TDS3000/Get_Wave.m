function f = Get_Wave(TDS,channel) %channel: ch1 or ch2
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
	cmd = sprintf('HDR OFF;:WFMPRE:%s:YOFF?;YMULT?;YZERO?;XINCR?;XZERO?;PT_OFF?',channel);
	reply=query(TDS.gpib_obj,cmd);
	values = sscanf(reply, '%f;%f;%f;%f;%f;%i');
%	display(values);
	yoff1 = values(1);
	ymult1 = values(2);
	yzero1 = values(3);
	xincr1 = values(4);
	xzero1 = values(5);
	pt_off1 = values(6);
	cmd = sprintf('DAT:SOU %s;ENC RIB;WID %d;STAR 1;STOP %d',channel,TDS.tds_width,TDS.data_num);
	fwrite(TDS.gpib_obj,cmd);
	fwrite(TDS.gpib_obj,'HDR OFF;:CURVE?');
	reply=fscanf(TDS.gpib_obj,'%c',1);
	reply=fscanf(TDS.gpib_obj,'%c',1);
	length_numbytes = str2num(reply);
	reply=fscanf(TDS.gpib_obj,'%c',length_numbytes);
	length_data = str2num(reply);
	reply=fread(TDS.gpib_obj,length_data);
	wfmbytes = double(reply); 
	reply=fscanf(TDS.gpib_obj,'%c',1);
	bytes=wfmbytes;
	binary = (TDS.binaryconv * bytes)';
	for i=1:length(binary),
		if bitand(bitshift(1,8*TDS.tds_width-1), binary(i))
			binary(i) = -1*(bitcmp(binary(i),8*TDS.tds_width)+1);
		end
	end
	time1 = xzero1 + xincr1.*(1:length(binary)-pt_off1);
	volt1 = yzero1 + ymult1.*(binary-yoff1);
%	msgcmd = sprintf('MESS:BOX 280,20,520,90;SHOW "%s";STATE %i', sprintf(''), 0);
%	fwrite(TDS.gpib_obj,msgcmd);
	f.T = time1;
	f.V = volt1;
end
