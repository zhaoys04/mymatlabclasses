function f = ShowLayout(LI,hPanel)
	if (~exist('hPanel'))
		hPanel = figure('Position',[0 0 640 480],'Visible','off');
		movegui(hPanel,'center');
	end
	hType = get(hPanel,'Type');
	if (strcmp(hType, 'uipanel')) 
		set(hPanel,'Title','Pulse LI result');
	end
%----------setup UI---------------
	V1 = uiextras.VBox('Parent',hPanel);
	H1 = uiextras.HBox('Parent',V1);
	V2 = uiextras.VBox('Parent',H1);
	V3 = uiextras.VBox('Parent',H1);
	uiextras.Empty('Parent',V2);
	H2 = uiextras.HBox('Parent',V2);
	uiextras.Empty('Parent',V2);
	H4 = uiextras.HBox('Parent',V2);
	uiextras.Empty('Parent',V2);
	H3 = uiextras.HBox('Parent',V2);
	uiextras.Empty('Parent',V2);
	hpp = uipanel('Parent',V1);
	hAxes_LI = axes('Parent',hpp,'YColor','Blue');
	hAxes_IV = axes('Parent',hpp,'YAxisLocation','right','YColor','green','Color','none');
	hLILine = line([0],[0],'Parent',hAxes_LI,'Color','Blue');
	hIVLine = line([0],[0],'Parent',hAxes_IV,'Color','Green');

 	hCurrent_From_Text = uicontrol('Parent',H2,'Style','text',...
                            'String','Current From(A): ');
 	hCurrent_From_Edit = uicontrol('Parent',H2,'Style','edit',...
                            'String','');
 	hCurrent_To_Text = uicontrol('Parent',H2,'Style','text',...
                            'String','To: ','HorizontalAlignment','right');
 	hCurrent_To_Edit = uicontrol('Parent',H2,'Style','edit',...
                            'String','');
 	hCurrent_Step_Text = uicontrol('Parent',H2,'Style','text',...
                            'String','Step(A): ','HorizontalAlignment','right');
 	hCurrent_Step_Edit = uicontrol('Parent',H2,'Style','edit',...
                            'String','');
 	hSave_to_File = uicontrol('Parent',H3,'Style','checkbox',...
                            'String','Save to file','Value',1);
 	hSave_to_DataBase = uicontrol('Parent',H3,'Style','checkbox',...
                            'String','Save to database','Value',0);
	uiextras.Empty('Parent',H3);
	hStart_Measure = uicontrol('Parent',V3,'Style','pushbutton',...
                            'String','Start',...
			    'Callback',{@Start_Callback});
	hStop_Measure = uicontrol('Parent',V3,'Style','pushbutton',...
                            'String','Stop',...
			    'Callback',{@Stop_Callback});
	hExport = uicontrol('Parent',V3,'Style','pushbutton',...
                            'String','Export',...
			    'Callback',{@Export_Callback});
	hFilename_Text = uicontrol('Parent',H4,'Style','text',...
                            'String','Filename: ','HorizontalAlignment','right');
	hFilename_Edit = uicontrol('Parent',H4,'Style','edit',...
                            'String','');
	uiextras.Empty('Parent',H4);
	hFilename_Suf_Text = uicontrol('Parent',H4,'Style','text',...
                            'String','Suffix: ','HorizontalAlignment','right');
	hFilename_Suf_Edit = uicontrol('Parent',H4,'Style','edit',...
                            'String','');
	set(V1,'Sizes',[-1,-4],'Padding',5);
	set(H1,'Sizes',[-4,-1],'Padding',5,'Spacing',5);
	set(H2,'Sizes',[120,-1,30,-1,60,-1]);
	set(H4,'Sizes',[70,-1,10,60,100]);
	set(H3,'Sizes',[100,-1,-1]);
	set(V2,'Sizes',[-1,20,-1,20,-1,20,-1]);
	set(hPanel,'Visible','on');

%------add listener--------------
	lh1 = event.listener(LI,'ePulseLIMeasurementComplete',@MeasurementComplete_Callback);
%------add timer---------------

	LI_Timer = timer('ExecutionMode','fixedspacing','Period',1,'TimerFcn',{@UpdatePlot});

%------Callback functions-------------

	function Start_Callback(hObject,eventdata)
		current_start = str2num(get(hCurrent_From_Edit,'String'));
		current_end = str2num(get(hCurrent_To_Edit,'String'));
		current_step = str2num(get(hCurrent_Step_Edit,'String'));
		I = [current_start:current_step:current_end];
		start(LI_Timer);
		LI.NewMeasurement(I);
	end

	function MeasurementComplete_Callback(hObject,eventdata)
		pause(1);
        display('called');
  %      try
 		stop(LI_Timer);
		part1 = get(hFilename_Edit,'String');
		part2 = get(hFilename_Suf_Edit,'String');
		filename = [part1,'_',part2,'.mat'];
        a = LI.Results;
		save(filename,'a');
		set(hFilename_Suf_Edit,'String',num2str(str2num(part2)+1));
  %      catch
  %          display('Warning! maybe gui is not open')
 %       end
	end
	
	function UpdatePlot(hObject, eventdata)
        lI = length(LI.Results.I);
        lV = length(LI.Results.V);
        lL = length(LI.Results.L);
        if (lI == lL)
    		set(hLILine,'xdata',LI.Results.I,'ydata',LI.Results.L);
        end
        if (lI == lV)
            set(hIVLine,'xdata',LI.Results.I,'ydata',LI.Results.V);
        end
	end

	function Stop_Callback(hObject,eventdata)
		LI.GoingtoStop = 1;
	end

	function Export_Callback(hObject,eventdata)
		figure;
		plotyy(LI.Results.I,LI.Results.L,LI.Results.I,LI.Results.V);
	end

end
