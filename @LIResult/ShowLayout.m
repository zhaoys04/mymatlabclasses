function f = ShowLayout(LI,hPanel)
	if (~exist('hPanel'))
		display(1)
		hPanel = figure('Position',[0 0 1024 768]);
		movegui(hPanel,'center');
	end
	hPanelLayout = uiextras.VBox('Parent',hPanel,'Tag','hPanelLayout');
	hPanelLayout_handle = findobj(hPanel,'Tag','hPanelLayout');
 	hCurrentSweepLayout = uiextras.HBox('Parent',hPanelLayout,'Tag','hCurrentSweepLayout');
	hCurrentSweepLayout_handle = findobj(hPanel,'Tag','hCurrentSweepLayout');
 	hSampleSaveLayout = uiextras.HBox('Parent',hPanelLayout,'Tag','hSampleSaveLayout');
	hSampleSaveLayout_handle = findobj(hPanel,'Tag','hSampleSaveLayout');
 	hSampleLayout = uiextras.HBox('Parent',hSampleSaveLayout,'Tag','hSampleLayout');
	hSampleLayout_handle = findobj(hPanel,'Tag','hSampleLayout');
 	hAxesButtonLayout = uiextras.HBox('Parent',hPanelLayout,'Tag','hAxesButtonLayout');
	hAxesButtonLayout_handle = findobj(hPanel,'Tag','hAxesButtonLayout');
 	hCurrent_Start_Text = uicontrol('Parent',hCurrentSweepLayout_handle,'Style','text',...
                                    'String','Current(mA) from');
 	hCurrent_Start_Edit = uicontrol('Parent',hCurrentSweepLayout_handle,'Style','edit',...
                                    'String','0');
 	htext1 = uicontrol('Parent',hCurrentSweepLayout_handle,'Style','text',...
                                    'String','to');
 	hCurrent_End_Edit = uicontrol('Parent',hCurrentSweepLayout_handle,'Style','edit',...
        	                           'String','0');
 	hCurrent_Step_Text = uicontrol('Parent',hCurrentSweepLayout_handle,'Style','text',...
                                    'String','Step by');
 	hCurrent_Step_Edit = uicontrol('Parent',hCurrentSweepLayout_handle,'Style','edit',...
                                    'String','0');
 	hContinue_Save_Prefix_Text = uicontrol('Parent',hSampleLayout_handle,'Style','text',...
                                          'String','Prefix');
 	hContinue_Save_Prefix_Edit = uicontrol('Parent',hSampleLayout_handle,'Style','edit',...
                                          'String','');
 	hContinue_Save_Suffix_Text = uicontrol('Parent',hSampleLayout_handle,'Style','text',...
                                          'String','Suffix Next:');
 	hContinue_Save_Suffix_Edit = uicontrol('Parent',hSampleLayout_handle,'Style','edit',...
                                          'String','');
 	hSaveToDatabase = uicontrol('Parent',hSampleSaveLayout_handle,'Style','checkbox',...
 		'String','save to database','value',0,...
 		'Callback',{@SaveStatusChanged});
	hAxesBoxesLayout = uiextras.VBox('Parent',hAxesButtonLayout_handle,'Tag','hAxesBoxesLayout');
	hAxesBoxesLayout_handle = findobj(hAxesButtonLayout_handle,'Tag','hAxesBoxesLayout');
	hAxesPanel = uipanel('Parent',hAxesBoxesLayout_handle);
	hContinue_Measurement_Plot_LI = axes('Parent',hAxesPanel);
 	ylabel('Light Intensity(W)');

	hContinue_Measurement_Plot_IV = axes('Parent',hAxesPanel,'Color','none');
	xlabel('Current(mA)');ylabel('Voltage(V)');
	set(hContinue_Measurement_Plot_IV,'Position',get(hContinue_Measurement_Plot_LI,'Position'),...
                                    'YAxisLocation','right','YColor','g','Units','normalized');

	hButtonLayout = uiextras.VBox('Parent',hAxesButtonLayout_handle,'Tag','hButtonLayout');
	hButtonLayout_handle = findobj(hAxesButtonLayout_handle,'Tag','hButtonLayout');
 	uiextras.Empty('Parent',hButtonLayout_handle);
 	hContinue_Measurement_Start = uicontrol('Parent',hButtonLayout_handle,...
                                    'Style','pushbutton',...
                                    'String','Start',...
                                    'CallBack',{@Start_Continue_Measurement});
 	hContinue_Measurement_Stop = uicontrol('Parent',hButtonLayout_handle,...
                                    'Style','pushbutton',...
                                    'String','Stop',...
                                    'CallBack',{@Stop_Continue_Measurement});
 	hSave = uicontrol('Parent',hButtonLayout_handle,...
                                    'Style','pushbutton',...
                                    'String','Save',...
                                    'CallBack',{@Save_Callback});
 	hGet_Sample = uicontrol('Parent',hButtonLayout_handle,...
                                    'Style','pushbutton',...
                                    'String','Get SampleID',...
 				   'Enable','off',...
                                    'CallBack',{@Get_SampleID});
 	hCreate_Sample = uicontrol('Parent',hButtonLayout_handle,...
                                    'Style','pushbutton',...
                                    'String','Create Sample',...
 				   'Enable','off',...
                                    'CallBack',{@Create_Sample});
	uiextras.Empty('Parent',hButtonLayout_handle);

 	set(hPanelLayout,'Sizes',[20,20,-1],'Padding',20,'Spacing',10);
 	set(hAxesButtonLayout,'Sizes',[-1,150]);
 	set(hButtonLayout,'Spacing',10,'Sizes',[-1,35,35,35,35,35,70]);
	set(hCurrentSweepLayout,'Sizes',[150,-1,100,-1,100,-1]);
 	set(hSampleSaveLayout,'Sizes',[-1,200],'Spacing',10);
 	set(hSampleLayout,'Sizes',[150,-1,100,-1]);
	function SaveStatusChanged(hObject,eventdata)
		SaveStatus = get(hSaveToDatabase,'Value');
		children = get(hSampleLayout,'Children');
		delete(children);
		if SaveStatus == 1
			hSampleID_text = uicontrol('Parent',hSampleLayout,'Style','text',...
                                         'String','SampleID:');
			hSampleID = uicontrol('Parent',hSampleLayout,'Style','text',...
                                         'String','','backgroundcolor','white');
			set(hSampleLayout,'Sizes',[150,-1]);
			set(hGet_Sample,'Enable','on');
			set(hCreate_Sample,'Enable','on');
		else
			hContinue_Save_Prefix_Text = uicontrol('Parent',hSampleLayout,'Style','text',...
                                         'String','Prefix');
			hContinue_Save_Prefix_Edit = uicontrol('Parent',hSampleLayout,'Style','edit',...
                                         'String','');
			hContinue_Save_Suffix_Text = uicontrol('Parent',hSampleLayout,'Style','text',...
                                         'String','Suffix Next:');
			hContinue_Save_Suffix_Edit = uicontrol('Parent',hSampleLayout,'Style','edit',...
                                         'String','');
			set(hSampleLayout,'Sizes',[150,-1,100,-1]);
			set(hGet_Sample,'Enable','off');
			set(hCreate_Sample,'Enable','off');
		end
	end
	function Start_Continue_Measurement(hObject,eventdata)
		Start_Current = str2num(get(hCurrent_Start_Edit,'String'));
		End_Current = str2num(get(hCurrent_End_Edit,'String'));
		Step = str2num(get(hCurrent_Step_Edit,'String'));
		I = [Start_Current:Step:End_Current];
		n = length(I);
		LI.NewMeasurement(I(1));
		delete(findobj(hContinue_Measurement_Plot_LI,'type','line'));
		delete(findobj(hContinue_Measurement_Plot_IV,'type','line'));
		hLIline = line(LI.Results.I,LI.Results.L,'Parent',hContinue_Measurement_Plot_LI);
		hIVline = line(LI.Results.I,LI.Results.V,'Parent',hContinue_Measurement_Plot_IV,'Color','g');
