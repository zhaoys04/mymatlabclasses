function f = LayoutCheckboxes(CBP)
	pos = get(CBP.handles.hContainer,'Position');

	st = ceil((length(CBP.chs)*25+10-pos(4))/25)+1;
	if (st < 1 )
		st = 1;
	end
	st = st - st*CBP.slider_value;
	st = ceil(st);
	j = 1;
	for i = 1:length(CBP.chs)
		if (i < st || (i-st)*25+10 > pos(4))
			set(CBP.chs(i),'Visible','off');
		else
			stPos = [pos(1)+2,pos(4)-10-j*25,pos(3)-30,20];
			set(CBP.chs(i),'Visible','on','Units','pixel','Position',stPos);
			j = j + 1;
		end
	end
end
