function f = Moveby(LM,Dis)
	LM.ready = false;
	if LM.currentPosition+Dis<0
		LM.Moveto(0);
		LM.setPosition = 0;
		f = 0;
	else if LM.currentPosition+Dis>150
		LM.Moveto(150);
		LM.setPosition = 150;
		f = 2;
	else
		[p3 p4 p5 p6] = LM.entryToBits(Dis/LM.resolution);
		MovRel = [0 21 p3 p4 p5 p6];
		LM.setPosition = LM.currentPosition + Dis;
		fwrite(LM.device_obj,MovRel,'uint8');
		f = 1;
	end
end
