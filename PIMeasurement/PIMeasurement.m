function PIMeasurement()
f1 = figure('Visible','off','Position',[0,0,400,300]);
f1_data.OK = false;
hV = uiextras.VBox('Parent',f1);
uiextras.Empty('Parent',hV);
hHH1 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);
hHH2 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);
hHH3 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);
hHH4 = uiextras.HBox('Parent',hV);
uiextras.Empty('Parent',hV);

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
hgpib_PM_Text = uicontrol('Parent',hHH3,'Style','Text',...
			'String','Connection type of Power Meter:');
hgpib_PM_Edit = uicontrol('Parent',hHH3,'style','popupmenu','String',{'usb','com1','com2','com3','com4','com5'});
fd.hgpib_PM_Edit = hgpib_PM_Edit;
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
set(hV,'Sizes',[-1,30,-1,30,-1,30,-1,30,10]);
set(hHH1,'Sizes',[10,-1,-1,10]);
set(hHH2,'Sizes',[10,-1,-1,10]);
set(hHH3,'Sizes',[10,-1,-1,10]);
set(hHH4,'Sizes',[10,-1,-1,-1,-1,10]);

LoadDefault_Callback;

movegui(f1,'center');
set(f1,'Visible','on');

function OK_Callback(hObject, eventdata)
	fd = guidata(f1);
	f1_data.gpibCS = str2num(get(fd.hgpib_CS_Edit,'String'));
	f1_data.gpibTC = str2num(get(fd.hgpib_TC_Edit,'String'));
	f1_data.gpibPM = get(fd.hgpib_PM_Edit,'Value');
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
	set(fd.hgpib_PM_Edit,'Value',A(3));
end

function SaveDefault_Callback(hObject, eventdata)
	fd = guidata(f1);
	f1_data.gpibCS = get(fd.hgpib_CS_Edit,'String');
	f1_data.gpibTC = get(fd.hgpib_TC_Edit,'String');
	f1_data.gpibPM = get(fd.hgpib_PM_Edit,'Value');
	ff = fopen('default_value.txt','w');
	fprintf(ff,'%s,%s,%d',f1_data.gpibCS,f1_data.gpibTC,f1_data.gpibPM);
	fclose(ff);
end

uiwait(f1);

if (f1_data.OK == true)
	f = figure('Visible','off','Position',[0,0,1400,768]);
	hH1 = uiextras.HBox('Parent',f);
	hV1 = uiextras.VBox('Parent',hH1);
	hV2 = uiextras.VBox('Parent',hH1);
	hCurrent_Source_Panel = uipanel('Parent',hV1,'Title','Current Source');
	hTemperature_Controller_Panel = uipanel('Parent',hV1,'Title','Temperature Controller');
	hPower_Meter_Panel = uipanel('Parent',hV2,'Title','Power Meter');
	hResult_Panel = uipanel('Parent',hV2,'Title','Result');
	set(hH1,'Sizes',[650,-1]);
	set(hV2,'Sizes',[250,-1]);
	CS2 = CSILX3744B(f1_data.gpibCS,[]);
	TC2 = TCITC503(f1_data.gpibTC,[]);
	if (f1_data.gpibPM == 1)
		PM2 = PMNewPort1931(3,1);   %Connect by USB
	else
		PM2 = PMNewPort1931(['com',num2str(f1_data.gpibPM-1)]);  % Connect by serial port
	end
	LI2 = LIResult(CS2,PM2,TC2);
	CS2.ShowLayout(hCurrent_Source_Panel);
	TC2.ShowLayout(hTemperature_Controller_Panel);
	PM2.ShowLayout(hPower_Meter_Panel);
	LI2.ShowLayout(hResult_Panel);
	movegui(f,'center');
	set(f,'Visible','on');
end

end
