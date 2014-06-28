function f = ShowLayout(SB,hFigure)
	clf(hFigure);
	hLayout = uiextras.VBox('Parent',hFigure,'Tag','hLayout');
	hTryfield = uicontrol('Parent',hLayout,'Style','edit',...
	                         'String','',...
				'HorizontalAlignment','left',...
	                         'Max',100,'Min',1);
	hButtonLayout = uiextras.HBox('Parent',hLayout,'Tag','hButtonLayout');
	hExecute = uicontrol('Parent',hButtonLayout,'Style','pushbutton',...
	                         'String','Run',...
				'Callback',{@ExecuteCallback});
	hClear = uicontrol('Parent',hButtonLayout,'Style','pushbutton',...
	                         'String','Clear',...
				'Callback',{@ClearCallback});
	hWrap = uicontrol('Parent',hButtonLayout,'Style','pushbutton',...
	                         'String','Wrap',...
				'Callback',{@WrapCallback});
	hSave = uicontrol('Parent',hButtonLayout,'Style','pushbutton',...
	                         'String','Save',...
				'Callback',{@SaveCallback});
	hLoad = uicontrol('Parent',hButtonLayout,'Style','pushbutton',...
	                         'String','Load',...
				'Callback',{@LoadCallback});
	set(hLayout,'Sizes',[-1,40],'Spacing',10,'Padding',10);
	set(hButtonLayout,'Spacing',10);
	movegui(hFigure,'center');
	set(hFigure,'Visible','on');
	
	function ExecuteCallback(hObject,eventdata)
		display('running...');
		codes = get(hTryfield,'String');
		s = size(codes);
		for i=1:s(1)
			evalin('base',codes(i,:));
		end
		display('done');

	end
	function ClearCallback(hObject,eventdata)
		set(hTryfield,'String','');
	end
	function WrapCallback(hObject,eventdata)
		J = com.mathworks.mde.desk.MLDesktop.getInstance;
		b = J.getClient(SB.FigureName);
		c = b.getComponent(0).getComponent(0).getComponent(0).getComponents;
		SelectedText = b.getComponent(0).getComponent(0).getComponent(0).getComponent(length(c)-1).getComponent(0).getViewport.getComponent(0).getSelectedText;
		codes = SelectedText.split('\n');
		s = length(codes);
		i = 1;
		gotFunctionName=0;
		while (i<=s && gotFunctionName==0)
			d = codes(i).toCharArray;
			d = d';
			[v1,v2]=regexp(d,'function\ ');
			if (v1>0)
				[v1,v2]=regexp(d,'[=\ ]?[a-zA-Z0-9_]*(');
				gotFunctionName = 1;
				FunctionName = d(v1+1:v2-1);
			end
			i = i + 1;
		end
		if gotFunctionName
			f = fopen([SB.TempPath,'/',FunctionName,'.m'],'w');
			for j = i-1:s
				d = codes(j).toCharArray;
				d = d';
				fprintf(f,'%s\n',d);
			end
			fclose(f);
		end
		msgbox(['The file is saved at',SB.TempPath,'/',FunctionName,'.m']);
	end
	function SaveCallback(hObject,eventdata)
		[Filename,PathName,FilterIndex] = uiputfile({'*.m';'*.*'},'Save the script as');
		if (Filename ~= 0)
			f = fopen([PathName,'/',Filename],'w');
			codes = get(hTryfield,'String');
			s = size(codes);
			for i=1:s(1)
				fprintf(f,'%s\n',codes(i,:));
			end
			fclose(f);
		end
	end
	function LoadCallback(hObject,eventdata)
		[Filename,PathName,FilterIndex] = uigetfile({'*.m';'*.*'},'Save the script as');
		codes = [];
		if (Filename ~= 0)
			f = fopen([PathName,'/',Filename],'r');
			while ~feof(f)
				s = fgetl(f);
				codes = [codes;{s}];
			end
			fclose(f);
			set(hTryfield,'String',codes);
		end
	end

end
