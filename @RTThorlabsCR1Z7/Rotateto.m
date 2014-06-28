function f = Rotateto(RT,degree)
	% Rotateto(degree) - Rotate to the assigned angle 
	RT.device_obj.SetAbsMovePos(0,degree);
	RT.device_obj.MoveAbsolute(0,0);
	f = 1;
end
