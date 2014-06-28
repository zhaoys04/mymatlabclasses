function f = Getposition(RT)
	% Getposition() - Query the angle of stage 
	f = RT.device_obj.GetPosition_Position(0);
end
