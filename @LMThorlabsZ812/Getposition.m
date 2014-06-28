function f = Getposition(LM)
	% Getposition() - Query the position of attenuator 
	f = LM.device_obj.GetPosition_Position(0);
end
