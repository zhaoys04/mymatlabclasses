classdef Sandbox < handle
	properties (SetAccess = protected, GetAccess = public)
		hFigure;
		FigureName;
		TempPath;
	end
	methods 
		function SB = Sandbox
			SB.TempPath = '/home/zhaoys/.matlab/R2008b/';
			evalin('base',['path(''',SB.TempPath,''',path)']);
			evalin('base','import javax.swing.*');
			SB.FigureName = ['Sandbox_',datestr(now,30)];
			SB.hFigure = figure('Visible','off','Position',[0,0,1024,768],'Name',SB.FigureName,'numbertitle','off');
			SB.ShowLayout(SB.hFigure);
		end
		f = ShowLayout(SB,hFigure);
	end
end
