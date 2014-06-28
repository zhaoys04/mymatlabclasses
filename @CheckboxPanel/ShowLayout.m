function ShowLayout(CBP,hPanel)
	hContainer = uipanel('Parent',hPanel,'title',CBP.Title,'Units','pixel','ResizeFcn',{@ResizeCallback});
	pos = get(hContainer,'Position');
	set(hPanel,'Units','pixel');
	hSlider = uicontrol('Parent',hContainer,'style','slider','Units','pixel','Position',[pos(1)+pos(3)-20,pos(2),18,pos(4)-12],'Min',0,'Max',1,'Value',1,'Callback',{@SliderCallback});
	CBP.handles.hContainer = hContainer;
	CBP.handles.hSlider = hSlider;
	CBP.LayoutCheckboxes();
	CBP.UpdateSlider();
	function ResizeCallback(hObject,eventdata)
		basepos = get(hPanel,'Position');	
		pos = get(hContainer,'Position');
		pos(1) = pos(1) + basepos(1);
		pos(2) = pos(2) + basepos(2);
		stPos = [pos(3)-20,1,18,pos(4)-12];
		set(hSlider,'Position',stPos);
		CBP.LayoutCheckboxes();
		CBP.UpdateSlider();
	end
	function SliderCallback(hObject, eventdata)
		CBP.slider_value = get(hSlider,'Value');
		CBP.LayoutCheckboxes();
	end
end
