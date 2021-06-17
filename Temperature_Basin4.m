clc
clear all

%Basin4 

%% 4 m
path(path,'C:\MyLake\Donnees_Brutes_20210519\tantare_bassin4_20210519\HOBO_4M_20880725');
[num , txt, num] = xlsread ('TAN_A_4m.csv');

for i=1:29572
    
DateA4{i,1} = num {i+2,2};

end

for i=1:29572
    
TemppA4{i,1} = num {i+2,3};

end

TempA4 = cell2mat (TemppA4);

splitcells = regexp(DateA4, '\s+','split');

for i=1:29572
    timeA4 {i,1} = splitcells {i,1}{1,1};
end
    
    i = 1;
    j = 1;
    
while i<=29571
     
    FTempA4{1,j} = find (strcmpi(timeA4,timeA4{i,1}));                              % Find all temperature measured in a day.
    t = find (strcmpi(timeA4,timeA4{i,1}),1,'last');                             
    i=1+t;
    j=j+1;
    
end


for i = 1 : 309
    for j = 1 : length (FTempA4{1,i})
        u = (FTempA4{1,i}(j,1));
        FTemperatureA4{1,i}{j,1} = TempA4(u,1);
        
    end
    
end


for i = 1:309
    for j = 1 : length (FTempA4{1,i})
       FinalTempA4 (j,i) =  FTemperatureA4{1,i}(j,1);  
    end       
end


e = ~cellfun(@isempty,FinalTempA4);
result = zeros(size(FinalTempA4));
result(e) = cellfun(@(x)mean(x(:,1)),FinalTempA4(e));


T_4m_Basin4 = sum(result,1) ./ sum(result~=0,1);

%%
%7m

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantare_bassin4_20210519\HOBO_7m_20880726');
[num , txt, num] = xlsread ('TAN_A_7m.csv');

for i=1:29563
    
DateA7{i,1} = num {i+2,2};

end

for i=1:29563
    
TemppA7{i,1} = num {i+2,3};

end

TempA7 = cell2mat (TemppA7);

splitcells = regexp(DateA7, '\s+','split');

for i=1:29563
    timeA7 {i,1} = splitcells {i,1}{1,1};
end
    
    i = 1;
    j = 1;
    
while i<=29562
     
    FTempA7{1,j} = find (strcmpi(timeA7,timeA7{i,1}));                              % Find all temperature measured in a day.
    s = find (strcmpi(timeA7,timeA7{i,1}),1,'last');                             
    i=1+s;
    j=j+1;
    
end


for i = 1 : 309
    for j = 1 : length (FTempA7{1,i})
        v = (FTempA7{1,i}(j,1));
        FTemperatureA7{1,i}{j,1} = TempA7(v,1);
        
    end
    
end


for i = 1:309
    for j = 1 : length (FTempA7{1,i})
       FinalTempA7 (j,i) =  FTemperatureA7{1,i}(j,1);  
    end       
end


f = ~cellfun(@isempty,FinalTempA7);
result2 = zeros(size(FinalTempA7));
result2(f) = cellfun(@(x)mean(x(:,1)),FinalTempA7(f));


T_7m_Basin4 = sum(result2,1) ./ sum(result2~=0,1);

%%

path(path,'C:\MyLake\Donnees_Brutes_20210519\Temperature\From_MiniDOT\Basin4');
load T_2m_Basin4.mat
load T_14m_Basin4.mat

path(path,'C:\MyLake\Donnees_Brutes_20210519\Temperature\From_MiniPAR\Basin4');
load T_1m_Basin4.mat
load T_10m_Basin4.mat


%the outlier in T_1m_Basin4

T_1m_Basin4 (272,1) =  (T_1m_Basin4(273,1) + T_1m_Basin4(274,1))/2;
T_1m_Basin4 (278,1) =  (T_1m_Basin4(277,1) + T_1m_Basin4(279,1))/2;

dc = hsv(8); 


startDate = datenum('07-15-20');                                                       
endDate = datenum('05-18-21');
xData = linspace(startDate,endDate,endDate - startDate + 1);
ax = gca;
ax.XTick = xData;

y1 =  T_1m_Basin4 (6:end,:);
y2 = T_2m_Basin4 (309:end,:);
y3 = T_4m_Basin4 (:,1:308) ;
y4 = T_7m_Basin4 (:,1:308);
y5 = T_10m_Basin4 (6:end,:);
y6 = T_14m_Basin4 (309:end,:);


plot(xData,y1,'color',dc(1,:),'LineWidth',1.1)
datetick('x','dd-mmm-yyyy','keepticks')

hold on


plot(xData,y2,'color',dc(2,:),'LineWidth',1.1)


hold on


plot(xData,y3,'color',dc(4,:),'LineWidth',1.1)

hold on


plot(xData,y4,'color',dc(5,:),'LineWidth',1.1)

hold on


plot(xData,y5,'color',dc(6,:),'LineWidth',1.1)

hold on


plot(xData,y6,'color',dc(8,:),'LineWidth',1.1)


% hold on
% 
% y9 = FinalTemp (:,8);
% plot(xData,y9,'color',dc(10,:),'LineWidth',1.1)
% 
% hold on
% 
% y10 = FinalTemp (:,9);
% plot(xData,y10,'color',dc(11,:),'LineWidth',1.1)
% 
% hold on
% 
% y11 = T_TOP_1;
% plot(xData2,y11,'color',dc(12,:),'LineWidth',1.1)
% 
% hold on
% 
% y12 = FinalTemp (:,10) ;
% plot(xData,y12,'color',dc(13,:),'LineWidth',1.1)

lgd = legend('1 m','2 m','4 m','7 m','10 m','14 m') 
v = get(lgd,'title');
set(v,'string','Temperature at:');

xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
ylabel('Temperature (°C)','FontSize',12,'FontName','Times New Roman','FontWeight','bold')


title('Daily Temperature at Tantare bassin4 ','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold off

xlim=get(gca,'xlim');
datenum(xlim)




