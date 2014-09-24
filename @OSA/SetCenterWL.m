function f = SetCenterWL(OS,wl)
	cmd = ['centerwl ',num2str(wl),'nm;'];
	fwrite(OS.gpib_obj,cmd);
end
