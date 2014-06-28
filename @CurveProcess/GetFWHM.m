function f = GetFWHM(CP,bound,curvs)
	CP.Results = [];
	CP.Results.FW = [];
	CP.Results.HM = [];
	for i = 1:length(curvs)
		xdata = CP.Curves.x{curvs(i)};
		ydata = CP.Curves.y{curvs(i)};
		if length(bound) == 2
			L = (xdata>=bound(1) & xdata<=bound(2));
			xdata = xdata(L);
			ydata = ydata(L);
		end
		[ymax max_ind] = max(ydata);
		[ymin min_ind] = min(ydata);
		HM = (ymax + ymin)/2;
		CP.Results.HM = [CP.Results.HM,HM];
		L = (ydata>=HM);
		x = xdata(L);
		x0 = (x(1) + x(end))/2;
		L = (xdata>=x0);
		y = ydata(L);
		if (y(1) >= HM)
			L = (ydata>=HM);
		else
			L = (ydata<=HM);
		end
		ind = find(L == 1);
		x1 = xdata(ind(1)-1);
		y1 = ydata(ind(1)-1);	
		x2 = xdata(ind(1));
		y2 = ydata(ind(1));	
		x3 = xdata(ind(end));
		y3 = ydata(ind(end));
		x4 = xdata(ind(end)+1);
		y4 = ydata(ind(end)+1);
		X1 = interp1([y1,y2],[x1,x2],HM);	
		X2 = interp1([y3,y4],[x3,x4],HM);	
		r = abs(X1-X2);
		CP.Results.FW = [CP.Results.FW,r];
	end
end
