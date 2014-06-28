function f = Update_binaryconv(TDS)
	TDS.binaryconv = sparse(1:TDS.data_num, 1:2:TDS.data_num*2, bitshift(1,8)*ones(1,TDS.data_num), TDS.data_num, TDS.data_num*2)...
               +sparse(1:TDS.data_num, 2:2:TDS.data_num*2, ones(1,TDS.data_num), TDS.data_num, TDS.data_num*2);
	f = 1;
end
