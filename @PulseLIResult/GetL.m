function f = GetL(LI)
	f1 = LI.hOSC.Auto_Vertical_Tune('ch1');
	f2 = LI.hOSC.Auto_Vertical_Tune('ch2');
x = f1.T;                      
y = f1.V/max(f1.V);            
dt = (x(end)-x(1))/10000;      
figure(99);plot(x,y/max(y));       
yy = smooth(y,100);            
hold on;                       
plot(x,yy,'r');                
dy = (yy(3:end)-yy(1:end-2))/2/dt;      
dy = dy/max(abs(dy));          
plot(x(2:end-1),dy,'g');       
LL = (dy>0.5);                 
xx = x(2:end-1);               
ppx = xx(LL);                  
ppy = dy(LL);                  

tpx = [ppx(1)];
tpy = [ppy(1)];
pppx = [];
pppy = [];
if (length(ppx)>1)
	dppx = ppx(2:end)-ppx(1:end-1);
	i = 1;                         
	while (i <= length(dppx)) 
		if (dppx(i)<= 2*dt)
			tpx = [tpx, ppx(i+1)];
			tpy = [tpy, ppy(i+1)];
		else
			[m, ind] = max(tpy);
			pppx = [pppx,tpx(ind)];
			pppy = [pppy,m];
			tpx = [ppx(i+1)];
			tpy = [ppy(i+1)];
		end
		i = i + 1;
	end   
	[m, ind] = max(tpy);
	pppx = [pppx,tpx(ind)];
	pppy = [pppy,m];
else
	pppx = ppx;
	pppy = ppy;
end
plot(pppx,pppy,'ro');            


LL = (dy<-0.5);                 
npx = xx(LL);                  
npy = dy(LL);                  

tpx = [npx(1)];
tpy = [npy(1)];
nppx = [];
nppy = [];
if (length(npx)>1)
	dnpx = npx(2:end)-npx(1:end-1);
	i = 1;                         
	while (i <= length(dnpx)) 
		if (dnpx(i)<= 2*dt)
			tpx = [tpx, npx(i+1)];
			tpy = [tpy, npy(i+1)];
		else
			[m, ind] = min(tpy);
			nppx = [nppx,tpx(ind)];
			nppy = [nppy,m];
			tpx = [npx(i+1)];
			tpy = [npy(i+1)];
		end
		i = i + 1;
	end   
	[m, ind] = min(tpy);
	nppx = [nppx,tpx(ind)];
	nppy = [nppy,m];
else
	nppx = npx;
	nppy = npy;
end
plot(nppx,nppy,'ro');            

x1 = pppx(1:min(length(pppx),length(nppx)));
x2 = nppx(1:min(length(pppx),length(nppx)));
pw = sum(x2-x1)/length(x1);
display(['pulse width: ', num2str(pw)]);
hold off;

vx = f2.T;
vy = f2.V;
svy = smooth(vy,100);
iv = [];
figure(100);plot(vx,vy);
hold on;
for i = 1:length(x1)
xl = x1(i);
xh = x2(i);
LL = (vx<=xh-abs(xh-xl)*0.1 & vx>=xl+abs(xh-xl)*0.1);
x = vx(LL);
y = svy(LL);
dy = y(3:end)-y(1:end-2);
sdy = smooth(smooth(dy,200),100);
sdy = sdy/max(abs(sdy));
x = x(2:end-1)';
[mm ind] = max(abs(sdy));
display(ind);
LL = (vx<=xh & vx>=xl);
x = vx(LL);
y = svy(LL);
plot(x,y,'g');
dy = y(3:end)-y(1:end-2);
sdy = smooth(smooth(dy,200),100);
sdy = sdy/max(abs(sdy));
x = x(2:end-1)';
LL = (abs(sdy)<1e-2*mm);
display(mm);
xx = x(LL);
if isempty(xx)
	high = x(end);
else
	high = xx(end);
end
LL = (x < high);
xx = x(LL);
display(sum(LL));
sdy1 = sdy(LL);

%pstep = 100;
%p = length(xx)-pstep;
%if (p<=0) p = 1;end
%temp1 = sum(sdy1(p:end))/(length(xx)-p + 1);
%err = 0;
%while (p > 1 && err < 0.3)
%	p = p - pstep;
%	if (p<=0) p = 1;end
%	temp2 = sum(sdy1(p:end))/(length(xx)-p + 1);
%	err = abs(temp2-temp1)/abs(temp1);
%	display(abs(temp2-temp1));
%	if (abs(temp2-temp1) < 1e-4 ) 
%		display('yes');
%		err = 0; 
%	end
%	temp1 = temp2;
%	display(err);
%end

pstep = 100;
pe = length(xx);
ps = pe - pstep;
if (ps<1) ps = 1;end
temp1 = sum(sdy1(ps:pe))/(pe-ps + 1);
err = 0;
while (ps > 1 && err < 1)
	pe = ps;
	ps = ps - pstep;
	if (ps<1) ps = 1;end
	temp2 = sum(sdy1(ps:pe))/(pe-ps + 1);
	err = abs(temp2-temp1)/abs(temp1);
	if (abs(temp2-temp1) < 1e-4 ) err = 0; end
	display(err);
end

