classdef CSILX3744B < handle
	% CSILX3744B
	%
	% This class provides remote control through gpib interface
	%
	% CSILX3744B Properties:
	% 	gpib_obj  (0) - Handle of gpib obj of current source 
	% 	gpib_address  - Gpib address of current source
	% 	Current_Set (0) - The current value to be set
	% 	Current_Output (0) - The current value that the current source is outputing. This may be different from Current_Set
	% 	Voltage (0) - The voltage value reading from the current source
	% 	Current_Range (2000) - The range of current in mA, it can be 2000mA or 4000mA
	% 	Current_Limit (0) - The limitation of current
	% 	Mode (0) - The current output mode, 
	% 			1: Constant I, Low bandpass 
	% 			2: Constant I, High bandpass 
	% 			3: Constant Power
	% 	Mode_String ('') - Human readable mode description
	% 	Output (0) - The output status of current source, 0:disabled 1:enabled
	% 	CS_Timer - Timer to update parameters of current source
	% 	Tonotify - Vector of hObjects to be notified
	%
	% CSILX3744B Events:
	%	eCSILX3744BCurrentChanged - Triggered when current is changed
	%	eCSILX3744BVoltageChanged - Triggered when voltage is changed
	%
	%CSILX3744B Methods:
	%	ShowLayout(hPanel) - Show a default GUI of current source. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to current source through gpib
	%	Disconnect() - Disconnect the gpib connection from current source
	%	Get_Current() - Query the current of source now
	%	Get_Voltage() - Query the voltage of source now
	%	Set_Current(Current_Value) - Set the current of current source, unit in mA 
	%	Set_Mode(Mode) - Set the mode of current source, 
	%			1: Constant I, Low bandpass 
	% 			2: Constant I, High bandpass 
	% 			3: Constant Power
	%	Get_Mode() - Query the mode of current source
	%	Set_Current_Range(Current_Range) - Set the range of current, unit in mA
	%	Get_Current_Range() - Query the limit of current
	%	Set_Output() - Enable the output of current source
	%	Deset_Output() - Disable the output of current source
	%	Get_Output() - Query the output status of current source
	%	CS_TimerFcn(obj,event) - Timer function called by timer
	%
	% Example:
	% 	CS = CSILX3744B(gpib_address, tonotify)
	%

	properties (Access = protected)
		gpib_obj = 0;
	end
	properties (SetAccess = protected, GetAccess = public)
		gpib_address;
		Current_Set = 0;
		Current_Output = 0;
		Voltage = 0;
		Current_Range = 2000;
		Current_Limit;
		Mode = 0;
		Mode_String = '';
		Output = 0;
		CS_Timer = timer;
		Tonotify = [];
	end
	events
		eCSILX3744BCurrentChanged;
		eCSILX3744BVoltageChanged;
	end
	methods 
		function CS = CSILX3744B(gpib_address,tonotify)
			if nargin > 0
				CS.gpib_address = gpib_address;
			else
				CS.gpib_address = 0;
			end
			CS.Tonotify = [CS,tonotify];
			set(CS.CS_Timer,'ExecutionMode','fixedspacing','Period',1,'TimerFcn',@(obj,event)CS_TimerFcn(CS,obj,event));
		end

		f = ShowLayout(CS,hPanel);
		f = Connect(CS);
		f = Disconnect(CS);
		f = Get_Current(CS);
		f = Get_Voltage(CS);
		f = Set_Current(CS, Current_Value);
		f = Set_Mode(CS, Mode);
		f = Get_Mode(CS);
		f = Set_Current_Range(CS, Current_Range);
		f = Get_Current_Range(CS);
		f = Set_Output(CS);
		f = Deset_Output(CS);
		f = Get_Output(CS);
		f = CS_TimerFcn(CS,obj,event);
	end
end
