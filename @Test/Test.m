classdef Test < handle
	properties (SetAccess = protected, GetAccess = public)
		T_Timer = timer; 
		Tonotify = [];
    end
	events
		eTesttestmessage;
	end
	methods 
		function T = Test(tonotify)
			T.Tonotify = [T.Tonotify,T,tonotify];
%			T.addSelfToNotify(tonotify);
			addlistener(T,'eTesttestmessage',@T.T_Callback);
		end
		f = addSelfToNotify(T,tonotify);
		f = startTimer(T);
		f = stopTimer(T);
		f = T_TimerFcn(T,obj,event);
		f = T_Callback(T,obj,event);
	end
end
