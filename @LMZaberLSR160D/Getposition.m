function f = Getposition(LM)
	% Getposition() - Query the position of stage 
	AbsPos = [0 60 0 0 0 0];
	fwrite(LM.device_obj,AbsPos,'uint8');
	Pos = fread(LM.device_obj,6,'uint8');
	Pos = Pos(end)*256^3+Pos(end-1)*256^2+Pos(end-2)*256+Pos(end-3);
	f = Pos*LM.resolution;
end
