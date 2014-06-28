function f = LM_TimerFcn(LM,hObject,eventdata)
	% LM_TimerFcn(obj,event) - Timer function called by timer
	oldPosition = LM.currentPosition;
	LM.currentPosition = LM.Getposition;
	if oldPosition~=LM.currentPosition
		notify(LM.Tonotify,'eLMThorlabsZ812PositionChanged');
	end
end
