function f = Set_Wavelength(PM, Wavelength)
    if PM.ConnectedByUSB
        PM.SendCommandviaUSB(['PM:Lambda ', num2str(Wavelength)]);
        pause(0.1);
        PM.Get_Wavelength;
        f = 1;
    else
        fprintf(PM.device_obj, ['PM:Lambda ', num2str(Wavelength)]);
        pause(0.1);
        PM.Get_Wavelength;
        f = 1;
    end
end
