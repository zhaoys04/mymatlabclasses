function f = Set_QCW_Mode(CS,Mode)
	m = mod(abs(Mode),2); % 0 constant duty cycle; 1 constant frequency
	CS.QCW.Mode = m;
	f = m;
end
