function f = Set_Acq_Mode(TDS,Mode) %1 Sample; 2 peak; 3 average; 4 envelope;
	switch Mode
		case 1
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE SAMPLE');
		case 2
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE PEAKDETECT');
		case 3
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE AVERAGE');
		case 4
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE ENVELOPE');
		otherwise
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE SAMPLE');
	end
	f = 1;
end
