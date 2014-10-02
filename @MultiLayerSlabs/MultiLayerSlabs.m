classdef MultiLayerSlabs<handle
	% MultiLayerSlabs
	%
	% This class provides general methods for solving optical properties of Multilayer structure
	%
	% Notice: phaser in this class is exp(1j*beta). So if you are going to use complex refractive index, make sure the imaginary part is positive to guarantee the convergence. 
	%
	% MultiLayerSlabs Methods:
	% 	getRT(wavelength, nkx): return the reflection and transmission coefficient at given wavelength and incident angle;
	%	showEps(): plot the epsilon profile of slabs
	%	showInd(): plot the optical index profile of slabs
	%	setEps(epsilon): set the epsilon parameter with the new epsilon. Substrate and cladding epsilon will not be changed
	%	setD(d): set the layer thickness parameter with the new d. 
	%	setSubstrateEps(epsilon): change the substrate epsilon to the new epsilon
	%	setCladdingEps(epsilon): change the cladding epsilon to the new epsilon
	%
	% Example:
	% 	MLS = MultiLayerSlabs(cladding_epsilon, substrate_epsilon,epsilon1,epsilon2,d1,d2,N);
	% 		cladding_epsilon: epsilon for cladding layer
	% 		substrate_epsilon: epsilon for substrate layer
	% 		epsilon1: epsilon for first material
	% 		epsilon2: epsilon for second material
	%		d1: thickness of first layer
	%		d2: thickness of second layer
	%		N: total number of layers
	% 	MLS = MultiLayerSlabs(cladding_epsilon,	substrate_epsilon,epsilon array,layer thickness array);
	% 		cladding_epsilon: epsilon of cladding layer
	% 		substrate_epsilon: epsilon of substrate layer
	% 		epsilon array: epsilon of each layer
	%		layer thickness array: layer thickness of each layer, should have the same length as epsilon array

	properties (SetAccess = protected, GetAccess = public)
		epsilon;
		d;  %actual thickness
	end
	methods 
		function MLS = MultiLayerSlabs(varargin)
			switch nargin
				case 7 % cladding_epsilon, substrat_epsilon,epsilon1,epsilon2,d1,d2,N
					MLS.epsilon = zeros(1,varargin{7});
					MLS.d = zeros(1,varargin{7});
					MLS.epsilon(1:2:varargin{7}) = varargin{3};
					MLS.epsilon(2:2:varargin{7}) = varargin{4};
					MLS.epsilon = [varargin{1}, MLS.epsilon,varargin{2}];
					MLS.d(1:2:varargin{7}) = varargin{5};
					MLS.d(2:2:varargin{7}) = varargin{6};
				case 4 %cladding_epsilon, substrate_epsilon,layer epsilon description, layer thickness description
					MLS.epsilon = varargin{3};
					MLS.d = varargin{4};
					MLS.epsilon = [varargin{1}, MLS.epsilon,varargin{2}];
				otherwise
					MLS.epsilon = [1, 1.2,1];
					MLS.d = 1;
			end
		end
		[R T] = getRT(MLS, wavelength, nkx);
		[v,neff] = fempml(MLS,TETM, wavelength, npml,nsol,maxbeta);
		f = showEps(MLS);
		f = showInd(MLS);
		f = setEps(MLS,epsilon);
		f = setSubstrateEps(MLS,epsilon);
		f = setCladdingEps(MLS,epsilon);
		f = setD(MLS,d);
	end
end
