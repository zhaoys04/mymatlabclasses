function f = ShowLayout(CP,hPanel)
	if (~exist('hPanel'))
		hPanel = figure('Position',[0 0 1024 768],'Visible','off');
		movegui(hPanel,'center');
	end
	hType = get(hPanel,'Type');
	if (strcmp(hType, 'uipanel')) 
		set(hPanel,'Title','Curve Processing');
	end
	marks = [{':'},{'-'},{'--'},{'-.'}];
	colors = ['k','b','r','g'];
	hlines = [];
%----------------UI Layout-----------------------
	
	H1 = uiextras.HBox('Parent',hPanel);
	V1 = uiextras.VBox('Parent',H1);
	V2 = uiextras.VBox('Parent',H1);
	V3 = uiextras.VBox('Parent',V1);
	hCurve  = CheckboxPanel(V3,'Curves');
	hCurve.Addnotify(CP);
	
	G2H1 = uiextras.HBox('Parent',V3);

	hResult  = uipanel('Parent', V1,'Title','Results');
	V4 = uiextras.VBox('Parent',hResult);
	hResultlist = uitable('Data',[],'Parent',V4,...
	   'ColumnWidth',{'auto'},'ColumnEditable',[false false]);
	H4 = uiextras.HBox('Parent',V4);

	V5 = uiextras.VBox('Parent',V2);
	uiextras.Empty('Parent',V5);
	H2 = uiextras.HBox('Parent',V5);
	uiextras.Empty('Parent',V5);
	set(V5,'Sizes',[-1,20,-1]);

	hCursorText = uicontrol('Parent',H2,'Style','text',...
		              'String','Cursor Position:');
	hCursor1Position = uicontrol('Parent',H2,'Style','edit',...
		              'String','Cursor1 Position:',...
			      'ForegroundColor','red',...
			      'Callback',{@SetCursor1Position});
	uiextras.Empty('Parent',H2);
	hCursor2Position = uicontrol('Parent',H2,'Style','edit',...
		              'String','Cursor2 Position:',...
			      'ForegroundColor','blue',...
			      'Callback',{@SetCursor2Position});
	uiextras.Empty('Parent',H2);
	GV1 = uiextras.VBox('Parent',V2);
	GH1 = uiextras.HBox('Parent',GV1);
	GH2 = uiextras.HBox('Parent',GV1);
	uiextras.Empty('Parent',GV1);
	set(GV1,'Sizes',[30,30,-1],'Spacing',5,'Padding',5);
	set(GH1,'Spacing',5);
	set(GH2,'Spacing',5);


	hMax = uicontrol('Parent',GH1,'Style','pushbutton',...
		              'String','Max',...
		              'Callback',{@Max_CallbackFcn});

	hMin = uicontrol('Parent',GH1,'Style','pushbutton',...
		              'String','Min',...
		              'Callback',{@Min_CallbackFcn});

	hFWHM = uicontrol('Parent',GH1,'Style','pushbutton',...
		              'String','FWHM',...
		              'Callback',{@FWHM_CallbackFcn});
	hSlope = uicontrol('Parent',GH1,'Style','pushbutton',...
		              'String','Slope',...
		              'Callback',{@Slope_CallbackFcn});
	hPeaks = uicontrol('Parent',GH1,'Style','pushbutton',...
		              'String','Peaks',...
		              'Callback',{@Peaks_CallbackFcn});
	hAverage = uicontrol('Parent',GH2,'Style','pushbutton',...
		              'String','Average',...
		              'Callback',{@Average_CallbackFcn});
	hDeriv = uicontrol('Parent',GH2,'Style','pushbutton',...
		              'String','dy/dx',...
		              'Callback',{@Deriv_CallbackFcn});
	hExport = uicontrol('Parent',GH2,'Style','pushbutton',...
		              'String','Export',...
		              'Callback',{@Export_CallbackFcn});

	hAddCurve = uicontrol('Parent',G2H1,'Style','pushbutton',...
				'String','Add',...
				'Callback',{@AddCurve});
	hLoadCurve = uicontrol('Parent',G2H1,'Style','pushbutton',...
				'String','Load',...
				'Callback',{@LoadCurve});
	hClearCurve = uicontrol('Parent',G2H1,'Style','pushbutton',...
				'String','Clear',...
				'Callback',{@ClearCurve});
	hRemoveCurve = uicontrol('Parent',G2H1,'Style','pushbutton',...
				'String','Remove',...
				'Callback',{@RemoveCurve});

	uiextras.Empty('Parent',H4);
	uiextras.Empty('Parent',H4);
	hExportData = uicontrol('Parent',H4,'Style','pushbutton',...
		              'String','Export Data',...
		              'Callback',{@ExportData_CallbackFcn});

	uiextras.Empty('Parent',GH2);
	uiextras.Empty('Parent',GH2);

	hPlotAxes = axes('Parent',V2);

	set(H1,'Sizes',[-1,-2]);
	set(V3,'Sizes',[-1,30]);
	set(V4,'Sizes',[-1,30]);
	set(V2,'Sizes',[-1,-2,-10],'Spacing',5,'Padding',5);
	set(G2H1,'Spacing',5);
	set(hPanel,'visible','on');

