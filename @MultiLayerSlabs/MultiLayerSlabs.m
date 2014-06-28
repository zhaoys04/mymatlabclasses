classdef MultiLayerSlabs<handle
	% MultiLayerSlabs
	%
	% This class provides general methods for solving optical properties of Multilayer structure
	%
	% Notice: phaser in this class is exp(1j*beta). So if you are going to use complex refractive index, make sure the imaginary part is positive to guarantee the convergence. 
	%
	% MultiLayerSlabs Methods:
	% 	getRT(wavelength, nkx): return the reflection and transmission coefficient at given wavelength and incident angle;
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
				otherwise
					MLS.epsilon = [1, 1.2,1];
					MLS.d = 1;
			end
		end
		[R T] = getRT(MLS, wavelength, nkx);
		[v,neff] = fempml(MLS,TETM, wavelength, npml,nsol,maxbeta);
	end
end
