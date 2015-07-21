function f = plotGratingMode(MLS,wavelength,b,x)
	nkx = b;
	E_TE = zeros(1,length(x));
	d = MLS.d*2*pi/wavelength;
	x = x*2*pi/wavelength;
	d0 = 0;
	Ef = 0;
	Eb = 1;
	kz = msqrt(MLS.epsilon(1)-nkx^2);
	L = (x<d0);
	E_TE(L) = Ef*exp(1j*kz*(x(L)-d0))+Eb*exp(-1j*kz*(x(L)-d0));

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
		EE = M1s*[Ef;Eb];
		Ef = EE(1);Eb = EE(2);
		kz = msqrt(MLS.epsilon(i+1)-nkx^2);
		L = (x>=d0 & x<d0+d(i));
		E_TE(L) = Ef*exp(1j*kz*(x(L)-d0))+Eb*exp(-1j*kz*(x(L)-d0));
%		display(kz);
		M2 = [exp(1j*kz*d(i)),0;0,exp(-1j*kz*d(i))];
		EE = M2*[Ef;Eb];
		Ef = EE(1);Eb = EE(2);
		d0 = d0 + d(i);
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
	EE = M1s*[Ef;Eb];
	Ef = EE(1);Eb = EE(2);
	kz = msqrt(MLS.epsilon(N+1)-nkx^2);
	L = (x>=d0);
	E_TE(L) = Ef*exp(1j*kz*(x(L)-d0))+Eb*exp(-1j*kz*(x(L)-d0));
	function f = msqrt(x)
		f = -sqrt(x);
	end
	f = E_TE;
end
