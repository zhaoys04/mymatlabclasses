function f = RemoveCheckbox(CBP,ind)
	display(ind);
	delete(CBP.chs(ind));
	CBP.chs = CBP.chs(~ind);
end
