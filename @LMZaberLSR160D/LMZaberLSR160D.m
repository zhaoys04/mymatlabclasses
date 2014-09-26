classdef LMZaberLSR160D<handle
	% LMZaberLSR160D
	%
	% This class provides remote control through serial interface
	%
	% LMZaberLSR160D Properties:
	% 	device_obj  (0) - Handle of LSR160D linear stage 
	% 	serialPort ('com1') - The serial port used to establish connection
	% 	velocity (1) - The velocity of stage moving
	% 	LM_Timer - Timer to update parameters of stage
	% 	currentPosition (0) - The current position of stage
	% 	setPosition (0) - The target position
	% 	connected (false) - The status of connection 
	% 	ready (true) - Whether ready for next move
	% 	Tonotify - Vector of hObjects to be notified
	%
	% LMZaberLSR160D Events:
	%	eLMZaberLSR160DPositionChanged - Triggered when position is changed
	%	eLMZaberLSR160DReady - Triggered when stage is ready for next move
	%
	% LMZaberLSR160D Methods:
	%	ShowLayout(hPanel) - Show a default GUI of LSR160D stage. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to stage through serial
	%	Disconnect() - Disconnect the serial connection from stage
	%	LM_TimerFcn(obj,event) - Timer function called by timer
	%	Gohome() - Go to the home position 
	%	Moveto(position) - Move to the assigned position in mm 
	%	Moveby(distance) - Move by a distance set in mm 
	%	Getposition() - Query the position of stage 
	% 	Setspeed(Vel) - Set the velocity of stage
	% 	Checkready() - Check whether the stage is ready for next move

	% Examples:
	% 	LM = LMZaberLSR160D(serialNum, profileFile)
	% 	LM = LMZaberLSR160D(serialNum)
	%

	properties (Access = protected)
	        device_obj = 0;
	end
	properties (SetAccess = protected, GetAccess = public)
		resolution = 1.984375e-3; %in mm
		serialPort = 'com1';
		velocity = 1;
		LM_Timer = timer('ExecutionMode','fixedspacing','Period',1);
		currentPosition = 0;
		setPosition = 0;
		ready = true;
		connected = false;
		Tonotify = [];
	end
	events
		eLMZaberLSR160DPositionChanged;
		eLMZaberLSR160DReady;
	end
	methods 
		function LM = LMZaberLSR160D(Serial_Port, tonotify)
			if nargin>0
				LM.serialPort = Serial_Port;
			end
%			LM.device_obj = serial(LM.serialPort);
			LM.Tonotify = [LM, tonotify];
			set(LM.LM_Timer,'TimerFcn',@(hObject,eventdata)LM_TimerFcn(LM,hObject,eventdata));
		end
		f = Reset(LM);
		f = Connect(LM);
		f = Disconnect(LM);
	        f = Gohome(LM);
	        f = Setspeed(LM,Vel);
	        f = Moveto(LM,Pos);
	        f = Moveby(LM,Dis);
	        f = Getposition(LM);
		f = Setresolution(LM,res);
	        f = Getreply(LM);
	        [d3 d4 d5 d6] = entryToBits(LM,data);
		LM_TimerFcn(LM,hObject,eventdata);
		f = Checkready(LM);
		f = Showlayout(LM,hPanel);
	end
end
