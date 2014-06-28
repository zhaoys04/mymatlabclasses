classdef TCITC503 < handle
	% TCITC503
	%
	% This class provides remote control through gpib interface
	%
	% TCITC503 Properties:
	% 	gpib_obj  (0) - Handle of gpib obj of current source 
	% 	gpib_address - Gpib address of current source
	%	Temperature_Set (0) - The setpoint of temperature 
	%	Temperature_Read (0) - The current temperature of controller 
	%	Heater_Mode (0) - The mode of Heater 
	%	Heater (0) - The power level of heater in percentage 
	%	Gas_Flow_Mode (0) - The mode of gas flow control
	%	Control_Mode (0) - The control mode of controller, 
	%			0: Local&Locked
	%			1: Remote&Locked
	%			2: Local&Unlocked 
	%			3: Remote&Unlocked 
	%	Stable (0) - Whether the temperature is stable
	%
	% TCITC503 Events:
	%	eTCITC503TemperatureChanged - Triggered when temperature is changed
	%	eTCITC503HeaterModeChanged - Triggered when heater mode is changed
	%	eTCITC503StableStateChanged - Triggered when the stable status is changed
	%
	%TCITC503 Methods:
	%	ShowLayout(hPanel) - Show a default GUI of temperature controller. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to temperature controller through gpib
	%	Disconnect() - Disconnect the gpib connection from temperature controller
	%	Get_Temperature() - Query the temperature of controller 
	%	Set_Temperature(Temp) - Set the temperature of controller 
	%	Get_All_Modes() - Query the control mode, heater mode and gas flow mode of the controller 
	%	Set_Control_Mode(Mode) - Set the control mode of controller 
	%	Set_Heater_Mode(Mode) - Set the heater mode of controller 
	%	Set_Gas_Flow_Mode(Mode) - Set the gas flow mode of controller 
	%	Set_Heater(Power) - Set the power level of heater in percentage 
	%	Get_Heater() - Query the power level of heater  
	%	Temperature_Stable() - Query the temperature stable status of controller
	%	TC_TimerFcn(obj,event) - Timer function called by timer
	%
	% Example:
	% 	CS = TCITC503(gpib_address, tonotify);
	%

	properties (Access = protected)
		gpib_obj=0;
		handles;
	end
	properties (SetAccess = protected, GetAccess = public)
		gpib_address;
		Temperature_Set = 0;
		Temperature_Read = 0;
		Heater_Mode = 0;
		Heater = 0;
		Gas_Flow_Mode = 0;
		Control_Mode = 0;
		Stable = 0;
		Tonotify = [];
		TC_Timer = timer;

		TC_Stable_Timer = timer('StartDelay',120);
	end
	events
		eTCITC503TemperatureChanged;
		eTCITC503HeaterModeChanged;
		eTCITC503StableStateChanged;
	end
	methods 
		function TC = TCITC503(gpib_address, tonotify)
			if nargin > 0
				TC.gpib_address = gpib_address;
			else
				TC.gpib_address = 0;
			end
			TC.Tonotify = [TC, tonotify];
			set(TC.TC_Timer,'ExecutionMode','fixedspacing','Period',1,'TimerFcn',@(obj,event)TC_TimerFcn(TC,obj,event));
			set(TC.TC_Stable_Timer, 'TimerFcn', @(obj,event)TC_Set_Stable(TC,obj,event));
		end
		f = ShowLayout(TC,hPanel);
		f = Connect(TC);
		f = Disconnect(TC);
		f = Get_Temperature(TC);
		f = Set_Temperature(TC,Temp);
		f = Get_All_Modes(TC);
		f = Set_Control_Mode(TC,Mode);
		f = Set_Heater_Mode(TC,Mode);
		f = Set_Gas_Flow_Mode(TC,Mode);
		f = Set_Heater(TC,Power);
		f = Get_Heater(TC); % not finish 
		f = Temperature_Stable(TC);
		f = TC_TimerFcn(TC,obj,event);
		function f = TC_Set_Stable(TC,obj,event)
			TC.Stable = 4;
		end
	end
end
