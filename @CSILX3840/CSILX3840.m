classdef CSILX3840
	properties
		gpib_address;
	end
	properties (SetAccess = protected)
		gpib_obj;
		htest;
	end
	methods 
		function CS = CSILX3840(gpib_address)
			if nargin > 0
				CS.gpib_address = gpib_address;
			else
				CS.gpib_address = 0;
			end
		end
		f = Connect(CS);
		f = Disconnect(CS);
		f = Get_Current(CS);
		f = Set_Current(CS);
		f = Set_Mode(CS);
		f = Get_Mode(CS);
		f = Set_Current_Limit(CS);
		f = Get_Current_Limit(CS);
		f = Set_Output(CS);
	end
end
