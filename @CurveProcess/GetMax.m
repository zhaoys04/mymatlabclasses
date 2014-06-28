function f = GetMax(CP,bound,curvs)
	CP.Results = [];
	CP.Results.x = [];
	CP.Results.y = [];
	if (length(bound) == 2)
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			LL = (x<=bound(2) & x>=bound(1));
			x = x(LL);
			y = y(LL);
			[m ind] = max(y);
			CP.Results.x = [CP.Results.x,x(ind)];
			CP.Results.y = [CP.Results.y,m];
		end
		f = 0;
	else if isempty(bound)
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			[m ind] = max(y);
			CP.Results.x = [CP.Results.x,x(ind)];
			CP.Results.y = [CP.Results.y,m];
		end
		f = 0;
	else
		display('boundary is set wrong');
		f = -1;
	end
end

