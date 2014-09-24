function f = SetStopWL(OS,wl)
	cmd = ['stopwl ',num2str(wl),'nm;'];
	fwrite(OS.gpib_obj,cmd);
end
