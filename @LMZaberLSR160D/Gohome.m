function f = Gohome(LM)
	% Gohome() - Go to the home position 
	setHome = [0 1 0 0 0 0];
	fwrite(LM.device_obj,setHome,'uint8');
	f = 1;
end
