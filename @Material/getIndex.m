function f = getIndex(MT,material,prop)
	switch material
		case {'Ag','Al','Au','SiO2','Ge15A','Ge31A','Ge160A','SiO2165A','SiO2242A'}
			A = strcmp({MT.materialList.name}, material);
			B = find(A==1);
			data = MT.materialList(B).data;
			n = interp1(data(:,1),data(:,2),prop);
			k = interp1(data(:,1),data(:,3),prop);
			f.n = n;
			f.k = k;
		case {'Graphene_model'}
			lambda = prop(1);
			tao = prop(2);
			Gamma = prop(3);
			Ef = prop(4);
			d = prop(5);
			q = 1.602e-19;
			hb = 1.0546e-34;
			w = 3e8*2*pi/lambda;
			f2 = q^2/8/hb*(tanh((hb*w+2*abs(Ef))/Gamma)+tanh((hb*w-2*abs(Ef))/Gamma));
			sg1 = f2 + q^2*Gamma/2/pi/hb^2*(1/tao)/(w^2+(1/tao)^2)*log(2*cosh(2*Ef/Gamma));
			dw = 1e10;
			ww = [0:dw:10*w];
			tt = q^2/8/hb*(tanh((hb*ww+2*abs(Ef))/Gamma)+tanh((hb*ww-2*abs(Ef))/Gamma));
			ff = sum((tt-f2)./(ww.^2-w^2))*dw;
			sg2 = -2*w/pi*ff + q^2*Gamma/2/pi/hb^2*w/(w^2+(1/tao)^2)*log(2*cosh(2*Ef/Gamma));
			eps0 = 8.854e-12;
			epsilon = 1+1j*(sg1+1j*sg2)/w/eps0/d;
			index = sqrt(epsilon);
			f.n = real(index);
			f.k = imag(index);
			f.sg1 = sg1;
			f.sg2 = sg2;
		otherwise
			display('material not found');
	end
end

