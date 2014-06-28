function f = Deset_Output(CS)
	% Deset_Output(): Disable the output of current source
	%
        if CS.Output == 1
		fwrite(CS.gpib_obj, 'LAS:OUT 0;');
		pause(0.1);
		CS.Get_Output;
		f = 1;
	end
end
