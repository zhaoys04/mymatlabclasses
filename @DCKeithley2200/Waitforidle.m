function f = Waitforidle(DC)
	while DC.busy == true
		pause(1e-3);
	end
	f = 1;
end
