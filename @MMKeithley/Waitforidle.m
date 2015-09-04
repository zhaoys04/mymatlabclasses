function f = Waitforidle(MM)
	while MM.busy == true
		pause(1e-3);
	end
	f = 1;
end
