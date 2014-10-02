function f = showEps(MLS)
	h = figure;
	d1 = cumsum(MLS.d);
	p = zeros(1,length(d1)*2);
	p(1:2:end) = d1;
	p(2:2:end) = d1;
	p = [-1e-6,0,0,p,p(end)+1e-6];
	e = zeros(1,length(p));
	for (i=1:length(MLS.epsilon))
		e(2*i-1) = MLS.epsilon(i);
		e(2*i) = MLS.epsilon(i);
	end
	figure(h);
	plot(p,e);
end
