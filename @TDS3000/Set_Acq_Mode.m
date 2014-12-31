function f = Set_Acq_Mode(TDS,ACQ) %1 Sample; 2 peak; 3 average; 4 envelope;
	switch ACQ.Mode
		case 1
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE SAMPLE');
		case 2
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE PEAKDETECT');
		case 3
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE AVERAGE');
			fwrite(TDS.gpib_obj,['ACQUIRE:NUMAVG ',num2str(ACQ.NumAvg)]);
		case 4
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE ENVELOPE');
			fwrite(TDS.gpib_obj,['ACQUIRE:NUMENV ',num2str(ACQ.NumEnv)]);
		otherwise
			fwrite(TDS.gpib_obj,'ACQUIRE:MODE SAMPLE');
	end
	fwrite(TDS.gpib_obj,['ACQUIRE:STOPAFTER ',ACQ.StopA]); % RUN | STOP
	fwrite(TDS.gpib_obj,['ACQUIRE:STATE ',ACQ.State]); % RUNSTOP | SEQ
	f = 1;
end
