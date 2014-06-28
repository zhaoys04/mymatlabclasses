function f = TimerFcn(RT,hObject,eventdata)
	% TimerFcn(obj,event) - Timer function called by timer
	oldPosition = RT.currentPosition;
	RT.currentPosition = RT.Getposition;
	if (oldPosition ~= RT.currentPosition)
	notify(RT.Tonotify,'eRTThorlabsCR1Z7PositionChanged');
	end
end
