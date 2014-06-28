function f = AddCurve(CP,x,y)
	if length(x) == length(y)
		CP.Curves.x = [CP.Curves.x,{x}];
		CP.Curves.y = [CP.Curves.y,{y}];
		f = 0;
	else
		display('dimensions of x and y are not the same. Will truncate according to the shorter one from the end.');
		len = min(length(x),length(y));
		CP.Curves.x = [CP.Curves.x,{x(1:len)}];
		CP.Curves.y = [CP.Curves.y,{y(1:len)}];

		f = -1;
	end
end

