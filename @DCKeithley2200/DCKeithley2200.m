classdef DCKeithley2200 < handle
	% DCKeithley2200
	%
	% This class provides remote control through gpib interface
	%
	% DCKeithley2200 Properties:
	% 	gpib_obj  (0) - Handle of gpib obj of current source 
	% 	gpib_address  - Gpib address of current source
	%
	% DCKeithley2200 Methods:
	%	Connect() - Establish connection to current source through gpib
	%	Disconnect() - Disconnect the gpib connection from current source
	%	Set_Voltage(V) - Set the voltage of source
	%	Get_Voltage() - Query the voltage of source
	%	Set_Output() - Enable the output of current source
	%	Deset_Output() - Disable the output of current source
	%	Get_Output() - Query the output status of current source
	%
	% Example:
	% 	DC = DCKeithley2200(gpib_address, tonotify)
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
		function DC = DCKeithley2200(gpib_address,tonotify)
			if nargin > 0
				DC.gpib_address = gpib_address;
			else
				DC.gpib_address = 0;
			end
			DC.Tonotify = [DC,tonotify];
		end

		f = Connect(DC);
		f = Disconnect(DC);
		f = Set_Voltage(DC,V);
		f = Get_Voltage(DC);
		f = Set_Output(DC);
		f = Deset_Output(DC);
		f = Waitforidle(DC);
	end
end
