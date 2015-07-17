function f = WaitforAcqStop(TDS)
	state = query(TDS.gpib_obj,'ACQUIRE:STATE?');
	while str2num(state)
		pause(1);
		state = query(TDS.gpib_obj,'ACQUIRE:STATE?');
	end
	f = 1;
end

