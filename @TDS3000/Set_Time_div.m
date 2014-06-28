function f = Set_Time_div(TDS,div)
	d = abs(div-TDS.TIMEDIVS);
	[m ind] = min(d);
	div = TDS.TIMEDIVS(ind);
	fwrite(TDS.gpib_obj,['HOR:MAI:SCA ',num2str(div)]);
	f = 1;
end
