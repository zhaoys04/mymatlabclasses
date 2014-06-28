function f = GetPeaks(CP,bound,curvs)
	CP.Results = [];
	CP.Results.x = [];
	CP.Results.y = [];
	if length(bound) == 2
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			L = (x<=bound(2) & x>=bound(1));
			x = x(L);
			y = y(L);
			dy = (y(3:end)-y(1:end-2))/2;
			dy_x = x(2:end-1);
			L1 = (dy >=0);
			L2 = (dy <=0);
			L = [0,L1(1:end-1)];
			L = (L& L2);
			y = y(2:end-1);
			ind = find(L == 1);
			for l = 1:length(ind)
				ind2(1) = ind(l) - 1;
				ind2(2) = ind(l);
				ind2(3) = ind(l) + 1;
				if ind2(1) <= 0
					ind2(1) = 0;
				end
				if ind2(3) > length(dy_x)
					ind2(3) = length(dy_x);
				end
				[m in] = max(y(ind2));
				ind(l) = ind2(in);
			end
			rx_high = dy_x(ind);
			ry_high = y(ind);

			L = [0,L2(1:end-1)];
			L = (L& L1);
			ind = find(L == 1);
			for l = 1:length(ind)
				ind2(1) = ind(l) - 1;
				ind2(2) = ind(l);
				ind2(3) = ind(l) + 1;
				if ind2(1) <= 0
					ind2(1) = 0;
				end
				if ind2(3) > length(dy_x)
					ind2(3) = length(dy_x);
				end
				[m in] = min(y(ind2));
				ind(l) = ind2(in);
			end
			rx_low = dy_x(ind);
			ry_low = y(ind);
			rx = [rx_high,rx_low];
			ry = [ry_high,ry_low];
			[rx, ind] = sort(rx);
			ry = ry(ind);
			CP.Results.x = [CP.Results.x,{rx}];
			CP.Results.y = [CP.Results.y,{ry}];
		end
		f = 0;
	else if isempty(bound)
		for i = 1:length(curvs)
			x = CP.Curves.x{curvs(i)};
			y = CP.Curves.y{curvs(i)};
			dy = (y(3:end)-y(1:end-2))/2;
			dy_x = x(2:end-1);
			L1 = (dy >=0);
			L2 = (dy <=0);
			L = [0,L1(1:end-1)];
			L = (L& L2);
			y = y(2:end-1);
			ind = find(L == 1);
			for l = 1:length(ind)
				ind2(1) = ind(l) - 1;
				ind2(2) = ind(l);
				ind2(3) = ind(l) + 1;
				if ind2(1) <= 0
					ind2(1) = 0;
				end
				if ind2(3) > length(dy_x)
					ind2(3) = length(dy_x);
				end
				[m in] = max(y(ind2));
				ind(l) = ind2(in);
			end
			rx = dy_x(ind);
			ry = y(ind);

			L = [0,L2(1:end-1)];
			L = (L& L1);
			ind = find(L == 1);
			for l = 1:length(ind)
				ind2(1) = ind(l) - 1;
				ind2(2) = ind(l);
				ind2(3) = ind(l) + 1;
				if ind2(1) <= 0
					ind2(1) = 0;
				end
				if ind2(3) > length(dy_x)
					ind2(3) = length(dy_x);
				end
				[m in] = min(y(ind2));
				ind(l) = ind2(in);
			end
			rx_low = dy_x(ind);
			ry_low = y(ind);
			rx = [rx_high,rx_low];
			ry = [ry_high,ry_low];
			[rx, ind] = sort(rx);
			ry = ry(ind);
			CP.Results.x = [CP.Results.x,{rx}];
			CP.Results.y = [CP.Results.y,{ry}];
		end
		f = 0;
	else
		f = -1;
	end
end
