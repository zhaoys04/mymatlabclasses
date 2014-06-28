function f = Auto_Vertical_Tune(TDS,channel)
	channel = upper(channel);
	f = TDS.Get_Wave(channel);
	pos = str2num(query(TDS.gpib_obj,[channel,':POS?']));
	div = str2num(query(TDS.gpib_obj,[channel,':SCA?']));
	if (pos + min(f.V)/div < -3) || (pos + max(f.V)/div > 3)
		ptop = max(f.V)-min(f.V);
		scaletoset = ceil(2*ptop*1000)/1000/8;
		TDS.Set_CH_Scale(channel,scaletoset);
		div = str2num(query(TDS.gpib_obj,[channel,':SCA?']));
		mid = (max(f.V) + min(f.V))/2;
		TDS.Set_Position(channel,-mid/div);
		pause(1);
		f = TDS.Get_Wave(channel);
	end
end
