classdef CurveProcess<handle
	properties (SetAccess = protected, GetAccess = public)
		Curves;
		Results;
	end
	events
		eCheckboxChecksChanged;
	end
	methods 
		function CP = CurveProcess()
			CP.Curves.x = [];
			CP.Curves.y = [];
			CP.Results = [];
		end
		f = ShowLayout(CP,hPanel);
		f = AddCurve(CP,x,y);
		f = RemoveCurve(CP,curvs);
		f = GetMax(CP,bound,curvs);
		f = GetMin(CP,bound,curvs);
		f = GetFWHM(CP,bound,curvs);
		f = GetSlope(CP,bound,curvs);
		f = GetPeaks(CP,bound,curvs);
		f = GetDerivative(CP,curvs);
		f = GetAverage(CP,bound,curvs);
	end
end
