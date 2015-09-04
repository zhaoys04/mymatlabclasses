function f = Disconnect(MM)
	% Disconnect() - Disconnect the gpib connection from MultiMeter
	try
		fclose(MM.gpib_obj);
           	pause(1);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot close the device.');
		f = 0;
	end
end
