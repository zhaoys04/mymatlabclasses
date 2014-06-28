function f = UpdateSlider(CBP)
	pos = get(CBP.handles.hContainer,'Position');
	if (25*length(CBP.chs) + 10 < pos(4) - 10)
		set(CBP.handles.hSlider,'Visible','off');
	else
		visible_length = pos(4);
		total_length = 25*length(CBP.chs)+10;
		sliderstep2 = visible_length/(total_length-visible_length);
		if (sliderstep2 < 0.1) 
			sliderstep2 = 0.1;
		end
		set(CBP.handles.hSlider,'Visible','on','sliderstep',[0.1,sliderstep2]);
	end
end
