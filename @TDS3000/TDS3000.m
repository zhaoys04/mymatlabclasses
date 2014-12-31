classdef TDS3000 < handle
	% TDS3000
	%
	% This class provides remote control through gpib interface
	%
	% TDS3000 Properties:
	% 	gpib_obj  (0) - Handle of gpib obj of oscillator 
	% 	gpib_address  - Gpib address of oscillator
	%	data_num (10000) - How many points in one wave
	%	ACQ - Acqusition structure:
	%		Mode (0): acqusition mode 1:Sample 2:Peak 3:Average 4:Envelope;
	%		NumAvg (1): number of waves for average
	%		NumEnv (1): number of envelope to get
	%		State (0): state of acquisition
	%		StopA (0): stop acquisition when done
	% 	TDS_Timer - Timer to update parameters of current source
	% 	Tonotify - Vector of hObjects to be notified
	%
	%TDS3000 Methods:
	%	Connect() - Establish connection to current source through gpib
	%	Disconnect() - Disconnect the gpib connection from current source
	%	Update_binaryconv() - Update the wavefront conversion function 
	%	Get_Wave(channel) - Query the wave of channel, channel: ch1 or ch2 
	%	Set_Time_div(div) - Set the division value of time axis 
	%	Set_CH_Scale(channel,div) - Set the vertical scale of channel 
	%	Set_Acq_Mode(TDS,ACQ) - Set the acquisition mode of oscillator 
	%	Auto_Vertical_Tune(channel) - Query the wave shape of channel with automatically tunned vertical scale 
	%	Set_Position(channel,pos) - Set the baseline position of channel
	%	WaitforAcqStop() - Return when acquisition is stop
	%
	% Example:
	% 	TDS = TDS3000(gpib_address, tonotify);
	%

	properties (Access = protected)
		gpib_obj = 0;
	end
	properties (SetAccess = protected, GetAccess = public)
		gpib_address;
		data_num=10000;
		tds_width=2;
		binaryconv = 0;
		ACQ = struct('Mode',0,'NumAvg',1,'NumEnv',1,'State','STOP','StopA','SEQ');
		TDS_Timer = timer; 
		TIMEDIVS=[2e-9,4e-9,10e-9,20e-9,40e-9,100e-9,200e-9,400e-9,1e-6,2e-6,...
			    4e-6,10e-6,20e-6,40e-6,100e-6,200e-6,400e-6,1e-3,2e-3,4e-3,10e-3,...
			    20e-3,40e-3,100e-3,200e-3,400e-3,1,2,4,10];

		Tonotify = [];
	end
	methods 
		function TDS = TDS3000(gpib_address,tonotify)
			if nargin > 0
				TDS.gpib_address = gpib_address;
			else
				TDS.gpib_address = 0;
			end
			TDS.Tonotify = [TDS, tonotify];
		end

%		f = ShowLayout(TDS,hPanel);
		f = Connect(TDS);
		f = Disconnect(TDS);
		f = Update_binaryconv(TDS);
		f = Get_Wave(TDS,channel); %channel: ch1 or ch2
		f = Set_Time_div(TDS,div);
		f = Set_CH_Scale(TDS,channel,div);
		f = Set_Acq_Mode(TDS,ACQ);
		f = Auto_Vertical_Tune(TDS,channel);
		f = Set_Position(TDS,channel,pos);
		f = WaitforAcqStop(TDS);
%		f = TDS_TimerFcn(TDS,obj,event);
	end
end
