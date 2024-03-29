function f = ShowLayout(CS,hPanel)
	if (~exist('hPanel'))
		hPanel = figure('Position',[0 0 1024 768]);
		movegui(hPanel,'center');
	end
 	hCurrent_Text = uicontrol(hPanel,'Style','text',...
                            'String','Current Set(mA)','Units','Normalized',...
                            'Position',[0.1,0.9,0.2,0.05]);
  	hCurrent_Edit = uicontrol(hPanel,'Style','edit',...
                            'String','N/A','Units','Normalized',...
                            'Position',[0.1,0.8,0.2,0.1],...
			    'Callback',{@Current_Set_Callback});
 	hCurrent_Output_Text = uicontrol(hPanel,'Style','text',...
                            'String','Current Output(mA)','Units','Normalized',...
                            'Position',[0.35,0.9,0.2,0.05]);
 	hCurrent_Output_Read = uicontrol(hPanel,'Style','text',...
                            'String','N/A','Units','Normalized',...
                            'Position',[0.35,0.8,0.2,0.1]);
 	hVoltage_Text = uicontrol(hPanel,'Style','text',...
                            'String','Voltage(V)','Units','Normalized',...
                            'Position',[0.6,0.9,0.2,0.05]);
 	hVoltage_Read = uicontrol(hPanel,'Style','text',...
                            'String','N/A','Units','Normalized',...
                            'Position',[0.6,0.8,0.2,0.1]);
  	hMode_Text = uicontrol(hPanel,'Style','text',...
                            'String','Mode','Units','Normalized',...
                            'Position',[0.01,0.6,0.3,0.1]);
  	hCurrent_Limit_Text = uicontrol(hPanel,'Style','text',...
                            'String','Current Range(mA)','Units','Normalized',...
                            'Position',[0.01,0.4,0.3,0.1]);
  	hGPIB_Text = uicontrol(hPanel,'Style','text',...
                            'String','GPIB Address','Units','Normalized',...
                            'Position',[0.01,0.15,0.3,0.1]);

  	hMode_popup = uicontrol(hPanel,'Style','popupmenu',...
                            'String',{'N/A','Constant I, Low bandpass',... 
			    'Constant I, High bandpass',...
			    'Constant P'},'Units','Normalized',...
                            'Position',[0.35,0.6,0.35,0.1],...
			    'Callback',{@Mode_Set_Callback});
  	hCurrent_Limit_popup = uicontrol(hPanel,'Style','popupmenu',...
                            'String',{'N/A','2000mA','4000mA'},'Units','Normalized',...
                            'Position',[0.35,0.4,0.35,0.1],...
			    'Callback',{@Current_Range_Set_Callback});
  	hGPIB_Edit = uicontrol(hPanel,'Style','edit',...
                            'String',CS.gpib_address,'Units','Normalized',...
                            'Position',[0.35,0.15,0.2,0.1]);

  	hGPIB_Set = uicontrol(hPanel,'Style','pushbutton',...
                            'String','Set','Units','Normalized',...
                            'Position',[0.6,0.15,0.1,0.1]);
  	hConnect_Text = uicontrol(hPanel,'Style','text',...
                            'String','Source NOT Connected','Units','Normalized',...
                            'Position',[0.75,0.7,0.2,0.2],'ForegroundColor','red','Fontweight','bold');
  	hConnect_Connect = uicontrol(hPanel,'Style','pushbutton',...
                            'String','Connect','Units','Normalized',...
                            'Position',[0.75,0.5,0.2,0.2],...
                            'CallBack',{@Connect_Callback});
  	hOutput_Text = uicontrol(hPanel,'Style','text',...
                            'String','Output is OFF','Units','Normalized',...
                            'Position',[0.75,0.3,0.2,0.1],'ForegroundColor','red','Fontweight','bold');
  	hOutput_Set = uicontrol(hPanel,'Style','pushbutton',...
                            'String','Output','Units','Normalized',...
                            'Position',[0.75,0.1,0.2,0.2],...
                            'CallBack',{@Output_Set_Callback});
	hType = get(hPanel,'Type');
	if (strcmp(hType, 'uipanel')) 
		set(hPanel,'Title','ILX3744B Continuous Current Source');
	end
	handles.hCurrent_Text = hCurrent_Text;
	handles.hMode_Text = hMode_Text;
	handles.hCurrent_Limit_Text = hCurrent_Limit_Text;
	handles.hGPIB_Text = hGPIB_Text;
	handles.hCurrent_Edit = hCurrent_Edit;
	handles.hMode_popup = hMode_popup;
	handles.hCurrent_Limit_popup = hCurrent_Limit_popup;
	handles.hGPIB_Edit = hGPIB_Edit;
	handles.hGPIB_Set = hGPIB_Set;
	handles.hConnect_Text = hConnect_Text;
	handles.hConnect_Connect = hConnect_Connect;
	handles.hOutput_Text = hOutput_Text;
	handles.hOutput_Set = hOutput_Set;
	handles.hCurrent_Output_Text = hCurrent_Output_Text;
	handles.hCurrent_Output_Read = hCurrent_Output_Read;
	handles.hVoltage_Text = hVoltage_Text;
	handles.hVoltage_Read = hVoltage_Read;
	%---add listener---
	lh1 = event.listener(CS,'eCSILX3744BCurrentChanged',@CurrentchangedCallback);
	lh2 = event.listener(CS,'eCSILX3744BVoltageChanged',@VoltagechangedCallback);

	function Connect_Callback(hObject,eventdata)
		if (CS.gpib_obj==0 || strcmp(CS.gpib_obj.Status, 'closed'))
			if CS.Connect == 1
				set(hConnect_Connect,'String','Disconnect');
				set(hConnect_Text,'String','Source is connected','ForegroundColor','Green');
			end
			CS.Get_Current;
			CS.Get_Voltage;
			CS.Get_Mode;
			CS.Get_Current_Range;
			CS.Get_Output;
			Initialize;
		else
			if CS.Disconnect == 1
				set(hConnect_Connect,'String','Connect');
				set(hConnect_Text,'String','Source NOT Connected','ForegroundColor','red');
			else
			end
		end
	end

	function Current_Set_Callback(hObject,eventdata)
		if strcmp(CS.gpib_obj.Status,'open')
            		current = get(hCurrent_Edit,'String');
			CS.Set_Current(str2num(current));
        	else
            		herrordlg=errordlg('Source NOT connected','Source Error');
        	end
	end
	function Output_Set_Callback(hObject,eventdata)
		if CS.Output == 0
			CS.Set_Output;
			if CS.Output == 1
				set(hOutput_Text,'String','Output is ON','foregroundcolor','green');
			end
		else
			CS.Deset_Output;
			if CS.Output == 0
				set(hOutput_Text,'String','Output is OFF','foregroundcolor','red');
			end
		end
	end
   	function Mode_Set_Callback(hObject,eventdata)
        	str = get(hObject,'String');
		val = get(hObject,'Value');
        	if strcmp(CS.gpib_obj.Status,'open')
			switch str{val}
			case 'N/A'
			case 'Constant I, Low bandpass'
				fwrite(CS.gpib_obj,'LAS:MODE:ILBW;');
				CS.Get_Mode;
			case 'Constant I, High bandpass'
				fwrite(CS.gpib_obj,'LAS:MODE:IHBW;');
				CS.Get_Mode;
			case 'Constant P'
				fwrite(CS.gpib_obj,'LAS:MODE:MDP;');
				CS.Get_Mode;
			end	
	        else
	            herrordlg=errordlg('Source NOT connected','Source Error');
	        end
	end
    	function Current_Range_Set_Callback(hObject,eventdata)
        	str = get(hObject,'String');
		val = get(hObject,'Value');
	        if strcmp(CS.gpib_obj.Status,'open')
			switch str{val}
	        	case 'N/A'
			case '2000mA'
				fwrite(CS.gpib_obj,'LAS:RAN 1;');
				CS.Get_Current_Range;
			case '4000mA' 
				fwrite(CS.gpib_obj,'LAS:RAN 3;');
				CS.Get_Current_Range;
			end
	        else
	            herrordlg=errordlg('Source NOT connected','Source Error');
	        end
        end
	function CurrentchangedCallback(hObject,eventdata)
		set(hCurrent_Output_Read,'String',num2str(CS.Current_Output));
	end
	function VoltagechangedCallback(hObject,eventdata)
		set(hVoltage_Read,'String',num2str(CS.Voltage));
	end
	function Initialize()
		set(hCurrent_Edit,'String',num2str(CS.Current_Set));
		if CS.Current_Range == 2000
			set(hCurrent_Limit_popup,'Value',2);
		else if CS.Current_Range == 4000
			set(hCurrent_Limit_popup,'Value',3);
		else
		set(hCurrent_Limit_popup,'Value',1);
		end
		end

		switch (CS.Mode)
		case 1
			set(handles.hMode_popup,'Value',2);
		case 2
			set(handles.hMode_popup,'Value',3);
		case 3
			set(handles.hMode_popup,'Value',4);
		case 4
			set(handles.hMode_popup,'Value',4);
		otherwise
			set(handles.hMode_popup,'Value',1);
		end
	end
end
