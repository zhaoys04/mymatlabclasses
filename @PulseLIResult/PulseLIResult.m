classdef PulseLIResult<handle
	properties (SetAccess = protected, GetAccess = public)
		hCurrentSource;
		hPowerMeter;
		hTempControl;
		hOSC;
		hDB;
		hFTP;
		Results;
		Tonotify;
		GoingtoStop;
	end
	events
		ePulseLIMeasurementComplete;
		ePulseLIMeasurementStop;
	end

	methods 
		function LI = PulseLIResult()
			LI.GoingtoStop = 0;
			LI.hCurrentSource = -1;
			LI.hPowerMeter = -1;
			LI.hTempControl = -1;
			LI.hDB = -1;
			LI.hFTP = -1;
			LI.hOSC = -1;
			LI.Results.I = [];
			LI.Results.V = [];
			LI.Results.L = [];
			LI.Tonotify = [LI];
		end
		f = AddCurrentSource(LI,CS);
		f = AddOSC(LI,OSC);
		f = AddPowerMeter(LI,PM);
		f = AddTempControl(LI,TC);
		f = AddDB(LI,DB);
		f = AddFTP(LI,FTP);
		f = ShowLayout(LI,hPanel);
		f = UpdatePlot(LI);
		f = GetI(LI);
		f = GetV(LI);
		f = GetL(LI);
		f = NewMeasurement(LI,I);
		f = AppendMeasurement(LI,I);
	end
end
