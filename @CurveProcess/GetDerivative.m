function f = GetDerivative(CP,curvs)
	CP.Results = [];
	CP.Results.x = [];
	CP.Results.y = [];
	for i = 1:length(curvs)
		x = CP.Curves.x{curvs(i)};
		y = CP.Curves.y{curvs(i)};
		dy = (y(3:end)-y(1:end-2))./(x(3:end)-x(1:end-2));
		dy_x = x(2:end-1);
		CP.Results.x = [CP.Results.x, {dy_x}];
		CP.Results.y = [CP.Results.y, {dy}];
	end
end
