function f = Checkready(LM)
	% Checkready() - Check whether the stage is ready for next move
	if abs(LM.currentPosition-LM.setPosition)<=0.002
		LM.ready = true;
	else 
		LM.ready = false;
	end
end
