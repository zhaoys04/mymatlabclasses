function f = Fastspeed(LM)
    [v3 v4 v5 v6] = LM.entryToBits(1/0.001984375);
    setSpeed = [0 42 v3 v4 v5 v6];
    fwrite(LM.device_obj,setSpeed,'uint8');
end
