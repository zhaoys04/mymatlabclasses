function f = Disconnect(OS)
	% Disconnect(): Disconnect the gpib connection of OSA
	try
		fclose(OS.gpib_obj);
           	pause(1);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot close the device.');
		f = 0;
	end
end
