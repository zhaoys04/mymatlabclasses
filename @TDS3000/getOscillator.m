channels = [1 2]; %[1] [2] [1 2]

device_obj = gpib('ni',0,7,'InputBufferSize',90000);
fopen(device_obj);
pause(0.5);
fwrite(device_obj,'DIS:INTENSIT:BACKL LOW');
fwrite(device_obj,'DIS:INTENSIT:WAVE 1');
pause(2);

%%
  tds = device_obj;
  ch1=sum((channels==1));
  ch2=sum((channels==2));
  data_num=10000;
  TDS_WIDTH=2;
  binaryconv = sparse(1:data_num, 1:2:data_num*2, bitshift(1,8)*ones(1,data_num), data_num, data_num*2)...
               +sparse(1:data_num, 2:2:data_num*2, ones(1,data_num), data_num, data_num*2);
  if (ch1>0)
    cmd = 'HDR OFF;:WFMPRE:CH1:YOFF?;YMULT?;YZERO?;XINCR?;XZERO?;PT_OFF?';
    reply=query(tds,cmd);
    values = sscanf(reply, '%f;%f;%f;%f;%f;%i');
    display(values);
    yoff1 = values(1);
    ymult1 = values(2);
    yzero1 = values(3);
    xincr1 = values(4);
    xzero1 = values(5);
    pt_off1 = values(6);
    fwrite(tds,'DAT:SOU CH1;ENC RIB;WID 2;STAR 1;STOP 10000');
    cmd = 'HDR OFF;:CURVE?';
    fwrite(tds,cmd);
    reply=fscanf(tds,'%c',1);
    reply=fscanf(tds,'%c',1);
    length_numbytes = str2num(reply);
    reply=fscanf(tds,'%c',length_numbytes);
    length_data = str2num(reply);
    reply=fread(tds,length_data);
    wfmbytes = double(reply); 
    reply=fscanf(tds,'%c',1);
    bytes=wfmbytes;
    binary = (binaryconv * bytes)';
    for i=1:length(binary),
        if bitand(bitshift(1,8*TDS_WIDTH-1), binary(i))
           binary(i) = -1*(bitcmp(binary(i),8*TDS_WIDTH)+1);
        end
     end
     time1 = xzero1 + xincr1.*(1:length(binary)-pt_off1);
     volt1 = yzero1 + ymult1.*(binary-yoff1);
     msgcmd = sprintf('MESS:BOX 280,20,520,90;SHOW "%s";STATE %i', sprintf(''), 0);
     fwrite(tds,msgcmd);
     DataCh1 = [time1;volt1];
  else 
      time1=0;
      volt1=0;
      DataCh1 = [time1;volt1];
  end
  if (ch2>0)
      cmd = 'HDR OFF;:WFMPRE:CH2:YOFF?;YMULT?;YZERO?;XINCR?;XZERO?;PT_OFF?';
      reply=query(tds,cmd);
      values = sscanf(reply, '%f;%f;%f;%f;%f;%i');
      display(values);
      yoff2 = values(1);
      ymult2 = values(2);
      yzero2 = values(3);
      xincr2 = values(4);
      xzero2 = values(5);
      pt_off2 = values(6);
      cmd = 'DAT:SOU CH2;ENC RIB;WID 2;STAR 1;STOP 10000';
      fwrite(tds,cmd);
      cmd = 'HDR OFF;:CURVE?';
      fwrite(tds,cmd);
      reply=fscanf(tds,'%c',1);
      reply=fscanf(tds,'%c',1);
      length_numbytes = str2num(reply);
      reply=fscanf(tds,'%c',length_numbytes);
      length_data = str2num(reply);
      reply=fread(tds,length_data);
      wfmbytes = double(reply);
      reply=fscanf(tds,'%c',1);
      bytes=wfmbytes;
      binary = (binaryconv * bytes)';
      for i=1:length(binary),
          if bitand(bitshift(1,8*TDS_WIDTH-1), binary(i))
              binary(i) = -1*(bitcmp(binary(i),8*TDS_WIDTH)+1);
          end
      end
      time2 = xzero2 + xincr2.*(1:length(binary)-pt_off2);
      volt2 = yzero2 + ymult2.*(binary-yoff2); 
      DataCh2 = [time2;volt2];
  else
      time2=0;
      volt2=0;
      DataCh2 = [time2;volt2];
  end


%%
fclose(device_obj);

if(ch1)
figure;
plot(DataCh1(1,:),DataCh1(2,:));
title('channel 1');
end

if(ch2)
figure;
plot(DataCh2(1,:),DataCh2(2,:));
title('channel 2');
end

% figure;
% plot(DataCh2(1,:),Datach2(2,:));
% title('channel 2');
