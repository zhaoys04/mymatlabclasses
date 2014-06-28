classdef LMThorlabsZ812<handle
	% LMThorlabsZ812
	%
	% This class provides remote control through usb interface
	%
	% LMThorlabsZ812 Properties:
	% 	device_obj  (0) - Handle of Z812 linear attenuator 
	% 	devicePanelHanle - Handle of Throlab default panel 
	% 	LM_Timer - Timer to update parameters of attenuator
	% 	currentPosition (0) - The current position of attenuator
	% 	profileFile ('1') - The profile file of attenuator
	% 	connected (false) - The status of connection 
	% 	serialNum - The serial number of controller to connect
	% 	Tonotify - Vector of hObjects to be notified
	%
	% LMThorlabsZ812 Events:
	%	eLMThorlabsZ812PositionChanged - Triggered when position is changed
	%
	% LMThorlabsZ812 Methods:
	%	ShowLayout(hPanel) - Show a default GUI of Z812 attenuator. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to attenuator through usb
	%	Disconnect() - Disconnect the usb connection from attenuator
	%	LM_TimerFcn(obj,event) - Timer function called by timer
	%	Gohome() - Go to the home position 
	%	Moveto(position) - Move to the assigned position in mm 
	%	Moveby(distance) - Move by a distance set in mm 
	%	Getposition() - Query the position of attenuator 
	%	Waitforcomplete(s) - Wait for s secs for current movement is finished
	%
	% Examples:
	% 	LM = LMThorlabsZ812(serialNum, profileFile)
	% 	LM = LMThorlabsZ812(serialNum)
	%
	properties (Access = protected)
		device_obj;
		devicePanelHandle;
	end
	properties (SetAccess = protected, GetAccess = public)
	        LM_Timer = timer('ExecutionMode','fixedspacing','Period',1);
	        currentPosition = 0;
       		profileFile = '1';
        	Tonotify = [];
        	connected = false;
        	serialNum;
	end
	events
		eLMThorlabsZ812PositionChanged;
	end
	methods 
		function LM = LMThorlabsZ812(serialNum,profileFile)
			switch nargin
			case 2
				LM.serialNum = serialNum;
				LM.profileFile = profileFile;
			case 1
				LM.serialNum = serialNum;
			otherwise
				display('wrong input');
			end
			LM.Tonotify = [LM];
			set(LM.LM_Timer,'TimerFcn',@(hObject,eventdata)LM_TimerFcn(LM,hObject,eventdata));
		end
		f = Connect(LM);
		f = Disconnect(LM);
		f = Gohome(LM);
		f = Moveto(LM,position);
		f = Moveby(LM,distance);
		f = Getposition(LM);
		f = LM_TimerFcn(LM,hObject,eventdata);
		f = Waitforcomplete(LM,s);
		f = Showlayout(LM,hPanel);
	end
end
