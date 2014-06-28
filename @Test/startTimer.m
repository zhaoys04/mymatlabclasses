function f = startTimer(T)
        set(T.T_Timer, 'ExecutionMode','fixedspacing','Period',1,'TimerFcn',@T.T_TimerFcn);
	start(T.T_Timer);
end
