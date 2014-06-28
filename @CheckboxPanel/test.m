function f = test()
	hPanel = figure('Position',[0 0 640 480],'Visible','off');
	movegui(hPanel,'center');
	V1 = uiextras.VBox('Parent',hPanel);
	htest = uipanel('Parent',V1,'title','Test Component','Units','pixel','ResizeFcn',{@ResizeCallback});
	pos = get(htest,'Position');
	hSlider = uicontrol('Parent',htest,'style','slider','Units','pixel','Position',[pos(1)+pos(3)-20,pos(2),18,pos(4)-12]);
	ht1 = uicontrol('Parent',htest,'style','checkbox','String','test1');
	ht2 = uicontrol('Parent',htest,'style','checkbox','String','test2');
	ht3 = uicontrol('Parent',htest,'style','checkbox','String','test3');
	ht4 = uicontrol('Parent',htest,'style','checkbox','String','test4');
	LayoutCheckboxes();
	UpdateSlider();
	set(hPanel,'Visible','on');

	function ResizeCallback(hObject,eventdata)
		pos = get(htest,'Position');
		set(hSlider,'Position',[pos(1)+pos(3)-20,pos(2),18,pos(4)-12]);
		LayoutCheckboxes();
		UpdateSlider();
	end
	function LayoutCheckboxes()
		chs = findobj(htest,'style','checkbox');
		pos = get(htest,'Position');
		for i = 1:length(chs)
			set(chs(i),'Units','pixel','Position',[pos(1)+2,pos(2)+pos(4)-10-(length(chs)-i+1)*25,pos(3)-30,20]);
		end
	end
	function UpdateSlider()
		chs = findobj(htest,'style','checkbox');
		pos = get(htest,'Position');
		if (25*length(chs) + 10 < pos(4) - 10)
			set(hSlider,'Visible','off');
		else
			set(hSlider,'Visible','on');
		end
	end
end
