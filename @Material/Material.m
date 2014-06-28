classdef Material < handle
	% Material
	%
	% This class provides optical refractive index of various material on
	% specified wavelength
	%
	% Material Properties:
	%
	% Material Events:
	%
	% Material Methods:
	%
	% Example:
	% 	MT = Material();
	%
	properties (SetAccess = protected, GetAccess = public)
		materialList;
	end
	methods 
		function MT = Material()
			MT.materialList = [];
			MT.initialize();
		end
		f = initialize(MT);
		f = getIndex(MT,material,prop);
		f = help(MT,name);
	end
end
