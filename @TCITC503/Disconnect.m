function f = Disconnect(TC)
        if strcmp(TC.gpib_obj.Status,'open')
		fclose(TC.gpib_obj);
		f = 1;
	end
end
