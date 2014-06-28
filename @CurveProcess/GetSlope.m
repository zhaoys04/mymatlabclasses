function f = GetSlope(CP,bound,curvs)
	CP.Results = [];
	if length(bound) == 2
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			L = (x<=bound(2) & x>=bound(1));
			x = x(L);
			y = y(L);
			a = polyfit(x,y,1);
			CP.Results = [CP.Results,{a}];
		end
		f = 0;
	else if isempty(bound)
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			a = polyfit(x,y,1);
			CP.Results = [CP.Results,{a}];
		end
		f = 0;
	else
		f = -1;
	end
end

