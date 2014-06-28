function f = GetAverage(CP,bound,curvs)
	CP.Results = [];
	if (length(bound) == 2)
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			LL = (x<=bound(2) & x>=bound(1));
			x = x(LL);
			y = y(LL);
			ave = sum(y)/length(y);
			CP.Results = [CP.Results,ave];
		end
		f = 0;
	else if isempty(bound)
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			ave = sum(y)/length(y);
			CP.Results = [CP.Results,ave];
		end
		f = 0;
	else
		display('boundary is set wrong');
		f = -1;
	end
end

