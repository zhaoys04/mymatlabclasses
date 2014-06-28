function f = initialize(MT)
	MT.materialList = [];
	filepath =  '/home/zhaoys/Dropbox/research/Programs/Classes_for_Matlab/@Material/';
	filelist = dir([filepath,'/materials/*.txt']);
	for i=1:length(filelist)
		fp = fopen([filepath,'/materials/',filelist(i).name],'r');
		nameline = fgetl(fp);
		noteline = fgetl(fp);
		howtocallline = fgetl(fp);
		m = strfind(nameline, ':');
		name = nameline(m+1:end);
		m = strfind(noteline, ':');
		note = noteline(m+1:end);
		m = strfind(howtocallline, ':');
		howtocall = howtocallline(m+1:end);
		data = dlmread([filepath,'/materials/',filelist(i).name],',',3,0);
		material.name = name;
		material.des = note;
		material.howtocall = howtocall;
		material.data = data;
		MT.materialList = [MT.materialList,material];
		fclose(fp);
	end
end
