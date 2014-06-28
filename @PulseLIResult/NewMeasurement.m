function f = NewMeasurement(LI,I)
	LI.Results.I = [];
	LI.Results.V = [];
	LI.Results.L = [];
	LI.GoingtoStop = 0;
	for i = 1:length(I)
		if LI.GoingtoStop
			notify(LI.Tonotify,'ePulseLIMeasurementStop');
			return
		end
		LI.hCurrentSource.Set_Current(I(i));
		pause(1);
		LI.Results.I = [LI.Results.I, LI.GetI];
		LI.Results.V = [LI.Results.V, LI.GetV];
		LI.Results.L = [LI.Results.L, LI.GetL];
		drawnow;
	end
	notify(LI.Tonotify,'ePulseLIMeasurementComplete');
end
