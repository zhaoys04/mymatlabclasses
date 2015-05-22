function f = NewMeasurement(LI,I) % fixme: no exception handling
	LI.hCurrentSource.Set_Current(I(1));
	pause(1e-3);
	LI.hPowerMeter.Get_Average_Power();
    while LI.hPowerMeter.Power_Average > 100
        	LI.hPowerMeter.Get_Average_Power();
    end
	V = LI.hCurrentSource.Get_Voltage();
	LI.Results.V = V;
	LI.Results.L = LI.hPowerMeter.Power_Average;
	LI.Results.I = LI.hCurrentSource.Get_Current();
	return;
end

