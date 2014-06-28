function f = ShowLayout(PM,hPanel);
	if (~exist('hPanel'))
		hPanel = figure('Position',[0,0,256,192]);
		movegui(hPanel,'center');
	end
	hWavelength_Text = uicontrol(hPanel,'Style','text',...
                              'String','Wavelength(nm)','Units','Normalized',...
                              'Position',[0.1,0.8,0.4,0.1]);
%	hRange_Text = uicontrol(hPanel,'Style','text',...
%                              'String','Measure Range','Units','Normalized',...
%                              'Position',[0.01,0.6,0.3,0.1]);
	hAverage_Time_Text = uicontrol(hPanel,'Style','text',...
                              'String','Average Time(s)','Units','Normalized',...
                              'Position',[0.1,0.6,0.4,0.1]);
	hPower_Read_Text = uicontrol(hPanel,'Style','text',...
                              'String','Power','Units','Normalized',...
                              'Position',[0.1,0.4,0.4,0.1]);
	hPower_Text = uicontrol(hPanel,'Style','text',...
                              'String','N/A','Units','Normalized',...
                              'Position',[0.53,0.4,0.4,0.1]);

	hPower_Read_Set = uicontrol(hPanel,'Style','pushbutton',...
                             'String','Read','Units','Normalized',...
                             'Position',[0.1,0.1,0.4,0.2],...
			     'CallBack',{@Power_Read_Callback});
	hWavelength_Edit = uicontrol(hPanel,'Style','edit',...
                              'String','N/A','Units','Normalized',...
                              'Position',[0.53,0.8,0.4,0.1],...
			      'CallBack',{@Wavelength_Callback});
%	hRange_Edit = uicontrol(hPanel,'Style','edit',...
%                              'String','N/A','Units','Normalized',...
%                              'Position',[0.3,0.6,0.3,0.1]);
	hAverage_Time_Edit = uicontrol(hPanel,'Style','edit',...
                              'String','1','Units','Normalized',...
                              'Position',[0.53,0.6,0.4,0.1],...
			      'CallBack', {@Average_Time_Callback});

%	hRange_Set = uicontrol(hPanel,'Style','pushbutton',...
%                              'String','Set','Units','Normalized',...
%                              'Position',[0.65,0.6,0.1,0.1],...
%                              'CallBack',{@Range_Callback}); %--Callback

	hPMConnect_Connect = uicontrol(hPanel,'Style','pushbutton',...
                           'String','Connect','Units','Normalized',...
                           'Position',[0.53,0.1,0.4,0.2],...
                           'CallBack',{@PMConnect_Callback}); 
	hType = get(hPanel,'Type');
	if (strcmp(hType, 'uipanel')) 
	        set(hPanel,'Title','NewPort 1931 Power Meter');
	end
	PM.handles.hWavelength_Text = hWavelength_Text;
	PM.handles.hAverage_Time_Text = hAverage_Time_Text;
	PM.handles.hPower_Read_Text = hPower_Read_Text;
	PM.handles.hPower_Read_Set = hPower_Read_Set;
	PM.handles.hWavelength_Edit = hWavelength_Edit;
	PM.handles.hAverage_Time_Edit = hAverage_Time_Edit;
	PM.handles.hPMConnect_Connect = hPMConnect_Connect;

	function PMConnect_Callback(hObject,eventdata)
		if strcmp(PM.Status,'closed')
			PM.Connect;
			PM.Get_Wavelength;
			PM.Get_Power;
			pause(0.1);
			PM.Update
			if strcmp(PM.Status,'open')
				set(PM.handles.hPMConnect_Connect,'String','Disconnect');
				start(PM.PM_Timer);
			end
		else
			stop(PM.PM_Timer);
			PM.Disconnect;
			if strcmp(PM.Status,'closed')
				set(PM.handles.hPMConnect_Connect,'String','Connect');
			else
				start(PM.PM_Timer);
			end
			
		end
	end
	
	function Average_Time_Callback(hObject,eventdata)
		time = get(PM.handles.hAverage_Time_Edit,'String');
		PM.Set_Average_Time(str2num(time));
		PM.Update;
	end

	function Wavelength_Callback(hObject,eventdata)
		wavelength = get(PM.handles.hWavelength_Edit, 'String');
		PM.Set_Wavelength(str2num(wavelength));
		PM.Update;
	end
	function Power_Read_Callback(hObject,eventdata)
		PM.Get_Power;
		PM.Update;
	end
end
