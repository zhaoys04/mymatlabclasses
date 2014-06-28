function f = GetV(LI)
	LI.hCurrentSource.Get_Voltage;
	f = LI.hCurrentSource.Voltage;
end
