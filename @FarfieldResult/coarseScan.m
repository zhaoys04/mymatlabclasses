function f = Coarsescan(FFR)
	notify(FFR.Tonotify,'eFarfieldMeasurementMeasureStateChanged');
	Speed = 1;
	FFR.xData = [];
	FFR.yData = [];
	T = timer('StartFcn',@myStartFcn,'TimerFcn',@myTimerFcn,'StopFcn',@myStopFcn,'Period',1,'TasksToExecute',round(230/Speed),'ExecutionMode','fixedRate');
	start(T);
	wait(T);
	stop(T);
	function myTimerFcn(hObject,eventdata)
		FFR.PM.Get_Power;
	        while FFR.PM.Power_Read>1
			FFR.PM.Get_Power;
	        end
		FFR.xData = [FFR.xData;FFR.LMy.Getposition];
	        FFR.yData = [FFR.yData;FFR.PM.Power_Read];
		notify(FFR.Tonotify,'eFarfieldMeasurementDataChanged');
	end
	function myStartFcn(hObject,eventdata)
		FFR.LMy.Setspeed(Speed);
		FFR.LMy.Moveto(150);
	end
	function myStopFcn(hObject,eventdata)
            notify(FFR.Tonotify,'eFarfieldMeasurementMeasureStateChanged');
	end
end	
