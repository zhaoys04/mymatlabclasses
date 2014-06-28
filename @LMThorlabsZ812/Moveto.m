function f = Moveto(LM,position)
	% Moveto(position) - Move to the assigned position in mm 
	LM.device_obj.SetAbsMovePos(0,position);
	LM.device_obj.MoveAbsolute(0,0);
	f = 1;
end
