function f = Get_Voltage(MM)
    V = str2num(query(MM.gpib_obj,'SENS:DATA?'));
    MM.Voltage = V;
    f = V;
end
