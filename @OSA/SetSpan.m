function f = SetSpan(OS,span)
	cmd = ['sp ',num2str(span),'nm;'];
	fwrite(OS.gpib_obj,cmd);
end
