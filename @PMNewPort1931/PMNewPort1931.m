classdef PMNewPort1931 < handle
	% PMNewPort1931
	%
	% This class provides remote control through usb/serial interface
	%
	% PMNewPort1931 Properties:
	% 	device_obj  (0) - Handle of NewPort 1931 
	%	Serial_port ('com1') - Serial port used for connection through serial interface 
	%	usbAddress (3) - USB address used for connection through usb interface 
	%	productID (0) - Product ID used for connection through usb interface 
	%	ConnectedByUSB (0) - Whether the connection is established through usb interface
	%	Power_Read (0) - The power value reading from power meter 
	%	Power_Average (0) - The average power reading from power meter 
	%	Wavelength (1550e-9) - The wavelength of power meter 
	%	Average_Time (1) - The average time for power average reading in secs 
	%	Status  ('closed') - The status of connection 
	% 	PM_Timer - Timer to update parameters of attenuator
	%
	%
	% PMNewPort1931 Methods:
	%	ShowLayout(hPanel) - Show a default GUI of power meter. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to power meter
	%	Disconnect() - Disconnect the connection from power meter
	%	PM_TimerFcn(obj,event) - Timer function called by timer 
	%	Get_Power() - Query the instant power reading of power meter 
	%	Get_Wavelength() - Query the wavelength the power meter is measuring 
	%	Set_Wavelength(Wavelength) - Set the wavelength of power meter in m 
	%	Set_Average_Time(Time) - Set the average time in secs to obtain average power 
	%	Get_Average_Power() - Query the average power of power meter
	%
	% Examples:
	% 	LM = PMNewPort1931(Port, connectByUSB)
	% 	LM = PMNewPort1931(Port)
	%

	properties (Access = protected)
		device_obj = 0;
		handles;
	        Buffer = '0000000000000000000000000000000000000000000000000000000000000000';
	end
	properties (SetAccess = protected, GetAccess = public)
		Serial_port = 'com1';
	        usbAddress = 3;
	        productID = 0;
	        ConnectedByUSB = 0;
		Power_Read = 0;
		Power_Average = 0;
		Wavelength = 1550e-9;
		Average_Time = 1;
	        Status = 'closed';

		PM_Timer = timer;
	end
	methods 
		function PM = PMNewPort1931(Port,connectByUSB)
			switch nargin
			case 2
				PM.usbAddress = Port;
				PM.ConnectedByUSB = 1;
			case 1
				PM.Serial_port = Port;
				PM.ConnectedByUSB = 0;
			otherwise
				PM.ConnectedByUSB = 0;
			end
			set(PM.PM_Timer, 'ExecutionMode','fixedspacing','Period',1,'TimerFcn',@(obj,event)PM_TimerFcn(PM,obj,event));
		end
		f = ShowLayout(PM,hPanel);
		f = Connect(PM);
		f = Disconnect(PM);
		f = Get_Power(PM);
		f = Get_Wavelength(PM);
		f = Set_Wavelength(PM, Wavelength);
		f = Set_Average_Time(PM, Time);
		f = Get_Average_Power(PM);
		f = Update(PM);
		f = PM_TimerFcn(PM,obj,event);
	        f = SendCommandviaUSB(PM,Command);
	        f = GetResponseviaUSB(PM);
	end
end
