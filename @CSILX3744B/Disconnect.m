function f = Disconnect(CS)
	% Disconnect() - Disconnect the gpib connection from current source
	try
		stop(CS.CS_Timer);
		fclose(CS.gpib_obj);
           	pause(1);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot close the device.');
		f = 0;
	end
end
