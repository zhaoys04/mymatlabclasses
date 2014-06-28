classdef RTThorlabsCR1Z7<handle
	% RTThorlabsCR1Z7
	%
	% This class provides remote control through usb interface
	%
	% RTThorlabsCR1Z7 Properties:
	% 	device_obj  (0) - Handle of CR1Z7 linear attenuator 
	% 	devicePanelHanle - Handle of Throlab default panel 
	% 	RT_Timer - Timer to update parameters of attenuator
	% 	currentPosition - The current position of attenuator
	% 	profileFile ('1') - The profile file of attenuator
	% 	connected (false) - The status of connection 
	% 	serialNum - The serial number of controller to connect
	% 	Tonotify - Vector of hObjects to be notified
	%
	% RTThorlabsCR1Z7 Events:
	%	eRTThorlabsCR1Z7PositionChanged - Triggered when position is changed
	%
	% RTThorlabsCR1Z7 Methods:
	%	ShowLayout(hPanel) - Show a default GUI of Z812 attenuator. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to stage through usb
	%	Disconnect() - Disconnect the usb connection from stage
	%	TimerFcn(obj,event) - Timer function called by timer
	%	Gohome() - Go to the home position 
	%	Rotateto(degree) - Rotate to the assigned angle 
	%	Rotateby(degree) - Rotate by an angle  
	%	Getposition() - Query the angle of stage 
	%	Waitforcomplete(s) - Wait for s secs for current movement is finished
	%
	% Examples:
	% 	RT = RTThorlabsCR1Z7(serialNum, profileFile)
	% 	RT = RTThorlabsCR1Z7(serialNum)
	%

	properties (Access = protected)
		devicePanelHandle;
		device_obj;
	end
	properties (SetAccess = protected, GetAccess = public)
		currentPosition;
		profileFile = '1';
		serialNum;
		Tonotify;
		connected = false;
		RT_Timer = timer('ExecutionMode','fixedspacing','Period',1);
	end
	events
		eRTThorlabsCR1Z7PositionChanged;
	end
	methods 
		function RT = RTThorlabsCR1Z7(serialNum,profileFile)
			switch nargin
			case 2
				RT.serialNum = serialNum;
				RT.profileFile = profileFile;
			case 1
				RT.serialNum = serialNum;
			otherwise
				display('wrong input');
			end
			RT.Tonotify = [RT];
			set(RT.RT_Timer,'TimerFcn',@(hObject,eventdata)TimerFcn(RT,hObject,eventdata));
   		end
		f = Connect(RT);
		f = Disconnect(RT);
		f = Gohome(RT);
		f = Rotateto(RT,degree);
		f = Rotateby(RT,degree);
		f = Getposition(RT);
		f = Waitforcomplete(RT,s);
		f = TimerFcn(RT,hObject,eventdata);
		f = Showlayout(RT,hPanel);
	end
end
