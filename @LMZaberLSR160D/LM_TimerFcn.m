function LM_TimerFcn(LM,hObject,eventdata)
	% LM_TimerFcn(obj,event) - Timer function called by timer
	Pos = LM.Getposition;
	if LM.currentPosition ~= Pos
		LM.currentPosition = Pos;
		notify(LM.Tonotify,'eLMZaberLSR160DPositionChanged');
	end
	oldReady = LM.ready;
	LM.Checkready;
	if (oldReady == false && LM.ready == true)
		notify(LM.Tonotify,'eLMZaberLSR160DReady');
	end
end
