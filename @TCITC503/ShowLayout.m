function f = ShowLayout(TC,hPanel)
	if (~exist('hPanel'))
		hPanel = figure('Position',[0 0 1024 768]);
		movegui(mPanel,'center');
	end
	hConnect_Text = uicontrol(hPanel,'Style','text',...
                            'String','Temperature Controller NOT Connected','Units','Normalized',...
                            'Position',[0.3,0.85,0.6,0.1],'ForegroundColor','red','Fontweight','bold');

	hConnect_Connect = uicontrol(hPanel,'Style','pushbutton',...
                            'String','Connect','Units','Normalized',...
                            'Position',[0.05,0.85,0.2,0.1],...
                            'CallBack',{@Connect_callback});
	hCurrent_Temp_Text = uicontrol(hPanel,'Style','text',...
                            'String','Current Temp.(K)','Units','Normalized',...
                            'Position',[0.05,0.7,0.3,0.1],'Fontweight','bold');
	hCurrent_Temp_Show = uicontrol(hPanel,'Style','text',...
                            'String','N/A','Units','Normalized',...
                            'Position',[0.36,0.7,0.4,0.1]);
%	hCurrent_Temp_Read = uicontrol(hPanel,'Style','pushbutton',...
%                            'String','Read','Units','Normalized',...
%                            'Position',[0.65,0.7,0.25,0.1],'Fontweight','bold',...
%			    'CallBack',{@Current_Temp_Read_callback});
	hSet_Temp_Text = uicontrol(hPanel,'Style','text',...
                            'String','Set Temp.(K)','Units','Normalized',...
                            'Position',[0.05,0.55,0.3,0.1],'Fontweight','bold');
	hSet_Temp_Edit = uicontrol(hPanel,'Style','edit',...
                            'String','N/A','Units','Normalized',...
                            'Position',[0.36,0.55,0.4,0.1],'Fontweight','bold',...
			    'CallBack',{@Set_Temp_callback});
	hTemp_Stable = uicontrol(hPanel,'Style','text',...
                            'String','Out of Range','Units','Normalized',...
                            'Position',[0.77,0.7,0.2,0.1],'Fontweight','bold');
	hSet_Mode_Text = uicontrol(hPanel,'Style','text',...
                            'String','Mode','Units','Normalized',...
                            'Position',[0.05,0.4,0.3,0.08],'Fontweight','bold');
	hSet_Mode_Popup = uicontrol(hPanel,'Style','popupmenu',...
                            'String',{'N/A','Local&Locked',...
                            'Remote&Locked','Local&Unlocked',...
                            'Remote&Unlocked'},'Units','Normalized',...
                            'Position',[0.36,0.4,0.4,0.08],'Fontweight','bold',...
                            'Callback',{@Set_Mode_callback});
	hSet_Heater_Mode_Text = uicontrol(hPanel,'Style','text',...
                            'String','Heater Mode','Units','Normalized',...
                            'Position',[0.05,0.25,0.3,0.08],'Fontweight','bold');
	hSet_Heater_Mode_Popup = uicontrol(hPanel,'Style','popupmenu',...
                            'String',{'N/A','Heater Manual,Gas Manual',...
                            'Heater Auto,Gas Manual','Heater Manual,Gas Auto',...
                            'Heater Auto,Gas Auto'},'Units','Normalized',...
                            'Position',[0.36,0.25,0.4,0.08],'Fontweight','bold',...
                            'Callback',{@Set_Heater_Mode_callback});
	hSet_Heater_Text = uicontrol(hPanel,'Style','text',...
                            'String','Set Heater Voltage(%)','Units','Normalized',...
                            'Position',[0.05,0.1,0.3,0.1],'Fontweight','bold');
	hSet_Heater_Edit = uicontrol(hPanel,'Style','edit',...
                            'String','N/A','Units','Normalized',...
                            'Position',[0.36,0.1,0.4,0.1],'Fontweight','bold',...
			    'CallBack',{@Set_Heater_callback});
	hType = get(hPanel,'type');
	if (strcmp(hType,'uipanel'))
		set(hPanel,'Title','ITC503 Temperature Controller');
	end
	TC.handles.hConnect_Text = hConnect_Text;
	TC.handles.hConnect_Connect = hConnect_Connect;
	TC.handles.hCurrent_Temp_Text = hCurrent_Temp_Text;
	TC.handles.hCurrent_Temp_Show = hCurrent_Temp_Show;
	TC.handles.hSet_Temp_Text = hSet_Temp_Text;
	TC.handles.hSet_Temp_Edit = hSet_Temp_Edit;
	TC.handles.hSet_Mode_Text = hSet_Mode_Text;
	TC.handles.hSet_Mode_Popup = hSet_Mode_Popup;
	TC.handles.hSet_Heater_Mode_Text = hSet_Heater_Mode_Text;
	TC.handles.hSet_Heater_Mode_Popup = hSet_Heater_Mode_Popup;
	TC.handles.hSet_Heater_Text = hSet_Heater_Text;
	TC.handles.hSet_Heater_Edit = hSet_Heater_Edit;
	TC.handles.hTemp_Stable = hTemp_Stable;

	%---add listeners---
	lh = event.listener(TC,'eTCITC503TemperatureChanged',@TemperatureChangedCallback);
	lh2 = event.listener(TC,'eTCITC503HeaterModeChanged',@HeaterModeChangedCallback);
	lh3 = event.listener(TC,'eTCITC503StableStateChanged',@StableStateChangedCallback);


	function Connect_callback(hObject,eventdata)
		if (TC.gpib_obj==0 || strcmp(TC.gpib_obj.Status,'closed'))
			TC.Connect;
			if strcmp(TC.gpib_obj.Status,'open')
				set(TC.handles.hConnect_Text,'String', 'Temperature Controller is Connected','foregroundcolor','green');
				set(TC.handles.hConnect_Connect,'String','Disconnect');
				TC.Get_All_Modes;
				TC.Get_Temperature;
				Initialize;
				start(TC.TC_Timer);
			end
		else
			stop(TC.TC_Timer);
			TC.Disconnect;
			if strcmp(TC.gpib_obj.Status,'closed')
				set(TC.handles.hConnect_Text,'String', 'Temperature Controller is NOT Connected','foregroundcolor','red');
				set(TC.handles.hConnect_Connect,'String','Connect');
			else
				start(TC.TC_Timer);
			end
		end
	end
