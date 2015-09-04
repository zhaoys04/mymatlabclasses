function f = Set_Voltage(DC,V)
    fwrite(DC.gpib_obj,['VOLTAGE ',num2str(V)]);
end
