function f = RemoveCurve(CP,curvs)
	I = [1:length(CP.Curves.x)];
	L = logical(zeros(1,length(I)));
	for i=1:length(curvs)
		L = (L|(I==curvs(i)));
	end
	CP.Curves.x = CP.Curves.x(~L);
	CP.Curves.y = CP.Curves.y(~L);
end