%-------------Cursors Initialize--------------
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
	set(hCursor1Position,'String',num2str(cursor1pos(1,1)));
	set(hCursor2Position,'String',num2str(cursor2pos(1,1)));

%-------add listener---------------------
	lh1 = event.listener(CP,'eCheckboxChecksChanged',@ChecksChangedCallback);
%-------Callback functions----------------
	function Export_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		h = figure;
		hNew_axes = axes('Parent',h);
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetDerivative(curvs);
		for i = 1:length(curvs)
			copyobj(hlines(curvs(i)),hNew_axes);
		end
	end

	function Deriv_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetDerivative(curvs);
		for i = 1:length(curvs)
			x = CP.Results.x{i};
			y = CP.Results.y{i};
			CP.AddCurve(x,y);
			lcolor = get(hlines(curvs(i)),'Color');
			hlines = [hlines,line('Parent',hPlotAxes,'XData',x,'YData',y,'Color',lcolor,'Marker','+','LineStyle','-')];
			hCurve.AddCheckbox([get(hCurve.chs(curvs(i)),'String'),'_deriv']);
		end
	end

	function Peaks_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		bound = [cursor1pos(1,1),cursor2pos(1,1)];
		bound = sort(bound);
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetPeaks(bound,curvs);
		for i = 1:length(curvs)
			x = CP.Results.x{i};
			y = CP.Results.y{i};
			CP.AddCurve(x,y);
			lcolor = get(hlines(curvs(i)),'Color');
			hlines = [hlines,line('Parent',hPlotAxes,'XData',x,'YData',y,'Color',lcolor,'Marker','*')];
			hCurve.AddCheckbox([get(hCurve.chs(curvs(i)),'String'),'_peaks']);
		end
	end

	function Slope_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		bound = [cursor1pos(1,1),cursor2pos(1,1)];
		bound = sort(bound);
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetSlope(bound,curvs);
		Data = cell(length(curvs),3);
		for i = 1:length(curvs)
			Data(i,1) = {get(hCurve.chs(curvs(i)),'String')};
			r = CP.Results{i};
			Data(i,2) = {r(1)};
			Data(i,3) = {r(2)};
		end
		set(hResultlist,'Data',Data);
	end

	function FWHM_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		bound = [cursor1pos(1,1),cursor2pos(1,1)];
		bound = sort(bound);
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetFWHM(bound,curvs);
		Data = cell(length(curvs),3);
		for i = 1:length(curvs)
			Data(i,1) = {get(hCurve.chs(curvs(i)),'String')};
			Data(i,2) = {CP.Results.FW(i)};
			Data(i,3) = {CP.Results.HM(i)};
		end
		set(hResultlist,'Data',Data);
	end

	function Min_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		bound = [cursor1pos(1,1),cursor2pos(1,1)];
		bound = sort(bound);
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetMin(bound,curvs);
		Data = cell(length(curvs),3);
		for i = 1:length(curvs)
			Data(i,1) = {get(hCurve.chs(curvs(i)),'String')};
			Data(i,2) = {CP.Results.x(i)};
			Data(i,3) = {CP.Results.y(i)};
		end
		set(hResultlist,'Data',Data);
	end

	function Max_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		bound = [cursor1pos(1,1),cursor2pos(1,1)];
		bound = sort(bound);
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetMax(bound,curvs);
		Data = cell(length(curvs),3);
		for i = 1:length(curvs)
			Data(i,1) = {get(hCurve.chs(curvs(i)),'String')};
			Data(i,2) = {CP.Results.x(i)};
			Data(i,3) = {CP.Results.y(i)};
		end
		set(hResultlist,'Data',Data);
	end

	function Average_CallbackFcn(hObject,eventdata)
		hCurve.GetChecks();
		curvs = [];
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		bound = [cursor1pos(1,1),cursor2pos(1,1)];
		bound = sort(bound);
		for i = 1:length(hCurve.cks)
			if hCurve.cks(i)== 1
				curvs = [curvs,i];
			end
		end
		CP.GetAverage(bound,curvs);
		Data = cell(length(curvs),2);
		for i = 1:length(curvs)
			Data(i,1) = {get(hCurve.chs(curvs(i)),'String')};
			Data(i,2) = {CP.Results(i)};
		end
		set(hResultlist,'Data',Data);
	end

	function ChecksChangedCallback(hObject,eventdata)
		cks = hCurve.cks;
		xmin = inf;
		xmax = -inf;
		ymin = inf;
		ymax = -inf;
		for i = 1:length(cks)
			if cks(i) == 0
				set(hlines(i),'visible','off');
			else
				set(hlines(i),'visible','on');
				xdata = get(hlines(i),'XData');
				ydata = get(hlines(i),'YData');
				xmin = min(xmin,min(xdata));
				xmax = max(xmax,max(xdata));
				ymin = min(ymin,min(ydata));
				ymax = max(ymax,max(ydata));
			end
		end
		set(hPlotAxes,'XLim',[xmin,xmax],'YLim',[ymin-(ymax-ymin)*0.1,ymax+(ymax-ymin)*0.1]);
		UpdateCursors();
	end
	function newPositionCallback(pos)
		cursor1pos = cursor1.getPosition();
		cursor2pos = cursor2.getPosition();
		set(hCursor1Position,'String',num2str(cursor1pos(1,1)));
		set(hCursor2Position,'String',num2str(cursor2pos(1,1)));
	end

	function UpdateCursors()
		xlim = get(hPlotAxes,'XLim');
		ylim = get(hPlotAxes,'YLim');
		cursorConstrainFcn = makeConstrainToRectFcn('imline',xlim,ylim);
		cursor1.setPositionConstraintFcn(cursorConstrainFcn);
		cursor2.setPositionConstraintFcn(cursorConstrainFcn);
		pos1 = cursor1.getPosition();
		pos2 = cursor2.getPosition();
		cursor1.setPosition([pos1(1,1),ylim(1);pos1(2,1),ylim(2)]);
		cursor2.setPosition([pos2(1,1),ylim(1);pos2(2,1),ylim(2)]);

	end
	function AddCurve(hObject, eventdata)
		evalin('base','s = who;');
		s = evalin('base','s');
		hF = figure('name','Add a curve from workspace','position',[0,0,300,200]);
		movegui(hF,'center');
		V1 = uiextras.VBox('Parent',hF);
		uiextras.Empty('Parent',V1);
		H1 = uiextras.HBox('Parent',V1);
		H2 = uiextras.HBox('Parent',V1);
		uiextras.Empty('Parent',V1);
		H3 = uiextras.HBox('Parent',V1);
		hXdataText = uicontrol('Parent',H1,'Style','text',...
		              'String','XData:');
		hXdata = uicontrol('Parent',H1,'Style','popupmenu','String',s);
		uiextras.Empty('Parent',H1);
		hYdataText = uicontrol('Parent',H2,'Style','text',...
		              'String','YData:');
		hYdata = uicontrol('Parent',H2,'Style','popupmenu','String',s);
		uiextras.Empty('Parent',H2);
		uiextras.Empty('Parent',H3);
		hOKButton = uicontrol('Parent',H3,'Style','pushbutton',...
					'String','OK','Callback',{@OKCallback});
		hCancelButton = uicontrol('Parent',H3,'Style','pushbutton',...
					'String','Cancel','Callback',{@CancelCallback});
		
		function OKCallback(hObject,eventdata)
			xdata = s{get(hXdata,'Value')};
			ydata = s{get(hYdata,'Value')};
			x = evalin('base',xdata);
			y = evalin('base',ydata);
			CP.AddCurve(x,y);
			hCurve.AddCheckbox(['curve',num2str(length(CP.Curves.x))]);
			lcolor = mod(mod(length(CP.Curves.x), length(colors)), length(marks))+1;
			lmark = mod(floor(length(CP.Curves.x)/length(colors))+1, length(colors)) + 1;
			hlines = [hlines,line('Parent',hPlotAxes,'XData',CP.Curves.x{end},'YData',CP.Curves.y{end},'LineStyle',marks{lmark},'Color',colors(lcolor))];
			UpdateCursors();
			close(hF);
		end

		function CancelCallback(hObject,eventdata)
			close(hF);
		end

	end

	function LoadCurve(hObject, eventdata)
		[filename,pathname] = uigetfile({'*.mat'},'File Selector');
		if isequal(filename,0)
			return;
		end
		s = who('-file',[pathname,'/',filename]);
		hF = figure('name','Add a curve from workspace','position',[0,0,300,200]);
		movegui(hF,'center');
		V1 = uiextras.VBox('Parent',hF);
		uiextras.Empty('Parent',V1);
		H1 = uiextras.HBox('Parent',V1);
		H2 = uiextras.HBox('Parent',V1);
		uiextras.Empty('Parent',V1);
		H3 = uiextras.HBox('Parent',V1);
		hXdataText = uicontrol('Parent',H1,'Style','text',...
		              'String','XData:');
		hXdata = uicontrol('Parent',H1,'Style','popupmenu','String',s);
		uiextras.Empty('Parent',H1);
		hYdataText = uicontrol('Parent',H2,'Style','text',...
		              'String','YData:');
		hYdata = uicontrol('Parent',H2,'Style','popupmenu','String',s);
		uiextras.Empty('Parent',H2);
		uiextras.Empty('Parent',H3);
		hOKButton = uicontrol('Parent',H3,'Style','pushbutton',...
					'String','OK','Callback',{@OKCallback});
		hCancelButton = uicontrol('Parent',H3,'Style','pushbutton',...
					'String','Cancel','Callback',{@CancelCallback});
		
		function OKCallback(hObject,eventdata)
			xdata = s{get(hXdata,'Value')};
			ydata = s{get(hYdata,'Value')};
			r = load([pathname,'/',filename],xdata,ydata);
			x = getfield(r,xdata);
			y = getfield(r,ydata);
			CP.AddCurve(x,y);
			hCurve.AddCheckbox(['curve',num2str(length(CP.Curves.x))]);
			lcolor = mod(mod(length(CP.Curves.x), length(colors)), length(marks))+1;
			lmark = mod(floor(length(CP.Curves.x)/length(colors))+1, length(colors)) + 1;
			hlines = [hlines,line('Parent',hPlotAxes,'XData',CP.Curves.x{end},'YData',CP.Curves.y{end},'LineStyle',marks{lmark},'Color',colors(lcolor))];
			UpdateCursors();
			close(hF);
		end

		function CancelCallback(hObject,eventdata)
			close(hF);
		end

	end
	function RemoveCurve(hObject, eventdata)
		hCurve.GetChecks();
		curvs = [];
		L = (hCurve.cks == 1);
		delete(hlines(L));
		hlines = hlines(~L);
		hCurve.RemoveCheckbox(L);
	end
	function ClearCurve(hObject, eventdata)
		delete(hlines);
		hlines = [];
		hCurve.RemoveCheckbox(logical(ones(1,length(hCurve.chs))));
	end
	function SetCursor1Position(hObject,eventdata)
		cursor1pos = cursor1.getPosition();
		cursor1.setPosition([str2num(get(hCursor1Position,'String')),cursor1pos(1,2);str2num(get(hCursor1Position,'String')),cursor1pos(2,2)]);
	end
	function SetCursor2Position(hObject,eventdata)
		cursor2pos = cursor2.getPosition();
		cursor2.setPosition([str2num(get(hCursor2Position,'String')),cursor2pos(1,2);str2num(get(hCursor2Position,'String')),cursor2pos(2,2)]);
	end
end
