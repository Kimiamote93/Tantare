clc
clear all

%Basin3 

%% 4 m
path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniHOBO_4m_20880728');
[num , txt, num] = xlsread ('TAN_B_4m.csv');

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


T_4m_Basin3 = sum(result,1) ./ sum(result~=0,1);

%%
%7m

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniHOBO_10m_20880732');
[num , txt, num] = xlsread ('TAN_B_10m.csv');

for i=1:29563
    
DateA10{i,1} = num {i+2,2};

end

for i=1:29563
    
TemppA10{i,1} = num {i+2,3};

end

TempA10 = cell2mat (TemppA10);

splitcells = regexp(DateA10, '\s+','split');

for i=1:29563
    timeA10 {i,1} = splitcells {i,1}{1,1};
end
    
    i = 1;
    j = 1;
    
while i<=29562
     
    FTempA10{1,j} = find (strcmpi(timeA10,timeA10{i,1}));                              % Find all temperature measured in a day.
    s = find (strcmpi(timeA10,timeA10{i,1}),1,'last');                             
    i=1+s;
    j=j+1;
    
end


for i = 1 : 309
    for j = 1 : length (FTempA10{1,i})
        v = (FTempA10{1,i}(j,1));
        FTemperatureA10{1,i}{j,1} = TempA10(v,1);
        
    end
    
end


for i = 1:309
    for j = 1 : length (FTempA10{1,i})
       FinalTempA10 (j,i) =  FTemperatureA10{1,i}(j,1);  
    end       
end


f = ~cellfun(@isempty,FinalTempA10);
result2 = zeros(size(FinalTempA10));
result2(f) = cellfun(@(x)mean(x(:,1)),FinalTempA10(f));


T_10m_Basin3 = sum(result2,1) ./ sum(result2~=0,1);

%%

%14m

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniHOBO_14m_20880733');
[num , txt, num] = xlsread ('TAN_B_14m.csv');

for i=1:29563
    
DateA14{i,1} = num {i+2,2};

end

for i=1:29563
    
TemppA14{i,1} = num {i+2,3};

end

TempA14 = cell2mat (TemppA14);

splitcells = regexp(DateA14, '\s+','split');

for i=1:29563
    timeA14 {i,1} = splitcells {i,1}{1,1};
end
    
    i = 1;
    j = 1;
    
while i<=29562
     
    FTempA14{1,j} = find (strcmpi(timeA14,timeA14{i,1}));                              % Find all temperature measured in a day.
    s2 = find (strcmpi(timeA14,timeA14{i,1}),1,'last');                             
    i=1+s2;
    j=j+1;
    
end


for i = 1 : 309
    for j = 1 : length (FTempA14{1,i})
        v2 = (FTempA14{1,i}(j,1));
        FTemperatureA14{1,i}{j,1} = TempA14(v2,1);
        
    end
    
end


for i = 1:309
    for j = 1 : length (FTempA14{1,i})
       FinalTempA14 (j,i) =  FTemperatureA14{1,i}(j,1);  
    end       
end


f2 = ~cellfun(@isempty,FinalTempA14);
result3 = zeros(size(FinalTempA14));
result3(f2) = cellfun(@(x)mean(x(:,1)),FinalTempA14(f2));


T_14m_Basin3 = sum(result3,1) ./ sum(result3~=0,1);


%%


%16m

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniHOBO_16m_20880734');
[num , txt, num] = xlsread ('TAN_B_16m.csv');

for i=1:29563
    
DateA16{i,1} = num {i+2,2};

end

for i=1:29563
    
TemppA16{i,1} = num {i+2,3};

end

TempA16 = cell2mat (TemppA16);

splitcells = regexp(DateA16, '\s+','split');

for i=1:29563
    timeA16 {i,1} = splitcells {i,1}{1,1};
end
    
    i = 1;
    j = 1;
    
while i<=29562
     
    FTempA16{1,j} = find (strcmpi(timeA16,timeA16{i,1}));                              % Find all temperature measured in a day.
    s3 = find (strcmpi(timeA16,timeA16{i,1}),1,'last');                             
    i=1+s3;
    j=j+1;
    
end


for i = 1 : 309
    for j = 1 : length (FTempA16{1,i})
        v3 = (FTempA16{1,i}(j,1));
        FTemperatureA16{1,i}{j,1} = TempA16(v3,1);
        
    end
    
end


for i = 1:309
    for j = 1 : length (FTempA16{1,i})
       FinalTempA16 (j,i) =  FTemperatureA16{1,i}(j,1);  
    end       
end


f3 = ~cellfun(@isempty,FinalTempA16);
result4 = zeros(size(FinalTempA16));
result4(f3) = cellfun(@(x)mean(x(:,1)),FinalTempA16(f3));


T_16m_Basin3 = sum(result4,1) ./ sum(result4~=0,1);

%%


