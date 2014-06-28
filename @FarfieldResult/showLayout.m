function f = showLayout(FFR,hPanel)
	if (~exist('hPanel'))
		hPanel = figure('Position',[0 0 640 480],'Visible','off');
		movegui(hPanel,'center');
	end
	hType = get(hPanel,'Type');
	if (strcmp(hType, 'uipanel')) 
		set(hPanel,'Title','Farfield Measurement');
	end
	V1 = uiextras.VBox('Parent',hPanel,'Tag','VBoxlayout_handle');
	V1_handle = findobj(hPanel,'Tag','VBoxlayout_handle');	
	G1 = uiextras.Grid('Parent',V1);
	uiextras.Empty('Parent',G1);
	hFastScan = uicontrol('Parent',G1,'Style','pushbutton',...
                             'String','Coarse Scan',...
			     'CallBack',{@Fast_Scan_Callback}); 
	uiextras.Empty('Parent',G1);
	hFineScan = uicontrol('Parent',G1,'Style','pushbutton',...
                             'String','Fine Scan',...
			     'CallBack',{@Fine_Scan_Callback}); 
	uiextras.Empty('Parent',G1);
	hFarfieldScan = uicontrol('Parent',G1,'Style','pushbutton',...
                             'String','Farfield Scan',...
			     'CallBack',{@Farfield_Scan_Callback}); 
	uiextras.Empty('Parent',G1);
	uiextras.Empty('Parent',G1);
	hExport = uicontrol('Parent',G1,'Style','pushbutton',...
                             'String','Export',...
			     'CallBack',{@Export_Callback}); 
	uiextras.Empty('Parent',G1);
	H1 = uiextras.HBox('Parent',G1);
	hCursor1_Text = uicontrol('Parent',H1,'Style','text',...
                              'String','Cursor1:');
	hCursor1_Position = uicontrol('Parent',H1,'Style','edit',...
                              'String','');
	uiextras.Empty('Parent',G1);
	H3 = uiextras.HBox('Parent',G1);
	hCursor2_Text = uicontrol('Parent',H3,'Style','text',...
                              'String','Cursor2:');
	hCursor2_Position = uicontrol('Parent',H3,'Style','edit',...
                              'String','');
	uiextras.Empty('Parent',G1);
	uiextras.Empty('Parent',G1);
	H5 = uiextras.HBox('Parent',G1);
	hStep_Text = uicontrol('Parent',H5,'Style','text',...
                              'String','Step:');
	hStep_Edit = uicontrol('Parent',H5,'Style','edit',...
                              'String','');
	uiextras.Empty('Parent',G1);
	H2 = uiextras.HBox('Parent',G1);
	hSourcex_Text = uicontrol('Parent',H2,'Style','text',...
                              'String','Source(x):');
	hSourcex_Edit = uicontrol('Parent',H2,'Style','edit',...
                              'String','');
	uiextras.Empty('Parent',G1);
	H4 = uiextras.HBox('Parent',G1);
	hSourcey_Text = uicontrol('Parent',H4,'Style','text',...
                              'String','Source(y):');
	hSourcey_Edit = uicontrol('Parent',H4,'Style','edit',...
                              'String','');
	uiextras.Empty('Parent',G1);

	hPlotAxes = axes('Parent',V1_handle);
	xlim = get(hPlotAxes,'XLim');
	ylim = get(hPlotAxes,'YLim');
	cursor1 = imline(hPlotAxes,[(xlim(2)-xlim(1))*0.2 (xlim(2)-xlim(1))*0.2],ylim);
	cursor2 = imline(hPlotAxes,[(xlim(2)-xlim(1))*0.8 (xlim(2)-xlim(1))*0.8],ylim);
	cursorConstrainFcn = makeConstrainToRectFcn('imline',xlim,ylim);
	cursor1.setPositionConstraintFcn(cursorConstrainFcn);
	cursor2.setPositionConstraintFcn(cursorConstrainFcn);
	cursor1.addNewPositionCallback(@newPositionCallback);
	cursor2.addNewPositionCallback(@newPositionCallback);
	cursor1.setColor('r');
	cursor1pos = cursor1.getPosition();
	cursor2pos = cursor2.getPosition();
	set(hCursor1_Position,'String',num2str(cursor1pos(1,1)));
	set(hCursor2_Position,'String',num2str(cursor2pos(1,1)));

	lh = addlistener(FFR,'eFarfieldMeasurementCursorChanged',@updateCursorPosition);
	lh1 = addlistener(FFR,'eFarfieldMeasurementDataChanged',@updatePlotData);
	set(G1,'ColumnSizes',[-1,-1,-1],'RowSizes',[-1,20,-1,20,-1,20,-1],'Padding',10);
	set(V1,'Sizes',[-1,-4]);
	set(hPanel,'Visible','on');

	function newPositionCallback(hObject,eventdata)
		notify(FFR.Tonotify,'eFarfieldMeasurementCursorChanged');
	end
	function updateCursorPosition(hObject,eventdata)
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		set(hCursor1_Position,'String',num2str(cursor1pos(1,1)));
		set(hCursor2_Position,'String',num2str(cursor2pos(1,1)));
	end
	function updatePlotData(hObject,eventdata)
		axes(hPlotAxes);
		plot(FFR.xData,FFR.yData);
	end
	function Fast_Scan_Callback(hObject,eventdata)
		FFR.coarseScan;
	end
	function Fine_Scan_Callback(hObject,eventdata)
		from = str2num(get(hCursor1_Position,'String'));
		to = str2num(get(hCursor2_Position,'String'));
		step = str2num(get(hStep_Edit,'String'));
		FFR.fineScan(step,from,to);
	end
	function Export_Callback(hObject, eventdata)
		hf = figure;
		ha = axes('Parent',hf);
		hlines = findobj(hPlotAxes,'type','line');
		for i=1:length(hlines)
			set(hlines(i),'Parent',ha);
		end
	end
end
