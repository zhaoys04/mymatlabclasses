function f = SetStartWL(OS,wl)
	cmd = ['startwl ',num2str(wl),'nm;'];
	fwrite(OS.gpib_obj,cmd);
end
