function f = Get_Voltage(DC)
    V = query(DC.gpib_obj,'VOLTAGE?');
    DC.Voltage = V;
    f = V;
end
