function f = Get_Spectrum(OS)
	cmd = 'TDF P;';
	fwrite(OS.gpib_obj,cmd);
	cmd = 'TRDEF TRA?;';

	reply = query(OS.gpib_obj,cmd);
	num_points = str2num(reply);

	cmd = 'startwl?;';
	reply = query(OS.gpib_obj,cmd);
	start_wavelength = str2num(reply);

	cmd = 'stopwl?;';
	reply = query(OS.gpib_obj,cmd);
	stop_wavelength = str2num(reply);

	cmd = 'TRA?;';
	fwrite(OS.gpib_obj,cmd);
	[reply,count] = fscanf(OS.gpib_obj);
	amp = ['[',reply];
	while count == 512
		[reply,count]=fscanf(OS.gpib_obj);
		if (count==0) break; end
		amp=[amp,reply];
	end

	amp=[amp,']'];

	OS.wavelength = linspace(start_wavelength, stop_wavelength, num_points);
	OS.amplitude = str2num(amp);
end
