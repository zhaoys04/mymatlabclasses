function f = Setspeed(LM,Vel)
	% Setspeed(Vel) - Set the velocity of stage
	[v3 v4 v5 v6] = LM.entryToBits(0.001984375/Vel/0.05e-3);
	setSpeed = [0 42 v3 v4 v5 v6];
	fwrite(LM.device_obj,setSpeed,'uint8');
	LM.velocity = Vel;
end
