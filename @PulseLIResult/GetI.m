function f = GetI(LI)
	LI.hCurrentSource.Get_Current;
	f = LI.hCurrentSource.Current_Output;
end
