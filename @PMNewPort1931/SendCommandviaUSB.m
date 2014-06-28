function f = SendCommandviaUSB(PM,Command)
    fCommand = [Command,char(13),char(10)];
	v = libpointer('cstring',fCommand);
	uN = uint32(length(fCommand));
	A = calllib('usbdll','newp_usb_send_ascii',PM.usbAddress,v,uN);
    pause(0.2);
    f = 1;
end