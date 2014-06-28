function f = farFieldScan(FFR,step,from,to,source)
	notify(FFR.Tonotify,'eFarfieldMeasurementMeasureStateChanged');
	FFR.xData = [];
	FFR.yData = [];
	x0 = source(1);
	y0 = source(2);
	FFR.LMy.Fastspeed;
	FFR.LMy.Moveto(from);
	d = step*1e3;% in mm
	while ~FFR.LMy.ready
		pause(1);
	end
	Speed = 1;
	FFR.LMy.Setspeed(Speed);
	Pos = FFR.LMy.Getposition;
	currentTheta = FFR.RT.Getposition;
	if currentTheta>180
		currentTheta = currentTheta-360;
	end
	theta = atan((y0-Pos)/x0)/pi*180-currentTheta
	FFR.RT.Rotateby(theta);
	FFR.RT.Waitforcomplete(3);
	FFR.PM.Get_Average_Power;
	currentTheta = FFR.RT.Getposition;
	if currentTheta>180
		currentTheta = currentTheta-360;
	end
	FFR.xData = [FFR.xData,currentTheta];
	FFR.yData = [FFR.yData,FFR.PM.Power_Average];
	notify(FFR.Tonotify,'eFarfieldMeasurementDataChanged');
	nextPosition = fsolve(@mfunc,Pos+d)
	while nextPosition<=to
		FFR.LMy.Moveto(nextPosition);
		while ~FFR.LMy.ready
			pause(0.1);
		end
		Pos = FFR.LMy.Getposition;
		currentTheta = FFR.RT.Getposition;
		if currentTheta>180
			currentTheta = currentTheta-360;
		end
		theta = atan((y0-Pos)/x0)/pi*180-currentTheta
		FFR.RT.Rotateby(theta);
		FFR.RT.Waitforcomplete(3);
		display(currentTheta);
		FFR.PM.Get_Average_Power;
		currentTheta = FFR.RT.Getposition;
		if currentTheta>180
			currentTheta = currentTheta-360;
		end
		FFR.xData = [FFR.xData,currentTheta];
		FFR.yData = [FFR.yData,FFR.PM.Power_Average];
		notify(FFR.Tonotify,'eFarfieldMeasurementDataChanged');
		nextPosition = fsolve(@mfunc,Pos+d)
	end
	notify(FFR.Tonotify,'eFarfieldMeasurementMeasureStateChanged');
	function f = mfunc(x)
		r1 = sqrt(x0^2+(y0-x)^2);
		r2 = sqrt(x0^2+(y0-Pos)^2);
		f = r1^2+r2^2-2*r1*r2*cos(atan(d/2/r1)+atan(d/2/r2))-(x-Pos)^2;
	end
end
