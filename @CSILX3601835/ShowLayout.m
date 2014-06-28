function f = ShowLayout(CS,hPanel)
	% ShowLayout(hPanel): Display default GUI control panel of current source
	% 		      hPanel is the handle of uipanel. If omitted, new
	% 		      figure will be created
	if (~exist('hPanel'))
		hPanel = figure('Position',[0 0 640 480],'Visible','off');
		movegui(hPanel,'center');
	end
	hType = get(hPanel,'Type');
	if (strcmp(hType, 'uipanel')) 
		set(hPanel,'Title','ILX36018-35 Laser Current Driver');
	end
%----------setup UI---------------
	V1 = uiextras.VBox('Parent',hPanel);
	H1 = uiextras.HBox('Parent',V1);
	H2 = uiextras.HBox('Parent',V1);
	V2 = uiextras.VBox('Parent',H1);
	V3 = uiextras.VBox('Parent',H1);
	uiextras.Empty('Parent',V2);
	H3 = uiextras.HBox('Parent',V2);
	uiextras.Empty('Parent',V2);
	H4 = uiextras.HBox('Parent',H3);
	H5 = uiextras.HBox('Parent',H3);
	H6 = uiextras.HBox('Parent',V2);
	uiextras.Empty('Parent',V2);
 	hCurrent_Text = uicontrol('Parent',H4,'Style','text',...
                            'String','Current Set(A): ','HorizontalAlignment','right');
  	hCurrent_Edit = uicontrol('Parent',H4,'Style','edit',...
                            'String','N/A',...
			    'Callback',{@Current_Set_Callback});
 	hCurrent_Limit_Text = uicontrol('Parent',H5,'Style','text',...
                            'String','Current limit(A): ','HorizontalAlignment','right');
  	hCurrent_Limit_Edit = uicontrol('Parent',H5,'Style','edit',...
                            'String','N/A',...
			    'Callback',{@Current_Limit_Set_Callback});
 	hMode_Text = uicontrol('Parent',H6,'Style','text',...
                            'String','Mode: ');
  	hMode_popup = uicontrol('Parent',H6,'Style','popupmenu',...
                            'String',{'N/A','CW',... 
			    'Hard Pulse',...
			    'Pulse','Trig'},...
			    'Callback',{@Mode_Set_Callback});

  	hConnect = uicontrol('Parent',V3,'Style','pushbutton',...
                            'String','Connect',...
                            'CallBack',{@Connect_Callback});
  	hOutput_Set = uicontrol('Parent',V3,'Style','pushbutton',...
                            'String','Output',...
                            'CallBack',{@Output_Set_Callback});

	hQCW_panel = uipanel('Parent',H2,'Title','QCW');
	hStatus_panel = uipanel('Parent',H2,'Title','Status');
	V4 = uiextras.VBox('Parent',hQCW_panel);
	G2 = uiextras.Grid('Parent',hStatus_panel);
	h = uibuttongroup('Parent',V4,'Visible','on');
	hV = uiextras.VBox('Parent',h);
	uiextras.Empty('Parent',hV);
	h1 = uicontrol('Style','Radiobutton','String','Constant duty cycle','Parent',hV,'Callback',{@QCW_Mode_Changed_Callback});
	uiextras.Empty('Parent',hV);
	h2 = uicontrol('Style','Radiobutton','String','Constant frequency','Parent',hV,'Callback',{@QCW_Mode_Changed_Callback});
	uiextras.Empty('Parent',hV);
	set(h,'SelectedObject',h1);
	set(hV,'Sizes',[-1,20,-1,20,-1]);
	G1 = uiextras.Grid('Parent',V4);
	uiextras.Empty('Parent',G1);
 	hPW_Text = uicontrol('Parent',G1,'Style','text',...
                            'String','Pulse width(ms):');
	uiextras.Empty('Parent',G1);
 	hDC_Text = uicontrol('Parent',G1,'Style','text',...
                            'String','Duty cycle(%):');
	uiextras.Empty('Parent',G1);
 	hFreq_Text = uicontrol('Parent',G1,'Style','text',...
                            'String','Frequency(Hz):');
	uiextras.Empty('Parent',G1);
	uiextras.Empty('Parent',G1);
 	hPW_Edit = uicontrol('Parent',G1,'Style','edit',...
                            'String','N/A',...
			    'Callback',{@Pulse_Width_Set_Callback});
	uiextras.Empty('Parent',G1);
 	hDC_Edit = uicontrol('Parent',G1,'Style','edit',...
                            'String','N/A',...
			    'Callback',{@Duty_Cycle_Set_Callback});
	uiextras.Empty('Parent',G1);
 	hFreq_Edit = uicontrol('Parent',G1,'Style','edit',...
                            'String','N/A',...
			    'Callback',{@Freq_Set_Callback});
	uiextras.Empty('Parent',G1);
	uiextras.Empty('Parent',G1);
 	hPW_Show = uicontrol('Parent',G1,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G1);
 	hDC_Show = uicontrol('Parent',G1,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G1);
 	hFreq_Show = uicontrol('Parent',G1,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G1);
	set(G1,'ColumnSizes',[-2 -1 -1],'RowSizes',[-1 20 -1 20 -1 20 -1],'Spacing',5);

	uiextras.Empty('Parent',G2);
 	hConnect_Status_Text = uicontrol('Parent',G2,'Style','text',...
                            'String','Connection:');
	uiextras.Empty('Parent',G2);
 	hCurrent_Status_Text = uicontrol('Parent',G2,'Style','text',...
                            'String','Current(A):');
	uiextras.Empty('Parent',G2);
 	hVoltage_Status_Text = uicontrol('Parent',G2,'Style','text',...
                            'String','Voltage(V):');
	uiextras.Empty('Parent',G2);
 	hCurrentLimit_Status_Text = uicontrol('Parent',G2,'Style','text',...
                            'String','Current limit(V):');
	uiextras.Empty('Parent',G2);
 	hCurrentMode_Status_Text = uicontrol('Parent',G2,'Style','text',...
                            'String','Current mode:');
	uiextras.Empty('Parent',G2);
 	hOutput_Status_Text = uicontrol('Parent',G2,'Style','text',...
                            'String','Output status:');
	uiextras.Empty('Parent',G2);
	uiextras.Empty('Parent',G2);
 	hConnect_Status_Show = uicontrol('Parent',G2,'Style','text',...
                            'String','Lost','ForegroundColor','red');
	uiextras.Empty('Parent',G2);
 	hCurrent_Status_Show = uicontrol('Parent',G2,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G2);
 	hVoltage_Status_Show = uicontrol('Parent',G2,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G2);
 	hCurrentLimit_Status_Show = uicontrol('Parent',G2,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G2);
 	hCurrentMode_Status_Show = uicontrol('Parent',G2,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G2);
 	hOutput_Status_Show = uicontrol('Parent',G2,'Style','text',...
                            'String','N/A');
	uiextras.Empty('Parent',G2);
	set(G2,'ColumnSizes',[-1 -1],'RowSizes',[-1 20 -1 20 -1 20 -1 20 -1 20 -1 20 -1]);

	set(V1,'Sizes',[-1,-2],'Spacing',5,'Padding',5);
	set(V2,'Sizes',[-1, 20, -1, 20,-1]);
	set(H2,'Spacing',5,'Padding',5);
	set(V3,'Padding',5, 'Spacing',5);
	set(H1,'Sizes',[-3,-1],'Spacing',5,'Padding',5);
	set(H6,'Sizes',[-1,-3]);
	set(V4,'Sizes',[-1,-2],'Spacing',5,'Padding',5);
	set(hPanel,'Visible','on');

