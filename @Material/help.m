function f = help(MT,name)
	if (~exist('name'))
		for i = 1:length(MT.materialList)
			display([MT.materialList(i).name,':']);
			display(MT.materialList(i).des);
			display(' ');
		end
	else
		for i = 1:length(MT.materialList)
			if (strcmp(MT.materialList(i).name,name))
				display(['name:',MT.materialList(i).name]);
				display(['description:',MT.materialList(i).des]);
				display(['how to use:',MT.materialList(i).howtocall]);
				break;
			end
		end
	end
end

