classdef CSILX3601835 < handle
	% CSILX3601835
	%
	% This class provides remote control through gpib interface
	%
	% CSILX3601835 Properties:
	% 	gpib_obj  (0) - Handle of gpib obj of current source 
	% 	gpib_address  - Gpib address of current source
	% 	Current_Set (0) - The current value to be set
	% 	Current_Output (0) - The current value that the current source is outputing. This may be different from Current_Set
	% 	Voltage (0) - The voltage value reading from the current source
	% 	Current_Limit (0) - The limitation of current
	% 	Mode (0) - The current output mode, 1:CW 2:HPULSE 3:PULSE 4:TRIG 
	% 	Mode_String ('') - Human readable mode description
	% 	Output (0) - The output status of current source, 0:disabled 1:enabled
	% 	QCW - Quasi CW mode setting structure 
	% 		QCW.pw: pulse width in secs, 
	% 		QCW.freq: frequency in 1-1000Hz, 
	% 		QCW.duty: duty cycle in percentage, 
	% 		QCW.Mode: 0:constant duty cycle mode, 
	% 			  1:constant frequency mode
	% 	CS_Timer - Timer to update parameters of current source
	% 	Tonotify - Vector of hObjects to be notified
	%
	% CSILX3601835 Events:
	%	eCSILX3601835CurrentChanged - Triggered when current is changed
	%	eCSILX3601835VoltageChanged - Triggered when voltage is changed
	%	eCSILX3601835ModeChanged - Triggered when current source mode is changed
	%	eCSILX3601835CurrentLimitChanged - Triggered when current limit is changed
	%	eCSILX3601835PulseWidthChanged - Triggered when pulse width in QCW is changed
	%	eCSILX3601835FreqChanged - Triggered when frequency in QCW is changed
	%	eCSILX3601835DutyCycleChanged - Triggered when duty cycle in QCW is changed
	%
	%CSILX3601835 Methods:
	%	ShowLayout(hPanel) - Show a default GUI of current source. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to current source through gpib
	%	Disconnect() - Disconnect the gpib connection from current source
	%	Get_Current() - Query the current of source now
	%	Get_Voltage() - Query the voltage of source now
	%	Set_Current(Current_Value) - Set the current of current source, unit in A 
	%	Set_Mode(Mode) - Set the mode of current source, 1:CW 2:HPULSE 3:PULSE 4:TRIG 
	%	Get_Mode() - Query the mode of current source
	%	Set_Current_Limit(Current_Limit) - Set the limit of current, unit in A
	%	Get_Current_Limit() - Query the limit of current
	%	Get_Pulse_Width() - Query the pulse width of current source in ms 
	%	Set_Pulse_Width(pw) - Set the pulse width of current source in secs 
	%	Get_Freq() - Query the frequency of current source in Hz 
	%	Set_Freq(freq) - Set the frequency of current source  in Hz 
	%	Get_Duty_Cycle() - Query the duty cycle of current source in percentage 
	%	Set_Duty_Cycle(dc) - Set the duty cycle of current source in percentage 
	%	Set_Output() - Enable the output of current source
	%	Set_QCW_Mode(Mode) - Set the mode of QCW operation, 0: constant duty cycle 1: constant frequency 
	%	Get_QCW_Mode() - Query the mode of QCW operation
	%	Deset_Output() - Disable the output of current source
	%	Get_Output() - Query the output status of current source
	%	CS_TimerFcn(obj,event) - Timer function called by timer
	%
	% Example:
	% 	CS = CSILX3601835(gpib_address, tonotify);
	%
	properties (Access = protected)
		gpib_obj = 0;
	end
	properties (SetAccess = protected, GetAccess = public)
		gpib_address;
		Current_Set = 0;
		Current_Output = 0;
		Voltage = 0;
		Current_Limit = 0;
		Mode = 0; % 1:CW 2:HPULSE 3:PULSE 4:TRIG
		Mode_String = '';
		Output = 0;
		QCW = struct('pw',0,'freq',0,'duty',0,'Mode',0); %pulse width in secs, frequency in 1-1000Hz, duty cycle in percentage, 0:constant duty cycle; 1:constant frequency

		CS_Timer = timer; 
		Tonotify = [];
    end
	events
		eCSILX3601835CurrentChanged;
		eCSILX3601835VoltageChanged;
		eCSILX3601835ModeChanged;
		eCSILX3601835CurrentLimitChanged;
		eCSILX3601835PulseWidthChanged;
		eCSILX3601835FreqChanged;
		eCSILX3601835DutyCycleChanged;
	end
	methods 
		function CS = CSILX3601835(gpib_address,tonotify)
			if nargin > 0
				CS.gpib_address = gpib_address;
			else
				CS.gpib_address = 0;
			end
			CS.Tonotify = [CS, tonotify];
			set(CS.CS_Timer,'ExecutionMode','fixedspacing','Period',1,'TimerFcn',@(obj,event)CS_TimerFcn(CS,obj,event));
		end

		f = ShowLayout(CS,hPanel);
		f = Connect(CS);
		f = Disconnect(CS);
		f = Get_Current(CS);
		f = Get_Voltage(CS);
		f = Set_Current(CS, Current_Value); % in Amps
		f = Set_Mode(CS, Mode);
		f = Get_Mode(CS);
		f = Set_Current_Limit(CS, Current_Limit);
		f = Get_Current_Limit(CS);
		f = Get_Pulse_Width(CS); % in ms
		f = Set_Pulse_Width(CS,pw); % in secs
		f = Get_Freq(CS); % in Hz
		f = Set_Freq(CS, freq); % in Hz
		f = Get_Duty_Cycle(CS);  % in percentage
		f = Set_Duty_Cycle(CS,dc); % in percentage
		f = Set_Output(CS);
		f = Set_QCW_Mode(CS,Mode); % 0: constant duty cycle 1: constant frequency
		f = Get_QCW_Mode(CS);
		f = Deset_Output(CS);
		f = Get_Output(CS);
		f = CS_TimerFcn(CS,obj,event);
	end
end
