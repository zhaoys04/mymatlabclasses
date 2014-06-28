function f = Temperature_Stable(TC)

   % 0 Out of range > 10K
   % 1 Approaching <10K >1K
   % 2 Stablizing <1K >0.1K
   % 3 Delay <0.1K
   % 4 Stable
   if abs(TC.Temperature_Read-TC.Temperature_Set) > 10
	   TC.Stable = 0;
	   stop(TC.TC_Stable_Timer);
   else if abs(TC.Temperature_Read-TC.Temperature_Set) > 1
	   	TC.Stable = 1;
		stop(TC.TC_Stable_Timer);
	else if abs(TC.Temperature_Read-TC.Temperature_Set) > 0.1
	   	TC.Stable = 2;
		stop(TC.TC_Stable_Timer);
	     else if (TC.Stable ~= 3 && TC.Stable ~=4)
		     TC.Stable = 3;
		     start(TC.TC_Stable_Timer);
	    	  end
	     end
     	end
   end
end
