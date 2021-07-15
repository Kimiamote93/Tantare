clc
clear all

%%


warning('off')

path(path,'C:\MyLake\Donnees_Brutes_20210519\New_Data\Basin4')

load PBasin4_1m.mat
load PBasin4_10m.mat
load Basin4_1m.mat
load Basin4_10m.mat
load FinalDate_1m
load FinalDate_10m



DD = cell2mat(PBasin4_1m (:,2:313));
[~,ii] = max(DD);
m=ii;
n=1:size(DD,2);
B =  cellstr(FinalDate_1m);

for i=1:312 
        tt(i,1) = B (ii(1,i),i);
end


DD2 = cell2mat(PBasin4_10m (:,2:313));



DD3 = (log (DD) - log (DD2)) / (9) ;

for i = 1:312
    x(i) = mean (DD3(ii-3:ii+3,i));
end

Date =  cellstr(Basin4_1m);

for i = 1:312
    x2(i) = mean (DD3(45:52,i));
end

for i = 1:312
    x4(i) = mean (DD3(:,i));
end

lat = 47.06707; % [arc-degrees] latitude
long =  -71.3667; % [arc-degrees] longitude
TZ = -4; % [hrs] offset from UTC, during standard time
rot = 0; % [arc-degrees] rotation clockwise from north


datetimes = Date ;
DST = true; % local time is daylight savings time
% calculate solar position
a = solarPosition(datetimes,lat,long,TZ,rot,DST);

for i = 1:312
    for j=1:96
       c (j,i)= a((i-1)*96+j+44,1);
    end
end

[val, idx] = min(c, [], 1);

for i=1:312
    zenithtime (1,i) = B(idx(i),i+1);
end

t = datetime(zenithtime);
v = datevec(t);
Var1 = datetime(v(:,1:3));
Var2 = duration(v(:,4:end));






for i = 1:312
     x3(i) = mean (DD3(idx(1,i)-4:idx(1,i)+4,i));
end

MA3 = movmean(x3,7) ;

startDate = datenum('07-11-20');                               % X axis                         
endDate = datenum('05-18-21');
xData = linspace(startDate,endDate,endDate - startDate +1);



r1 = min (DD2,[],'all') ;
r2 = min(DD,[],'all');
zx = min (r1 ,r2 ); 
par1 = cellfun(@(x) x-zx,PBasin4_1m,'un',0) ;
par2 = cellfun(@(x) x-zx,PBasin4_10m,'un',0) ;



CD = cell2mat(par1 (:,2:313));
[~,ij] = max(CD);
m2=ij;
n2=1:size(CD,2);
B2 =  cellstr(FinalDate_1m);

for i=1:312 
        tt2(i,1) = B2(ij(1,i),i);
end


CD2 = cell2mat(par2 (:,2:313));

CD3 = (log (CD) - log (CD2)) / (9) ;

for i = 1:312
    Q( i ) = mean (CD3(ij-4:ij+4,i));
end

Date =  cellstr(Basin4_1m);

 for i = 1:312
Q2(i) = mean (CD3(45:53,i));
end


for i = 1:312
     Q3(i) = mean (CD3(idx(1,i)-3:idx(1,i)+3,i));
end




figure (1)

plot (xData,x,'b','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')
box on
h_label = ylabel('Kd (m-1)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')



hold on
figure (2)

plot (xData,x2,'b','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')
box on
h_label = ylabel('Kd (m-1)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')


hold on

figure (3)
hold on
plot (xData,x3, 'Color', [.5 .5 .5],'LineWidth',1)
plot(xData,MA3,'r','LineWidth',2)
g = [0.3 0.4];
h = [0.8 0.7];
annotation('textarrow',g,h,'String','7-Day moving average ')

datetick('x','dd-mmm-yyyy','keepticks')
box on
h_label = ylabel('Kd (m-1)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
hold off



hold on

figure (4)

plot (xData,Q3,'b','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')
box on
h_label = ylabel('Kd (m-1)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold on
figure (5)
plot (xData,x4,'b','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')
box on
h_label = ylabel('Kd (m-1)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold on
 figure (6)
%  var3=cellstr(var1);
 plot (Var1,Var2,'b','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')
box on
h_label = ylabel('Zenith','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
hold off

