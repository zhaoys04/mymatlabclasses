function f = Moveby(LM,distance)
	% Moveby(distance) - Move by a distance set in mm 
	LM.device_obj.SetRelMoveDist(0,distance);
	LM.device_obj.MoveRelative(0,0);
	f = 1;
end
