function f = Rotateby(RT,degree)
	% Rotateby(degree) - Rotate by an angle  
	RT.device_obj.SetRelMoveDist(0,degree);
	RT.device_obj.MoveRelative(0,0);
	f = 1;
end
