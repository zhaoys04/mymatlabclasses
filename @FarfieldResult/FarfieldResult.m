classdef FarfieldResult < handle
	% FarfieldResult
	%
	% This class provides GUI for Farfield measurement 
	%
	% FarfieldResult Properties:
	%	LMx - Handle of x direction linear stage
	%	LMy - Handle of y direction linear stage
	%	RT - Handle of rotary stage
	%	PM - Handle of power meter
	%
	% FarfieldResult Methods:
	%	coarseScan() - Fast and coarsely scan the far field pattern.Note: set y stage back home first before call this	function.
	%	fineScan(step,from,to) - Slowly scan the far field with a step defined by step and show more details within [from, to].
	%	farFieldScan(step,from,to,source) - Start a far field scan within position [from, to] at a step defined by step. The x axis is converted to degree based on the source position set by source.
	%	showLayout(hPanel) - Show a default GUI of far field result. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	updateMeasureState() - Callback function used to change the  status of measurement
	%
	% Example:
	% 	FFR = FarfieldResult(LMx,LMy,RT,PM);
	properties (SetAccess = protected, GetAccess = public)
		LMx;
		LMy;
		RT;
		PM;
		Tonotify;
        	Measuring = false;
		xData = [];
		yData = [];
	end
	events
		eFarfieldMeasurementCursorChanged;
		eFarfieldMeasurementDataChanged;
	        eFarfieldMeasurementMeasureStateChanged;
	end
	methods 
		function FFR = FarfieldResult(LMx,LMy,RT,PM)
			FFR.LMx = LMx;
			FFR.LMy = LMy;
			FFR.RT = RT;
			FFR.PM = PM;
			FFR.Tonotify = [FFR];
			lh = addlistener(FFR,'eFarfieldMeasurementMeasureStateChanged',@(hObject,eventdata)FFR.updateMeasureState(hObject,eventdata));
		end
		f = coarseScan(FFR);
		f = fineScan(FFR,step,from,to);
		f = farFieldScan(FFR,step,from,to,source);
		f = showLayout(FFR,hPanel);
		f = updateMeasureState(FFR,hObject,eventdata);
	end
end

