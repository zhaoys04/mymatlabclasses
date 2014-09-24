function f = Reset(LM)
	% Reset() - Stage reset 
	AbsPos = [0 0 0 0 0 0];
	fwrite(LM.device_obj,AbsPos,'uint8');
end
