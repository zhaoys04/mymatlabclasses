function SpectrumMeasurement()
f1 = figure('Visible','off','Position',[0,0,400,300]);
f1_data.OK = false;
f1_data.toggle = 0;
hV = uiextras.VBox('Parent',f1);
uiextras.Empty('Parent',hV);
hHH5 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);
hHH1 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);
hHH2 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);
hHH3 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);
hHH4 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);

uiextras.Empty('Parent',hHH5);
htoggle = uicontrol('Parent',hHH5,'style','togglebutton','String','Single',...
			'Callback',{@toggle_Callback});
uiextras.Empty('Parent',hHH5);
fd.htoggle = htoggle;

uiextras.Empty('Parent',hHH1);
hgpib_CS_Text = uicontrol('Parent',hHH1,'Style','Text',...
			'String','GPIB address of Current Source:');
hgpib_CS_Edit = uicontrol('Parent',hHH1,'style','edit','String','');
uiextras.Empty('Parent',hHH1);

fd.hgpib_CS_Edit = hgpib_CS_Edit;
uiextras.Empty('Parent',hHH2);
hgpib_TC_Text = uicontrol('Parent',hHH2,'Style','Text',...
			'String','GPIB address of Temperature Controller:');
hgpib_TC_Edit = uicontrol('Parent',hHH2,'style','edit','String','');
uiextras.Empty('Parent',hHH2);
fd.hgpib_TC_Edit = hgpib_TC_Edit;

uiextras.Empty('Parent',hHH3);
hgpib_OSA_Text = uicontrol('Parent',hHH3,'Style','Text',...
			'String','GPIB address of OSA:');
hgpib_OSA_Edit = uicontrol('Parent',hHH3,'style','edit','String','');
fd.hgpib_OSA_Edit = hgpib_OSA_Edit;
uiextras.Empty('Parent',hHH3);

uiextras.Empty('Parent',hHH4);
hLoadDefault = uicontrol('Parent',hHH4,'Style','pushbutton',...
			'String','Load Default',...
			'Callback',{@LoadDefault_Callback});
hSaveDefault = uicontrol('Parent',hHH4,'Style','pushbutton',...
			'String','Save as  Default',...
			'Callback',{@SaveDefault_Callback});
hOK = uicontrol('Parent',hHH4,'Style','pushbutton',...
			'String','OK',...
			'Callback',{@OK_Callback});
hCancel = uicontrol('Parent',hHH4,'Style','pushbutton',...
			'String','Cancel',...
			'Callback',{@Cancel_Callback});
uiextras.Empty('Parent',hHH4);

guidata(f1,fd);
set(hV,'Sizes',[-1,30,-1,30,-1,30,-1,30,-1,30,10]);
set(hHH1,'Sizes',[10,-1,-1,10]);
set(hHH2,'Sizes',[10,-1,-1,10]);
set(hHH3,'Sizes',[10,-1,-1,10]);
set(hHH4,'Sizes',[10,-1,-1,-1,-1,10]);

%LoadDefault_Callback;

movegui(f1,'center');
set(f1,'Visible','on');

function OK_Callback(hObject, eventdata)
	fd = guidata(f1);
	f1_data.gpibCS = str2num(get(fd.hgpib_CS_Edit,'String'));
	f1_data.gpibTC = str2num(get(fd.hgpib_TC_Edit,'String'));
	f1_data.gpibOSA = get(fd.hgpib_OSA_Edit,'String');
	f1_data.OK = true;
	close(f1);
end

function Cancel_Callback(hObject, eventdata)
	f1_data.OK = false;
	close(f1);
end

function LoadDefault_Callback(hObject, eventdata)
	fd = guidata(f1);
	A = dlmread('default_value.txt');
	set(fd.hgpib_CS_Edit,'String',A(1));
	set(fd.hgpib_TC_Edit,'String',A(2));
	set(fd.hgpib_OSA_Edit,'String',A(3));
end

function SaveDefault_Callback(hObject, eventdata)
	fd = guidata(f1);
	f1_data.gpibCS = get(fd.hgpib_CS_Edit,'String');
	f1_data.gpibTC = get(fd.hgpib_TC_Edit,'String');
	f1_data.gpibOSA = get(fd.hgpib_OSA_Edit,'String');
	ff = fopen('default_value.txt','w');
	fprintf(ff,'%s,%s,%s',f1_data.gpibCS,f1_data.gpibTC,f1_data.gpibOSA);
	fclose(ff);
end

function toggle_Callback(hObject, eventdata)
	fd = guidata(f1);
	f1_data.toggle = get(fd.htoggle,'value');
	if (get(fd.htoggle,'value') == 0)
		set(fd.htoggle,'String','Single');
		set(fd.hgpib_CS_Edit,'Enable','off');
		set(fd.hgpib_TC_Edit,'Enable','off');
	else
		set(fd.htoggle,'String','Full');
		set(fd.hgpib_CS_Edit,'Enable','on');
		set(fd.hgpib_TC_Edit,'Enable','on');
	end
end

uiwait(f1);

if (f1_data.OK == true)
	if (f1_data.toggle == 1)
		f = figure('Visible','off','Position',[0,0,1400,768]);
		hV1 = uiextras.VBox('Parent',f);
		hH1 = uiextras.HBox('Parent',hV1);

		hCurrent_Source_Panel = uipanel('Parent',hH1,'Title','Current Source');
		hTemperature_Control_Panel = uipanel('Parent',hH1,'Title','Temperature Controller');
		hSpectrumResult_Panel = uipanel('Parent',hV1,'Title','Spectrum');
	
		CS2 = CSILX3744B(f1_data.gpibCS,[]);
		TC2 = TCITC503(f1_data.gpibTC,[]);
		OS2 = OSA(f1_data.gpibOSA,[]);

		CS2.ShowLayout(hCurrent_Source_Panel);
		TC2.ShowLayout(hTemperature_Control_Panel);
		OS2.ShowLayout(hSpectrumResult_Panel);
		set(hV1,'Sizes',[200,-1]);
		movegui(f,'center');
		set(f,'Visible','on');
	else
		f = figure('Visible','off','Position',[0,0,1400,768]);
		hSpectrumResult_Panel = uipanel('Parent',f,'Title','Spectrum');
	
		OS2 = OSA(f1_data.gpibOSA,[]);
		OS2.ShowLayout(hSpectrumResult_Panel);
		movegui(f,'center');
		set(f,'Visible','on');

	end

end
end