%	function Current_Temp_Read_callback(hObject,eventdata)
%		TC.Get_Temperature;
%		set(hCurrent_Temp_Show,'String',num2str(TC.Temperature_Read));
%	end

	function Set_Temp_callback(hObject,eventdata)
		temp = str2num(get(TC.handles.hSet_Temp_Edit,'String'));
		TC.Set_Temperature(temp);
	end

	function Set_Mode_callback(hObject,eventdata)
		str = get(hObject,'String');
		val = get(hObject,'Value');
	        if strcmp(TC.gpib_obj.Status,'open')
			switch str{val}
			case 'N/A'
			case 'Local&Locked'
				TC.Set_Control_Mode(0);
			case 'Remote&Locked'
				TC.Set_Control_Mode(1);
			case 'Local&Unlocked'
				TC.Set_Control_Mode(2);
			case 'Remote&Unlocked'
				TC.Set_Control_Mode(3);
			end	
	        end
	end
	function Set_Heater_Mode_callback(hObject,eventdata)
		str = get(hObject,'String');
		val = get(hObject,'Value');
	        if strcmp(TC.gpib_obj.Status,'open')
			switch str{val}
			case 'N/A'
			case 'Heater Manual,Gas Manual'
				TC.Set_Heater_Mode(0);
				TC.Set_Gas_Flow_Mode(0);
			case 'Heater Auto,Gas Manual'
				TC.Set_Heater_Mode(1);
				TC.Set_Gas_Flow_Mode(0);
			case 'Heater Manual,Gas Auto'
				TC.Set_Heater_Mode(0);
				TC.Set_Gas_Flow_Mode(1);
			case 'Heater Auto,Gas Auto'
				TC.Set_Heater_Mode(1);
				TC.Set_Gas_Flow_Mode(1);
			end	
	        end
	end
	function Initialize()
		set(TC.handles.hSet_Temp_Edit,'String',num2str(TC.Temperature_Set));
		set(TC.handles.hSet_Heater_Edit,'String',num2str(TC.Heater));
		set(TC.handles.hCurrent_Temp_Show,'String',num2str(TC.Temperature_Read));
		set(TC.handles.hSet_Mode_Popup,'Value', TC.Control_Mode+2);
		set(TC.handles.hSet_Heater_Mode_Popup, 'Value',2*TC.Gas_Flow_Mode+TC.Heater_Mode+2);
		switch (TC.Stable)
		case 0
			set(TC.handles.hTemp_Stable,'String','Out of Range');
		case 1
			set(TC.handles.hTemp_Stable,'String','Approaching');
		case 2
			set(TC.handles.hTemp_Stable,'String','Stablizing');
		case 3
			set(TC.handles.hTemp_Stable,'String','Delay');
		case 4
			set(TC.handles.hTemp_Stable,'String','Stable');
		end

		if (TC.Heater_Mode == 1)
			set(TC.handles.hSet_Heater_Edit,'Enable','off');
		else
			set(TC.handles.hSet_Heater_Edit,'Enable','on');
		end
	end
	function Set_Heater_callback(hObject,eventdata)
		power = num2str(get(TC.handles.hSet_Heater_Edit,'String'));
		TC.Set_Heater(power);
	end
	function TemperatureChangedCallback(hObject,eventdata)
		set(hCurrent_Temp_Show,'String',num2str(TC.Temperature_Read));
	end
	function HeaterModeChangedCallback(hObject,eventdata)
		if (TC.Heater_Mode == 1)
			set(hSet_Heater_Edit,'Enable','off');
		else
			set(hSet_Heater_Edit,'Enable','on');
		end
	end
	function StableStateChangedCallback(hObject,eventdata)
		switch (TC.Stable)
		case 0
			set(TC.handles.hTemp_Stable,'String','Out of Range');
		case 1
			set(TC.handles.hTemp_Stable,'String','Approaching');
		case 2
			set(TC.handles.hTemp_Stable,'String','Stablizing');
		case 3
			set(TC.handles.hTemp_Stable,'String','Delay');
		case 4
			set(TC.handles.hTemp_Stable,'String','Stable');
		end
	end

end
