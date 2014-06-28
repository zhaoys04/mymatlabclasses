function AddCheckbox(CBP,TextString)
	ch = uicontrol('Parent',CBP.handles.hContainer,'style','checkbox','String',TextString,'Value',1,'Callback',{@CheckboxCallback});
	CBP.chs = [CBP.chs,ch];
	CBP.LayoutCheckboxes();
	CBP.UpdateSlider();

	function CheckboxCallback(hObject,eventdata)
		CBP.GetChecks();
	end
end
