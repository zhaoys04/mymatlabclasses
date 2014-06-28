clear;
pause(2);
display('start');
tls=gpib('ni',0,20);
tds=gpib('ni',0,7,'InputBufferSize',90000);
fopen(tls);
fopen(tds);
fwrite(tls,':POW:STAT 0');                    %turn the laser off
fwrite(tds,'DIS:INTENSIT:BACKL LOW');         %set the back light intensity
fwrite(tds,'DIS:INTENSIT:WAVE 1');            %set the waveform brightness
pause(2);

TIMEDIVS=[2e-9,4e-9,10e-9,20e-9,40e-9,100e-9,200e-9,400e-9,1e-6,2e-6,...
    4e-6,10e-6,20e-6,40e-6,100e-6,200e-6,400e-6,1e-3,2e-3,4e-3,10e-3,...
    20e-3,40e-3,100e-3,200e-3,400e-3,1,2,4,10];
start_wavelength=1550;
stop_wavelength=1580;
step_wavelength=0.2;
sweep_speed=20;                               %nm/s
laser_power=0.05e-3;                             %W
timediv=step_wavelength/sweep_speed/10;       %Find the timediv to match 
                                              %sweep speed
L=(TIMEDIVS>timediv);
L=find(L==1);
timediv=TIMEDIVS(L(1));
start_points=[start_wavelength:step_wavelength:stop_wavelength];
fwrite(tls,[':pow ',num2str(laser_power)]);
display(['laser power=',query(tls,':pow?')]);
data_num=10000;
Navg=20;
fwrite(tds,'SELECT:CH1 ON');
fwrite(tds,'SELECT:CH2 OFF');
fwrite(tds,['HOR:MAI:SCA ',num2str(timediv)]);%main base time per division
display(['timediv=',query(tds,'HOR:MAI:SCA?')]); 
cmd = 'HOR:RECORDL 10000';                    %record length 500 or 10000
fwrite(tds,cmd);
cmd = 'HOR:DEL:STATE 0;TIM 0.0E0';            %delay the acquisition 
                                             %relative to the trigger event
                                             %delay time in seconds
fwrite(tds,cmd);
cmd = sprintf('ACQ:MOD AVE;NUMAV %i;STOPA SEQ', Navg);
              %acquisition mode average(ENV enelope), tell the tds when to
              %stop taking acquisition
fwrite(tds,cmd);
fwrite(tds,'HOR:TRIG:POS 10');  %sets or return the position of the trigger
                              %. This is only applied when delay mode is
                              %off 0 to 100% is the amount of pretrigger
                              %information in the waveform.
%-------tunable laser set-----------
fwrite(tls,':WAV:SWE:CYCL 100');
fwrite(tls,':WAV:SWE:MODE CONT');
fwrite(tls,[':WAV:SWE:SPE ',num2str(sweep_speed),'nm/s']);
fwrite(tls,':TRIG:OUTP SWST');%output trigger, start a sweep cycle
%-----background voltage----------
display('measuring background voltage');
fwrite(tds,'TRIG:A:EDG:SOU EXT'); %external trigger source
fwrite(tds,'TRIG:A:LEV 1');       %trigger level in volts
cmd=sprintf(':WAV:SWE:STAR %fnm',start_points(1));
display(cmd);
fwrite(tls,cmd);
cmd=sprintf(':WAV:SWE:STOP %fnm',start_points(1)+step_wavelength);
display(cmd);
fwrite(tls,cmd);
fwrite(tls,':WAV:SWE STAR');
[time1,volt1,time2,volt2]=gettds(tds,1);
fwrite(tls,':WAV:SWE STOP');
bkvolt=sum(volt1)/length(volt1);
fwrite(tls,':POW:STAT 1');
display('done');
pause(2);
%---------------
result=[];
%-----------setting wavelength sweep parameters-------
for m=1:length(start_points)-1
    display(start_points(m));
    cmd=sprintf(':WAV:SWE:STAR %fnm',start_points(m));
    fwrite(tls,cmd);
    cmd=sprintf(':WAV:SWE:STOP %fnm',start_points(m+1));
    fwrite(tls,cmd);
    fwrite(tls,':WAV:SWE STAR');
    [time1,volt1,time2,volt2]=gettds(tds,1);
 %   plot(time1,volt1);
    fwrite(tls,':WAV:SWE STOP');
 %  pause;
    start_point=find(time1>=0);
    end_time=step_wavelength/sweep_speed;
    stop_point=find(time1>=end_time);
    if (isempty(stop_point))
        display('out of measurement scope, please check the time/div');
        break;
    end
    result=[result,volt1(start_point(1):stop_point(1))];
end
wavelength=[start_points(1):...
    (start_points(end)-start_points(1))/length(result):start_points(end)];
wavelength=wavelength(1:end-1);
r=result-abs(bkvolt);
r=r/max(abs(r));
%r=r/min(r);
l=floor(length(r)/10);
r1=zeros(1,l);
for i=1:10
    r1=r(i:10:l*10)+r1;
end
r1=r1/10;
wavelength1=wavelength(5:10:l*10);
figure
plot(wavelength1,10*log10(abs(r1)),'-','linewidth',2);
set(gca,'fontsize',14);
set(gca,'LineWidth',2);
%plot(wavelength1,r1);
xlabel('Wavelength/nm','fontsize',16);
ylabel('Transmission/dB','fontsize',16);
%ylabel('voltage / V');
fwrite(tds,'DIS:INTENSIT:BACKL MED');
fwrite(tds,'DIS:INTENSIT:WAVE 60');
fwrite(tds,'MESS:STATE OFF');
fwrite(tds,'ACQ:STATE RUN');
fclose(tls);
fclose(tds);
