function f = fineScan(FFR,step,from,to)
	notify(FFR.Tonotify,'eFarfieldMeasurementMeasureStateChanged');
	Speed = 1;
	FFR.xData = [];
	FFR.yData = [];
	FFR.LMy.Setspeed(Speed);
	FFR.LMy.Getreply;
    	FFR.xData = [LM.Getposition];
    	FFR.PM.Get_Average_Power;
	while FFR.PM.Power_Average>1
		FFR.PM.Get_Average_Power;
	end
	FFR.yData = PM.Power_Average;
	notify(FFR.Tonotify,'eFarfieldMeasurementDataChanged');
	while FFR.xData(end)+step*1e3 < to
		FFR.LMy.Moveby(step*1e3);
		pause(1);
		FFR.xData = [FFR.xData, FFR.LMy.Getposition];
		FFR.PM.Get_Average_Power;
		while FFR.PM.Power_Average>1
			FFR.PM.Get_Average_Power;
		end
		FFR.yData = [FFR.yData,FFR.PM.Power_Average];
		notify(FFR.Tonotify,'eFarfieldMeasurementDataChanged');
    	end
	notify(FFR.Tonotify,'eFarfieldMeasurementMeasureStateChanged');
end

