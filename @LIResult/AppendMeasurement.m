function f = AppendMeasurement(LI,I) % fixme: no exception handling
	LI.hCurrentSource.Set_Current(I(1));
	pause(1e-3);
	LI.hPowerMeter.Get_Average_Power();
	V = LI.hCurrentSource.Get_Voltage();
	LI.Results.V = [LI.Results.V,V];
	LI.Results.L = [LI.Results.L,LI.hPowerMeter.Power_Average];
	LI.Results.I = [LI.Results.I,LI.hCurrentSource.Get_Current()];
	return;
end

