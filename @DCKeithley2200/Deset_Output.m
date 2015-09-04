function f = Deset_Output(DC)
	fwrite(DC.gpib_obj,'OUTPUT OFF');
	f = 0;
end
