function f = setD(MLS,d)
	MLS.d = d;
	if (length(MLS.epsilon)-2 ~= length(MLS.d))
		display('WARNING: length of epsilon array is different from length of layer thickness array');
	end
end
