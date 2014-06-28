function f = Moveto(LM,Pos)
	LM.ready = false;
	[p3 p4 p5 p6] = LM.entryToBits(Pos/0.001984375);
	MovAbs = [0 20 p3 p4 p5 p6];
	fwrite(LM.device_obj,MovAbs,'uint8');
	LM.setPosition = Pos;
	f = 1;
end
