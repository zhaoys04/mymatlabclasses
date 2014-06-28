classdef LIResult<handle
	% LIResult
	%
	% This class provides GUI for LI measurement 
	%
	% LIResult Properties:
	%	hCurrentSource - Handle of current source going to use
	%	hPowerMeter - Handle of power meter going to use
	%	hTempControl - Handle of temperature controller going to use
	%	hDB - Handle of database going to use
	%	hFTP - Handle of FTP going to use
	%	Results - Measurement results
	%
	%LIResult Methods:
	%	ShowLayout(hPanel) - Show a default GUI of current source. hPanel can be handle of uipanel. If omitted, a new figure will be created.  
	%	UpdatePlot() - Update the plot of results 
	%	NewMeasurement(I) - Start a new measurement on the points within vector I 
	%	AppendMeasurement(I) - Append the measurement on points within vector I to the old results
	%
	% Example:
	% 	LI = LIResult(hCurrentSource,hPowerMeter,hTempControl,hDB,hFTP);
	% 	LI = LIResult(hCurrentSource,hPowerMeter,hTempControl,hDB);
	% 	LI = LIResult(hCurrentSource,hPowerMeter,hTempControl);
	% 	LI = LIResult(hCurrentSource,hPowerMeter);
	%
	properties (SetAccess = protected, GetAccess = public)
		hCurrentSource;
		hPowerMeter;
		hTempControl;
		hDB;
		hFTP;
		Results;
	end
	methods 
		function LI = LIResult(hCurrentSource,hPowerMeter,hTempControl,hDB,hFTP)
			LI.hCurrentSource = hCurrentSource;
			LI.hPowerMeter = hPowerMeter;
			LI.Results.I = [];
			LI.Results.V = [];
			LI.Results.L = [];
			if (exist('hTempControl'))
				LI.hTempControl = hTempControl;
				LI.Results.T = [];
			else
				display('No temperature controller is defined, measurements will be assumed at 300K');
			end
			if (exist('hDB'))
				LI.hDB = hDB;
			else
				display('No Database is assigned, won''t to save to database');
			end
			if (exist('hFTP'))
				LI.hFTP = hFTP;
			else
				display('No FTP is assigned,won''t to save to database');
			end
		end
		f = ShowLayout(LI,hPanel);
		f = NewMeasurement(LI,I);
		f = AppendMeasurement(LI,I);
	end
end