display(ps);
low = xx(ps);
LL = (vx<=high & vx>=low);
xx = vx(LL);
yy = vy(LL);
iv = [iv,trapz(xx,yy)/(xx(end)-xx(1))];
plot([low,low],[min(vy),max(vy)],'r');
plot([high,high],[min(vy),max(vy)],'r');
end

display(['power: ', num2str(sum(iv)/length(iv))]);
f = sum(iv)/length(iv);
hold off;




%	x = f1.T;                      
%	y = f1.V/max(f1.V);            
%	dt = (x(end)-x(1))/10000;      
%	figure(99);plot(x,y/max(y));       
%	yy = smooth(y,100);            
%	hold on;                       
%	plot(x,yy,'r');                
%	dy = (yy(3:end)-yy(1:end-2))/2/dt;      
%	dy = dy/max(abs(dy));          
%	plot(x(2:end-1),dy,'g');       
%	LL = (dy>0.5);                 
%	xx = x(2:end-1);               
%	ppx = xx(LL);                  
%	ppy = dy(LL);                  
%
%	tpx = [ppx(1)];
%	tpy = [ppy(1)];
%	pppx = [];
%	pppy = [];
%	if (length(ppx)>1)
%		dppx = ppx(2:end)-ppx(1:end-1);
%		i = 1;                         
%		while (i <= length(dppx)) 
%			if (dppx(i)<= 2*dt)
%				tpx = [tpx, ppx(i+1)];
%				tpy = [tpy, ppy(i+1)];
%			else
%				[m, ind] = max(tpy);
%				pppx = [pppx,tpx(ind)];
%				pppy = [pppy,m];
%				tpx = [ppx(i+1)];
%				tpy = [ppy(i+1)];
%			end
%			i = i + 1;
%		end   
%		[m, ind] = max(tpy);
%		pppx = [pppx,tpx(ind)];
%		pppy = [pppy,m];
%	else
%		pppx = ppx;
%		pppy = ppy;
%	end
%	plot(pppx,pppy,'ro');            
%
%
%	LL = (dy<-0.5);                 
%	npx = xx(LL);                  
%	npy = dy(LL);                  
%
%	tpx = [npx(1)];
%	tpy = [npy(1)];
%	nppx = [];
%	nppy = [];
%	if (length(npx)>1)
%		dnpx = npx(2:end)-npx(1:end-1);
%		i = 1;                         
%		while (i <= length(dnpx)) 
%			if (dnpx(i)<= 2*dt)
%				tpx = [tpx, npx(i+1)];
%				tpy = [tpy, npy(i+1)];
%			else
%				[m, ind] = min(tpy);
%				nppx = [nppx,tpx(ind)];
%				nppy = [nppy,m];
%				tpx = [npx(i+1)];
%				tpy = [npy(i+1)];
%			end
%			i = i + 1;
%		end   
%		[m, ind] = min(tpy);
%		nppx = [nppx,tpx(ind)];
%		nppy = [nppy,m];
%	else
%		nppx = npx;
%		nppy = npy;
%	end
%	plot(nppx,nppy,'ro');            
%
%	x1 = pppx(1:min(length(pppx),length(nppx)));
%	x2 = nppx(1:min(length(pppx),length(nppx)));
%	pw = sum(x2-x1)/length(x1);
%	display(['pulse width: ', num2str(pw)]);
%	hold off;
%	pause(0.1);
%
%	vx = f2.T;
%	vy = f2.V;
%	svy = smooth(smooth(vy,200),100);
%	iv = [];
%	figure(100);plot(vx,vy);
%	hold on;
%	for i = 1:length(x1)
%		xl = x1(i);
%		xh = x2(i);
%		LL = (vx<=xh-abs(xh-xl)*0.1 & vx>=xl+abs(xh-xl)*0.1);
%		x = vx(LL);
%		y = svy(LL);
%		dy = y(3:end)-y(1:end-2);
%		sdy = smooth(smooth(dy,200),100);
%		sdy = sdy/max(abs(sdy));
%		x = x(2:end-1)';
%		[mm ind] = max(abs(sdy));
%		LL = (x>x(ind) & abs(sdy)<1e-2*mm);
%		xx = x(LL);
%		if isempty(xx)
%			low = x(1); else
%			low = xx(1);
%		end
%		LL = (vx<=xh & vx>=xl);
%		x = vx(LL);
%		y = svy(LL);
%		plot(x,y,'g');
%		dy = y(3:end)-y(1:end-2);
%		sdy = smooth(smooth(dy,200),100);
%		sdy = sdy/max(abs(sdy));
%		x = x(2:end-1)';
%		LL = (abs(sdy)<1e-1*mm);
%		xx = x(LL);
%		if isempty(xx)
%			high = x(end);
%		else
%			high = xx(end);
%		end
%		LL = (vx<=high & vx>=low);
%		xx = vx(LL);
%		yy = vy(LL);
%		iv = [iv,trapz(xx,yy)/(xx(end)-xx(1))];
%		plot([low,low],[min(vy),max(vy)],'r');
%		plot([high,high],[min(vy),max(vy)],'r');
%	end
%	display(['power: ', num2str(sum(iv)/length(iv))]);
%	f = sum(iv)/length(iv);
%	pause(0.1);
%	hold off;
end
