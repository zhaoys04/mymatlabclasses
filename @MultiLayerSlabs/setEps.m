function f = setEps(MLS,epsilon)
	MLS.epsilon = [MLS.epsilon(1),epsilon,MLS.epsilon(end)];
	if (length(epsilon) ~= length(MLS.d))
		display('WARNING: length of epsilon array is different from length of layer thickness array');
	end
end
