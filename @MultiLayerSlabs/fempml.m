function [v,neff] = fempml(MLS,TETM, wavelength, npml,nsol,maxbeta)
	jone = complex(0,1);
	nref2 = MLS.epsilon;
	nsize = size(nref2);
	kmsq = (2*acos(-1)/wavelength)^2;
	kmag = sqrt(kmsq);


	% define maxmimum beta^2

	lamsqmax = (maxbeta*kmag)^2;

% define element matrices for p, q, and r calculations

	m1 = [1 -1;-1 1];
	m2 = [2 1;1 2];

% define PML for npml points
	gamma=ones(nsize(1),1);
	for i=1:npml
		sigmax = ((npml+1-i)/npml).^4;
		gamma(i) = (1-jone*sigmax.*376.7343/(nref2(1+npml)*kmag));
		gamma(nsize(1)-i+1) = (1-jone*sigmax.*376.7343/(nref2(nsize(1)-npml)*kmag));
	end


% define local matrices for each element

	if(TETM==1)
		'TE Computation'
		for i=1:nsize(1)
    
			test(i).ldat = delta(i);
			test(i).mp = (-1/(delta(i)*gamma(i)))*m1;
			test(i).mq = (gamma(i)*kmsq*nref2(i)*delta(i)/6)*m2;
			test(i).mr = (gamma(i)*delta(i)/6)*m2;

		end
	else
		'TM Computation'
		for i=1:nsize(1)
    
			test(i).ldat = delta(i);
			test(i).mp = (-1/(nref2(i)*delta(i)*gamma(i)))*m1;
			test(i).mq = (gamma(i)*kmsq*delta(i)/6)*m2;
			test(i).mr = (gamma(i)*delta(i)/(6*nref2(i)))*m2;
		end
	end
% allocate sparse matrices

	pglobal = spalloc(nsize(1)+1,nsize(1)+1,3*nsize(1)+1);
	qglobal = spalloc(nsize(1)+1,nsize(1)+1,3*nsize(1)+1);
	rglobal = spalloc(nsize(1)+1,nsize(1)+1,3*nsize(1)+1);

% fill global matrices from local matrices

	pglobal(1,1) = test(i).mp(1,1);
	qglobal(1,1) = test(i).mq(1,1);
	rglobal(1,1) = test(i).mr(1,1);
	pglobal(1,2) = test(i).mp(1,2);
	qglobal(1,2) = test(i).mq(1,2);
	rglobal(1,2) = test(i).mr(1,2);

	for i=2:nsize(1)
    
		pglobal(i,i) = test(i-1).mp(2,2)+test(i).mp(1,1);
		qglobal(i,i) = test(i-1).mq(2,2)+test(i).mq(1,1);
		rglobal(i,i) = test(i-1).mr(2,2)+test(i).mr(1,1);
    
		pglobal(i,i+1) = test(i).mp(1,2);
		pglobal(i,i-1) = test(i-1).mp(2,1);
		qglobal(i,i+1) = test(i).mq(1,2);
		qglobal(i,i-1) = test(i-1).mq(2,1);
		rglobal(i,i+1) = test(i).mr(1,2);
		rglobal(i,i-1) = test(i-1).mr(2,1);
     
	end

	pglobal(nsize(1)+1,nsize(1)+1) = test(nsize(1)).mp(2,2);
	qglobal(nsize(1)+1,nsize(1)+1) = test(nsize(1)).mq(2,2);
	rglobal(nsize(1)+1,nsize(1)+1) = test(nsize(1)).mr(2,2);
	pglobal(nsize(1)+1,nsize(1)) = test(nsize(1)).mp(2,1);
	qglobal(nsize(1)+1,nsize(1)) = test(nsize(1)).mq(2,1);
	rglobal(nsize(1)+1,nsize(1)) = test(nsize(1)).mr(2,1);


% compute the eigenvalues and eigenvectors

	opts.tol = 1.e-19;
	[v,d] = eigs((pglobal+qglobal),rglobal,10,lamsqmax,opts);


	for i=1:10
		neff(i,1)=sqrt(d(i,i))/kmag;
		if(abs(imag(neff(i,1))) > 1.e-5)
		%       neff(i,1) = 0.0;
		end
	end
end

