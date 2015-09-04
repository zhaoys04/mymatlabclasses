classdef MMKeithley < handle
	% MMKeithley
	%
	% This class provides remote control through gpib interface
	%
	% MMKeithley Properties:
	% 	gpib_obj  (0) - Handle of gpib obj of current source 
	% 	gpib_address  - Gpib address of current source
	%
	% MMKeithley Methods:
	%	Connect() - Establish connection to current source through gpib
	%	Disconnect() - Disconnect the gpib connection from current source
	%	Get_Voltage() - Query the voltage
	%
	% Example:
	% 	MM = MMKeithley(gpib_address, tonotify)
	%

	properties (Access = protected)
		gpib_obj = 0;
	end
	properties (SetAccess = protected, GetAccess = public)
		gpib_address;
		Voltage;
		Tonotify = [];
		busy = false;
	end
	methods 
		function MM = MMKeithley(gpib_address,tonotify)
			if nargin > 0
				MM.gpib_address = gpib_address;
			else
				MM.gpib_address = 0;
			end
			MM.Tonotify = [MM,tonotify];
		end

		f = Connect(MM);
		f = Disconnect(MM);
		f = Get_Voltage(MM);
		f = Waitforidle(MM);
	end
end
