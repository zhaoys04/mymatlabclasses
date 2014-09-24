function f = Setspeed(LM,Vel)
	% Setspeed(Vel) - Set the velocity of stage
	[v3 v4 v5 v6] = LM.entryToBits(Vel/9.375/LM.resolution);
	setSpeed = [0 42 v3 v4 v5 v6];
	fwrite(LM.device_obj,setSpeed,'uint8');
	LM.velocity = Vel;
end
