function f = Disconnect(TDS)
	try
		fclose(TDS.gpib_obj);
           	pause(1);
		f = 1;
	catch
       		herrordlg = errordlg('Cannot close the device.');
		f = 0;
	end
end
