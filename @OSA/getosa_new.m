% get OSA trace
% init variable
%clear;
reply = ' ';

OSA_ID = 23;

osa = gpib('ni',0,OSA_ID);

fopen(osa);

%fwrite(osa,'CLEAR');
%fwrite(osa,'IP');
%fwrite(osa,'CLRDSP');

cmd = 'TDF P;';
fwrite(osa,cmd);

cmd = 'TRDEF TRA?;';
reply = query(osa,cmd);
num_points = str2num(reply);

cmd = 'startwl?;';
reply = query(osa,cmd);
start_wavelength = str2num(reply);

cmd = 'stopwl?;';
reply = query(osa,cmd);
stop_wavelength = str2num(reply);

cmd = 'TRA?;';
fwrite(osa,cmd);
[reply,count] = fscanf(osa);
amp = ['[',reply];
%eos = bitand(double(status), hex2dec('2000'));
while count == 512
  [reply,count]=fscanf(osa);
  if (count==0) break; end
  amp=[amp,reply];
end

amp=[amp,']'];

wavelength = linspace(start_wavelength, stop_wavelength, num_points);
% alternate:  amp = str2num(strrep(amp, ',', ' '));
amm = str2num(amp);
fclose(osa);
figure;
plot(wavelength,amm);
% status = gpib('ibonl', osa, 0);
% 
% figure(1);
% plot(wavelength*1e6, amp);
% xlabel('wavelength (\mum)');
% ylabel('intensity (watts)');
% axis tight;
% grid on;
% 
% timestamp = datestr(now, 30);
% title(['OSA trace ' timestamp ]);
% 
% filename=['OSAtrace' timestamp '.mat'];
% save(filename,'wavelength','amp','timestamp');
% %eval(['save ',fsave,' osaamp osawave']);%
% %osatrace(:,i) = osaamp;