%		set(hContinue_Measurement_Plot_IV,'Position',get(hContinue_Measurement_Plot_LI,'Position'));
		for x = 2:n
			LI.AppendMeasurement(I(x));
			set(hLIline,'Xdata',LI.Results.I,'YData',LI.Results.L);
			set(hIVline,'Xdata',LI.Results.I,'YData',LI.Results.V);
%			set(hContinue_Measurement_Plot_IV,'Position',get(hContinue_Measurement_Plot_LI,'Position'));
			pause(1e-6);
		end
	end
	function Save_Callback(hObject,eventdata)
		SaveStatus = get(hSaveToDatabase,'Value');
		if (SaveStatus == 1) % going to save to database 
			resultid = datestr(now,'yyyymmddTHHMMSSFFF');
			filename = [resultid,'.mat'];
		        I = LI.Results.I;
		        V = LI.Results.V;
		        L = LI.Results.L;
			save(filename,'I','V','L');
			sampleid = get(hSampleID,'String');
			resultTableName = ['Result_20120504T120205977'];% fixme need to select from a results list;
			Date = datestr(now,'yyyy-mm-dd');
			Raw = 1;
			c = clock;
			newfilename = num2str(dec2hex(str2num([num2str(c(1)),num2str(c(2)),num2str(c(3)),num2str(c(4)),num2str(c(5)),num2str(floor(c(6)*1000))]),20));
			LI.hDB.InsertRow('Results_filetype',{'result_id','file_type'},{resultid,'mat'});
			LI.hDB.InsertRow(resultTableName,{},{resultid,sampleid,num2str(Raw),['/',newfilename],Date});
%			LI.hDB.InsertRow('Results_comments',{},{resultid,get(hResult_comment,'String')});
			conditionTableName = 'Condition_20120516T170942163';  %CW pumping condition fixme: need to select from a conditions list;
			LI.hTempControl.GetTemperature;
			Data = {LI.hTempControl.Temperature_Read,min(I),max(I)};
			LI.hDB.InsertRow(conditionTableName,{},[{resultid},Data]);
			LI.hFTP.Upload({filename});
			index = strfind(filename,'/');
			oldfilename = filename(index(end)+1:end);
			LI.hFTP.Rename({oldfilename},{newfilename}); %fixme: need test
		else
			prefix = get(hContinue_Save_Prefix_Edit,'String');
			suffix = get(hContinue_Save_Suffix_Edit,'String');
			set(hContinue_Save_Suffix_Edit,'String',num2str(str2num(suffix)+1));
			filename = [prefix,'_',suffix,'.mat'];
		        I = LI.Results.I;
		        V = LI.Results.V;
		        L = LI.Results.L;
			save(filename,'I','V','L');
		end
	end
end
