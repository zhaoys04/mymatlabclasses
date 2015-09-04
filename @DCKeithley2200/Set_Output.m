function f = Set_Output(DC)
	fwrite(DC.gpib_obj,'OUTPUT ON');
	f = 0;
end