%---------add listener---------------------
	lh1 = event.listener(CS,'eCSILX3601835CurrentChanged',@CurrentchangedCallback);
	lh2 = event.listener(CS,'eCSILX3601835VoltageChanged',@VoltagechangedCallback);
	lh3 = event.listener(CS,'eCSILX3601835ModeChanged',@ModechangedCallback);
	lh4 = event.listener(CS,'eCSILX3601835CurrentLimitChanged',@CurrentLimitchangedCallback);
	lh5 = event.listener(CS,'eCSILX3601835PulseWidthChanged',@PulseWidthchangedCallback);
	lh6 = event.listener(CS,'eCSILX3601835FreqChanged',@FreqchangedCallback);
	lh7 = event.listener(CS,'eCSILX3601835DutyCycleChanged',@DutyCyclechangedCallback);

%----------callback functions---------------------------------
	function Current_Set_Callback(hObject,eventdata)
		if strcmp(CS.gpib_obj.Status,'open')
            		current = get(hCurrent_Edit,'String');
			CS.Set_Current(str2num(current));
        	else
            		herrordlg=errordlg('Source NOT connected','Source Error');
        	end
	end

	function Current_Limit_Set_Callback(hObject,eventdata)
		if strcmp(CS.gpib_obj.Status,'open')
            		current = get(hCurrent_Limit_Edit,'String');
			CS.Set_Current_Limit(str2num(current));
        	else
            		herrordlg=errordlg('Source NOT connected','Source Error');
        	end
	end

	function Mode_Set_Callback(hObject, eventdata)
        	str = get(hObject,'String');
		val = get(hObject,'Value');
        	if strcmp(CS.gpib_obj.Status,'open')
			switch str{val}
			case 'N/A'
			case 'CW'
				CS.Set_Mode(1);
				set(findall(hQCW_panel,'-property','enable'),'enable','off');
			case 'Hard Pulse'
				CS.Set_Mode(2);
				set(findall(hQCW_panel,'-property','enable'),'enable','on');
			case 'Pulse'
				CS.Set_Mode(3);
				set(findall(hQCW_panel,'-property','enable'),'enable','on');
			case 'Trig'
				CS.Set_Mode(4);
				set(findall(hQCW_panel,'-property','enable'),'enable','off');

			end	
	        else
	            herrordlg=errordlg('Source NOT connected','Source Error');
	        end

	end

	function Connect_Callback(hObject,eventdata)
		if (CS.gpib_obj==0 || strcmp(CS.gpib_obj.Status, 'closed'))
			if CS.Connect == 1
				set(hConnect,'String','Disconnect');
				set(hConnect_Status_Show,'String','Established','ForegroundColor','Green');
			end
			Initialize();
		else
			if CS.Disconnect == 1
				set(hConnect,'String','Connect');
				set(hConnect_Status_Show,'String','Lost','ForegroundColor','red');
			else
			end
		end
	end

	function Output_Set_Callback(hObject,eventdata)
		if CS.Output == 0
			CS.Set_Output;
			if CS.Output == 1
				set(hOutput_Status_Show,'String','Enabled','foregroundcolor','green');
			end
		else
			CS.Deset_Output;
			if CS.Output == 0
				set(hOutput_Status_Show,'String','Disabled','foregroundcolor','red');
			end
		end
	end

	function CurrentchangedCallback(hObject,eventdata)
		set(hCurrent_Status_Show,'String',num2str(CS.Current_Output));
	end

	function VoltagechangedCallback(hObject,eventdata)
		set(hVoltage_Status_Show,'String',num2str(CS.Voltage));
	end

	function ModechangedCallback(hObject,eventdata)
		toSet = CS.Mode + 1;
		if toSet > 5 
			toSet = 1;
		end
		set(hMode_popup,'Value',toSet);
		set(hCurrentMode_Status_Show,'String',CS.Mode_String);
        if (toSet == 3 || toSet == 4)
            set(findall(hQCW_panel,'-property','enable'),'enable','on');
        else
            set(findall(hQCW_panel,'-property','enable'),'enable','off');
        end
	end

	function CurrentLimitchangedCallback(hObject,eventdata)
		set(hCurrent_Limit_Edit,'String',num2str(CS.Current_Limit));
		set(hCurrentLimit_Status_Show,'String',num2str(CS.Current_Limit));
	end

	function PulseWidthchangedCallback(hObject,eventdata)
		set(hPW_Show,'String',num2str(CS.QCW.pw));
	end

	function FreqchangedCallback(hObject,eventdata)
		set(hFreq_Show,'String',num2str(CS.QCW.freq));
	end

	function DutyCyclechangedCallback(hObject,eventdata)
		set(hDC_Show,'String',num2str(CS.QCW.duty));
	end
	
	function Pulse_Width_Set_Callback(hObject,eventdata)
		if strcmp(CS.gpib_obj.Status,'open')
            		pw = get(hPW_Edit,'String');
			CS.Set_Pulse_Width(str2num(pw)*1e-3);
        	else
            		herrordlg=errordlg('Source NOT connected','Source Error');
        	end

	end

	function Duty_Cycle_Set_Callback(hObject,eventdata)
		if strcmp(CS.gpib_obj.Status,'open')
            		dc = get(hDC_Edit,'String');
			CS.Set_Duty_Cycle(str2num(dc));
        	else
            		herrordlg=errordlg('Source NOT connected','Source Error');
        	end
	end

	function Freq_Set_Callback(hObject,eventdata)
		if strcmp(CS.gpib_obj.Status,'open')
            		freq = get(hFreq_Edit,'String');
			CS.Set_Freq(str2num(freq));
        	else
            		herrordlg=errordlg('Source NOT connected','Source Error');
        	end
	end

	function QCW_Mode_Changed_Callback(hObject,eventdata)
		opts = get(hObject,'String');
		switch opts
			case 'Constant duty cycle'
				set(h1,'Value',1);
				set(h2,'Value',0);
				CS.Set_QCW_Mode(0);
			case 'Constant frequency'
				set(h1,'Value',0);
				set(h2,'Value',1);
				CS.Set_QCW_Mode(1);
			otherwise
		end
	end

	function Initialize()
		set(hCurrent_Edit,'String',num2str(CS.Current_Set));
		notify(CS.Tonotify,'eCSILX3601835CurrentChanged');
		notify(CS.Tonotify,'eCSILX3601835VoltageChanged');
		notify(CS.Tonotify,'eCSILX3601835ModeChanged');
		notify(CS.Tonotify,'eCSILX3601835CurrentLimitChanged');
		notify(CS.Tonotify,'eCSILX3601835PulseWidthChanged');
		notify(CS.Tonotify,'eCSILX3601835FreqChanged');
		notify(CS.Tonotify,'eCSILX3601835DutyCycleChanged');
	end

end

