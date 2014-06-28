function f = Connect(PM)
	% Connect() - Establish connection to power meter
	if PM.ConnectedByUSB
		if PM.device_obj == 0
			try
 				if ~libisloaded('usbdll')
					loadlibrary('usbdll.dll','NewpDll.h');
				end
			catch
				herrordlg = errordlg('Cannot load files for Newport USB connection. Please check that usbdll.dll and NewpDll.h are in the right directory.');
				return;
			end              
		end
	    	v1 = libpointer('int32Ptr',0);
    		[A B] = calllib('usbdll','newp_usb_open_devices',PM.productID,1,v1);
    		if B==0
	    		herrordlg = errordlg('Failed to connect to Power Meter 1931-C');
	    		f = -1;
	    		return;
	        end
       		PM.Status = 'open';
        	f = 1;
    	else
		if PM.device_obj == 0
			PM.device_obj = serial(PM.Serial_port);
			set(PM.device_obj, 'timeout', 5);
        		set(PM.device_obj, 'baudrate', 38400);
        	    	set(PM.device_obj, 'databits', 8);
                	set(PM.device_obj, 'stopbits', 1);
    			set(PM.device_obj, 'parity', 'none');
    			set(PM.device_obj, 'flowcontrol', 'none');
    			set(PM.device_obj, 'inputbuffersize', 5000);
    			set(PM.device_obj, 'terminator', 'cr/lf');
		end
        	try
	    		fopen(PM.device_obj);
	    		pause(0.1);
	    		fprintf(PM.device_obj, 'echo 0');
	    		fprintf(PM.device_obj, '*idn?');
	    		fgetl(PM.device_obj);
	    		fprintf(PM.device_obj, 'PM:DS:CL');
			PM.Status = 'open';
			f = 1;
		catch
			herrordlg = errordlg('Cannot find the device. Please check the gpib address configuration and the hardware connection.','Connection Error');
			f = -1;
			return;
		end
	end
end
