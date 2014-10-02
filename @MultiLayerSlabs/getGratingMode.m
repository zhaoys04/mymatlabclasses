function f = getGratingMode(MLS,wavelength,b)
% f  = getGratingMode(wavelength, b):
% 	wavelength: wavelength of incident light. Unit should be consist with other length
% 	b: relative/normalized propagation constant. b = beta/k0. This function will find a solution around this given b.
%	return value, the relative propagation constant of the solution mode.
	
	f = fsolve(@nestfunc,b);

	function ff = nestfunc(nkx)
		Ms = diag([1,1]);
		Mp = diag([1,1]);
		d = MLS.d*2*pi/wavelength;
		for i = 1:length(d)
			ts12 = 2*msqrt(MLS.epsilon(i)-nkx^2)/(msqrt(MLS.epsilon(i)-nkx^2)+msqrt(MLS.epsilon(i+1)-nkx^2));
			tp12 = 2*MLS.epsilon(i)*msqrt(MLS.epsilon(i+1)-nkx^2)/(MLS.epsilon(i)*msqrt(MLS.epsilon(i+1)-nkx^2)+MLS.epsilon(i+1)*msqrt(MLS.epsilon(i)-nkx^2));
			rs12 = (msqrt(MLS.epsilon(i)-nkx^2)-msqrt(MLS.epsilon(i+1)-nkx^2))/(msqrt(MLS.epsilon(i)-nkx^2)+msqrt(MLS.epsilon(i+1)-nkx^2));
			rp12 = (MLS.epsilon(i)*msqrt(MLS.epsilon(i+1)-nkx^2)-MLS.epsilon(i+1)*msqrt(MLS.epsilon(i)-nkx^2))/(MLS.epsilon(i)*msqrt(MLS.epsilon(i+1)-nkx^2)+MLS.epsilon(i+1)*msqrt(MLS.epsilon(i)-nkx^2));
			ts21 = 2*msqrt(MLS.epsilon(i+1)-nkx^2)/(msqrt(MLS.epsilon(i+1)-nkx^2)+msqrt(MLS.epsilon(i)-nkx^2));
			tp21 = 2*MLS.epsilon(i+1)*msqrt(MLS.epsilon(i)-nkx^2)/(MLS.epsilon(i+1)*msqrt(MLS.epsilon(i)-nkx^2)+MLS.epsilon(i)*msqrt(MLS.epsilon(i+1)-nkx^2));
			rs21 = (msqrt(MLS.epsilon(i+1)-nkx^2)-msqrt(MLS.epsilon(i)-nkx^2))/(msqrt(MLS.epsilon(i+1)-nkx^2)+msqrt(MLS.epsilon(i)-nkx^2));
			rp21 = (MLS.epsilon(i+1)*msqrt(MLS.epsilon(i)-nkx^2)-MLS.epsilon(i)*msqrt(MLS.epsilon(i+1)-nkx^2))/(MLS.epsilon(i+1)*msqrt(MLS.epsilon(i)-nkx^2)+MLS.epsilon(i)*msqrt(MLS.epsilon(i+1)-nkx^2));
			M1p = [tp12-rp21*rp12/tp21,rp21/tp21;-rp12/tp21,1/tp21];
			M1s = [ts12-rs21*rs12/ts21,rs21/ts21;-rs12/ts21,1/ts21];
			kz = msqrt(MLS.epsilon(i+1)-nkx^2);
	%		display(kz);
			M2 = [exp(1j*kz*d(i)),0;0,exp(-1j*kz*d(i))];
			Ms = M2*M1s*Ms;
			Mp = M2*M1p*Mp;
		end	
		N = length(d)+1;
		ts12 = 2*msqrt(MLS.epsilon(N)-nkx^2)/(msqrt(MLS.epsilon(N)-nkx^2)+msqrt(MLS.epsilon(N+1)-nkx^2));
		tp12 = 2*MLS.epsilon(N)*msqrt(MLS.epsilon(N+1)-nkx^2)/(MLS.epsilon(N)*msqrt(MLS.epsilon(N+1)-nkx^2)+MLS.epsilon(N+1)*msqrt(MLS.epsilon(N)-nkx^2));
		rs12 = (msqrt(MLS.epsilon(N)-nkx^2)-msqrt(MLS.epsilon(N+1)-nkx^2))/(msqrt(MLS.epsilon(N)-nkx^2)+msqrt(MLS.epsilon(N+1)-nkx^2));
		rp12 = (MLS.epsilon(N)*msqrt(MLS.epsilon(N+1)-nkx^2)-MLS.epsilon(N+1)*msqrt(MLS.epsilon(N)-nkx^2))/(MLS.epsilon(N)*msqrt(MLS.epsilon(N+1)-nkx^2)+MLS.epsilon(N+1)*msqrt(MLS.epsilon(N)-nkx^2));
		ts21 = 2*msqrt(MLS.epsilon(N+1)-nkx^2)/(msqrt(MLS.epsilon(N+1)-nkx^2)+msqrt(MLS.epsilon(N)-nkx^2));
		tp21 = 2*MLS.epsilon(N+1)*msqrt(MLS.epsilon(N)-nkx^2)/(MLS.epsilon(N+1)*msqrt(MLS.epsilon(N)-nkx^2)+MLS.epsilon(N)*msqrt(MLS.epsilon(N+1)-nkx^2));
		rs21 = (msqrt(MLS.epsilon(N+1)-nkx^2)-msqrt(MLS.epsilon(N)-nkx^2))/(msqrt(MLS.epsilon(N+1)-nkx^2)+msqrt(MLS.epsilon(N)-nkx^2));
		rp21 = (MLS.epsilon(N+1)*msqrt(MLS.epsilon(N)-nkx^2)-MLS.epsilon(N)*msqrt(MLS.epsilon(N+1)-nkx^2))/(MLS.epsilon(N+1)*msqrt(MLS.epsilon(N)-nkx^2)+MLS.epsilon(N)*msqrt(MLS.epsilon(N+1)-nkx^2));
		M1p = [tp12-rp21*rp12/tp21,rp21/tp21;-rp12/tp21,1/tp21];
		M1s = [ts12-rs21*rs12/ts21,rs21/ts21;-rs12/ts21,1/ts21];
		Ms = M1s*Ms;
		Mp = M1p*Mp;
		ff = Ms(2,2);   % s polarization: TE mode; p polarization: TM mooe
	end
	function f = msqrt(x)
		f = sqrt(x);
	end

end
