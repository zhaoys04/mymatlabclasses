function f = Disconnect(DC)
	% Disconnect() - Disconnect the gpib connection from DC supply
	try
		fclose(DC.gpib_obj);
           	pause(1);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot close the device.');
		f = 0;
	end
end