%19m

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniHOBO_19m_20880735');
[num , txt, num] = xlsread ('TAN_B_19m.csv');

for i=1:29563
    
DateA19{i,1} = num {i+2,2};

end

for i=1:29563
    
TemppA19{i,1} = num {i+2,3};

end

TempA19 = cell2mat (TemppA19);

splitcells = regexp(DateA19, '\s+','split');

for i=1:29563
    timeA19 {i,1} = splitcells {i,1}{1,1};
end
    
    i = 1;
    j = 1;
    
while i<=29562
     
    FTempA19{1,j} = find (strcmpi(timeA19,timeA19{i,1}));                              % Find all temperature measured in a day.
    s4 = find (strcmpi(timeA19,timeA19{i,1}),1,'last');                             
    i=1+s4;
    j=j+1;
    
end


for i = 1 : 309
    for j = 1 : length (FTempA19{1,i})
        v4 = (FTempA19{1,i}(j,1));
        FTemperatureA19{1,i}{j,1} = TempA19(v4,1);
        
    end
    
end


for i = 1:309
    for j = 1 : length (FTempA19{1,i})
       FinalTempA19 (j,i) =  FTemperatureA19{1,i}(j,1);  
    end       
end


f4 = ~cellfun(@isempty,FinalTempA19);
result5 = zeros(size(FinalTempA19));
result5(f4) = cellfun(@(x)mean(x(:,1)),FinalTempA19(f4));


T_19m_Basin3 = sum(result5,1) ./ sum(result5~=0,1);

%%

path(path,'C:\MyLake\Donnees_Brutes_20210519\Temperature\From_MiniDOT\Basin3');
load T_1m_Basin3.mat
load T_21m_Basin3.mat

path(path,'C:\MyLake\Donnees_Brutes_20210519\Temperature\From_MiniPAR\Basin3');
load T_1_5m_Basin3.mat
load T_7m_Basin3.mat


%the outlier in T_16m_Basin3

T_16m_Basin3 (1,1) =  (T_19m_Basin3 (1,1) + T_14m_Basin3 (1,1)) / 2 ;
T_16m_Basin3 (1,2) = (T_19m_Basin3 (1,2) + T_14m_Basin3 (1,2)) / 2 ;
T_16m_Basin3 (1,3) =  (T_19m_Basin3 (1,3) + T_14m_Basin3 (1,3)) / 2;

dc = hsv(24); 


startDate = datenum('07-15-20');                                                       
endDate = datenum('05-18-21');
xData = linspace(startDate,endDate,endDate - startDate + 1);
ax = gca;
ax.XTick = xData;

y1 = T_1m_Basin3 (309:end,:);
y2 = T_1_5m_Basin3 (6:end,:);
y3 = T_4m_Basin3 (:,1:308) ;
y4 = T_7m_Basin3 (6:end,:);
y5 = T_10m_Basin3 (:,1:308);
y6 = T_14m_Basin3 (:,1:308);
y7 = T_16m_Basin3 (:,1:308);
y8 = T_19m_Basin3 (:,1:308);
y9 = T_21m_Basin3 (309:end,:);

plot(xData,y1,'color',dc(1,:),'LineWidth',1.1)
datetick('x','dd-mmm-yyyy','keepticks');

hold on

plot(xData,y2,'color',dc(3,:),'LineWidth',1.1)


hold on

plot(xData,y3,'color',dc(6,:),'LineWidth',1.1)

hold on

plot(xData,y4,'color',dc(9,:),'LineWidth',1.1)

hold on

plot(xData,y5,'color',dc(12,:),'LineWidth',1.1)

hold on

plot(xData,y6,'color',dc(15,:),'LineWidth',1.1)

hold on

plot(xData,y7,'color',dc(18,:),'LineWidth',1.1)

hold on

plot(xData,y8,'color',dc(21,:),'LineWidth',1.1)

hold on

plot(xData,y9,'color',dc(24,:),'LineWidth',1.1)

%For finding out the ice cover period using the function 'icecover'

date1 = 309;                                                       
date2 = 616;
[sd,ed] =  icecover(T_21m_Basin3,T_1m_Basin3,date1,date2) ;
sdice = xData (1,sd);
edice = xData (1,ed);

box1= [sdice sdice edice edice];
boxy=[-5 30 30 -5];
patch(box1,boxy,[0.220,0.220,0.220] ,'EdgeColor','none', 'FaceAlpha',0.2)

xlim=get(gca,'xlim');
datenum(xlim);

lgd = legend('1 m','1.5 m','4 m','7 m','10 m','14 m','16 m','19 m','21 m','Ice cover period') ;
v = get(lgd,'title');
set(v,'string','Temperature at:');

xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
ylabel('Temperature (°C)','FontSize',12,'FontName','Times New Roman','FontWeight','bold')


title('Daily Temperature at Tantare basin3 ','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold off





