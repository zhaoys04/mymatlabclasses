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

 	hFilename_Text = uicontrol('Parent',H2,'Style','text',...
                            'String','Filename:');
 	hFilename_Edit = uicontrol('Parent',H2,'Style','edit',...
                            'String','');
	uiextras.Empty('Parent',H2);
  	hSave = uicontrol('Parent',H2,'Style','pushbutton',...
                            'String','Save',...
                            'CallBack',{@Save_Callback});

	hPlot = axes('Parent',V1);
	xlabel('wavelength(nm)');ylabel('Amplitude(W)');
	set(V1,'Sizes',[5,30,5,30,5,-1]);
	set(H2,'Sizes',[100,-1,10,100]);
	set(hPanel,'Visible','on');

%----------callback functions---------------------------------
	function Connect_Callback(hObject,eventdata)
		if (OS.gpib_obj==0 || strcmp(OS.gpib_obj.Status, 'closed'))
			if OS.Connect == 1
				set(hConnect,'String','Disconnect');
			end
		else
			if OS.Disconnect == 1
				set(hConnect,'String','Connect');
			end
		end
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

