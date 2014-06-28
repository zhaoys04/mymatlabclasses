function f = GetChecks(CBP)
	CBP.cks = [];
	for i = 1:length(CBP.chs)
		CBP.cks = [CBP.cks,get(CBP.chs(i),'Value')];
	end
	notify(CBP.Tonotify,'eCheckboxChecksChanged');
end
