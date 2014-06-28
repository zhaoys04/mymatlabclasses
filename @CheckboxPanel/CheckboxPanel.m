classdef CheckboxPanel < handle
	properties (SetAccess = protected, GetAccess = public)
		chs;
		handles;
		slider_value;
		cks;
		Title;
		Tonotify;
	end
	events
		eCheckboxChecksChanged;
	end

	methods 
		function CBP = CheckboxPanel(hPanel,Title)
			CBP.cks = [];
			CBP.chs = [];
			CBP.Tonotify = [];
			CBP.slider_value = 1;
			CBP.Title = Title;
			CBP.ShowLayout(hPanel);
		end

		f = ShowLayout(CBP,hPanel);
		f = AddCheckbox(CBP,TextString);
		f = RemoveCheckbox(CBP,ind);
		f = LayoutCheckboxes(CBP);
		f = UpdateSlider(CBP);
		f = GetChecks(CBP);
		f = Addnotify(CBP,Obj);
	end
end
