function f = ShowLayout(OS,hPanel)
	% ShowLayout(hPanel): Display default GUI control panel of OSA
	% 		      hPanel is the handle of uipanel. If omitted, new
	% 		      figure will be created
	if (~exist('hPanel'))
		hPanel = figure('Position',[0 0 640 480],'Visible','off');
		movegui(hPanel,'center');
	end
	hType = get(hPanel,'Type');
	if (strcmp(hType, 'uipanel')) 
		set(hPanel,'Title','Optical Spectrum Analyzer');
	end
%----------setup UI---------------
	V1 = uiextras.VBox('Parent',hPanel);
	uiextras.Empty('Parent',V1);
	H1 = uiextras.HBox('Parent',V1);
	uiextras.Empty('Parent',V1);
	H3 = uiextras.HBox('Parent',V1);
	uiextras.Empty('Parent',V1);
	H4 = uiextras.HBox('Parent',V1);
	uiextras.Empty('Parent',V1);
	H2 = uiextras.HBox('Parent',V1);
	uiextras.Empty('Parent',V1);

	uiextras.Empty('Parent',H1);
  	hConnect = uicontrol('Parent',H1,'Style','pushbutton',...
                            'String','Connect',...
                            'CallBack',{@Connect_Callback});
	uiextras.Empty('Parent',H1);
  	hGet_Spectrum = uicontrol('Parent',H1,'Style','pushbutton',...
                            'String','Get Spectrum',...
                            'CallBack',{@GetSpectrum_Callback});
	uiextras.Empty('Parent',H1);

	hStartWL_Text = uicontrol('Parent',H3,'Style','text',...
				'String','Start Wavelength(nm):');
	hStartWL_Edit = uicontrol('Parent',H3,'Style','edit',...
				'String','','Callback',{@SetStartWL_Callback});
	hStopWL_Text = uicontrol('Parent',H3,'Style','text',...
				'String','Stop Wavelength(nm):');
	hStopWL_Edit = uicontrol('Parent',H3,'Style','edit',...
				'String','','Callback',{@SetStopWL_Callback});

	hCenterWL_Text = uicontrol('Parent',H4,'Style','text',...
				'String','Center Wavelength(nm):');
	hCenterWL_Edit = uicontrol('Parent',H4,'Style','edit',...
				'String','','Callback',{@SetCenterWL_Callback});
	hSpan_Text = uicontrol('Parent',H4,'Style','text',...
				'String','Span(nm):');
	hSpan_Edit = uicontrol('Parent',H4,'Style','edit',...
				'String','','Callback',{@SetSpan_Callback});

 	hFilename_Text = uicontrol('Parent',H2,'Style','text',...
                            'String','Filename:');
 	hFilename_Edit = uicontrol('Parent',H2,'Style','edit',...
                            'String','');
	uiextras.Empty('Parent',H2);
  	hSave = uicontrol('Parent',H2,'Style','pushbutton',...
                            'String','Save',...
                            'CallBack',{@Save_Callback});
	uiextras.Empty('Parent',H2);

	hPlot = axes('Parent',V1);
	xlabel('wavelength(nm)');ylabel('Amplitude(W)');
	set(V1,'Sizes',[5,20,5,20,5,20,5,20,5,-1]);
	set(H2,'Sizes',[100,-1,10,100,10]);
	set(hPanel,'Visible','on');

%----------callback functions---------------------------------
	function Connect_Callback(hObject,eventdata)
		if (OS.gpib_obj==0 || strcmp(OS.gpib_obj.Status, 'closed'))
			if OS.Connect == 1
				set(hConnect,'String','Disconnect');
				set(hStartWL_Edit,'String',num2str(OS.GetStartWL()));
				set(hStopWL_Edit,'String',num2str(OS.GetStopWL()));
				set(hCenterWL_Edit,'String',num2str(OS.GetCenterWL()));
				set(hSpan_Edit,'String',num2str(OS.GetSpan()));
			end
		else
			if OS.Disconnect == 1
				set(hConnect,'String','Connect');
			end
		end
	end

	function SetStartWL_Callback(hObject, eventdata)
		startwl = str2num(get(hStartWL_Edit,'String'));
		stopwl = str2num(get(hStopWL_Edit,'String'));
		centerwl = str2num(get(hCenterWL_Edit,'String'));
		span = str2num(get(hSpan_Edit,'String'));
		OS.SetStartWL(startwl);
		set(hCenterWL_Edit,'String',num2str((startwl+stopwl)/2));
		set(hSpan_Edit,'String',num2str(stopwl-startwl));
	end

	function SetStopWL_Callback(hObject, eventdata)
		startwl = str2num(get(hStartWL_Edit,'String'));
		stopwl = str2num(get(hStopWL_Edit,'String'));
		centerwl = str2num(get(hCenterWL_Edit,'String'));
		span = str2num(get(hSpan_Edit,'String'));
		OS.SetStopWL(stopwl);
		set(hCenterWL_Edit,'String',num2str((startwl+stopwl)/2));
		set(hSpan_Edit,'String',num2str(stopwl-startwl));
	end

	function SetCenterWL_Callback(hObject, eventdata)
		startwl = str2num(get(hStartWL_Edit,'String'));
		stopwl = str2num(get(hStopWL_Edit,'String'));
		centerwl = str2num(get(hCenterWL_Edit,'String'));
		span = str2num(get(hSpan_Edit,'String'));
		OS.SetCenterWL(centerwl);
		set(hStartWL_Edit,'String',num2str(centerwl-span/2));
		set(hStopWL_Edit,'String',num2str(centerwl+span/2));
	end

	function SetSpan_Callback(hObject, eventdata)
		startwl = str2num(get(hStartWL_Edit,'String'));
		stopwl = str2num(get(hStopWL_Edit,'String'));
		centerwl = str2num(get(hCenterWL_Edit,'String'));
		span = str2num(get(hSpan_Edit,'String'));
		OS.SetSpan(span);
		set(hStartWL_Edit,'String',num2str(centerwl-span/2));
		set(hStopWL_Edit,'String',num2str(centerwl+span/2));
	end

	function GetSpectrum_Callback(hObject,eventdata)
		OS.Get_Spectrum();
		axes(hPlot);
		plot(OS.wavelength/1e-6,OS.amplitude);
	end

	function Save_Callback(hObject,eventdata)
		filename = [get(hFilename_Edit,'String'),'.mat'];
		save filename OS.wavelength OS.amplitude
	end

end

