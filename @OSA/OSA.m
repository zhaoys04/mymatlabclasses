classdef OSA < handle
	% OSA
	%
	% This class provides remote control through gpib interface
	%
	% OSA Properties:
	% 	gpib_obj  (0) - Handle of gpib obj of current source 
	% 	gpib_address  - Gpib address of current source
	% 	wavelength - Wavelength of spectrum
	% 	amplitude - Amplitude of spectrum
	% 	Tonotify - Vector of hObjects to be notified
	%
	%OSA Methods:
	%	ShowLayout(hPanel) - Show a default GUI of current source. hPanel can be handle of uipanel. If omitted, a new figure will be created.
	%	Connect() - Establish connection to osa through gpib
	%	Disconnect() - Disconnect the gpib connection from osa
	%	Get_Spectrum() - Query the spectrum on osa now
	%
	% Example:
	% 	OSA = OSA(gpib_address, tonotify);
	%
	properties (Access = protected)
		gpib_obj = 0;
	end
	properties (SetAccess = protected, GetAccess = public)
		gpib_address;
		Tonotify = [];
		wavelength;
		amplitude;
    end
	methods 
		function OS = OSA(gpib_address,tonotify)
			if nargin > 0
				OS.gpib_address = gpib_address;
			else
				OS.gpib_address = 0;
			end
			OS.Tonotify = [OS, tonotify];
		end
		f = ShowLayout(OS,hPanel);
		f = Connect(OS);
		f = Disconnect(OS);
		f = Get_Spectrum(OS);
	end
end
