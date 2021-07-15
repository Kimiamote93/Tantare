clc
clear all

%%
%miniPAR_7m

%Reading all text files in the MiniPAR.

warning('off')

textFiles = dir ('C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_7m_639659\7530-639659\*.txt')   ; 
numfiles = length(textFiles);
mydata = cell(1, numfiles);

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_7m_639659\7530-639659');


for k = 1:numfiles 
     
    fid = fopen(textFiles(k).name, 'rt') ;
    fgets(fid) ;                                              % Read/discard line.
    %fgetl(fid) ;                                              % Read/discard line.
    buffer = fread(fid, Inf) ;                                % Read rest of the file.
    fclose(fid);
    fid = fopen(textFiles(k).name, 'w')  ;                    % Open destination file.
    fwrite(fid, buffer) ;                                     % Save to file.
    fclose(fid) ;
    
    %Put a comma after PAR in order to be seperated
    R = regexp( fileread(textFiles(k).name), '\n', 'split');
    R{2} = sprintf('%s',"Time (sec),  Bat (Volts),   T (deg C),  PAR (umol/(s m^2)),  Ax (g), Ay (g), Az (g)");
    fid = fopen(textFiles(k).name, 'w');
    fprintf(fid, '%s\n', R{:});
    fclose(fid);
    
    
    A = readtable(textFiles(k).name,'Format','%f%f%f%f%f%f%f');   % Read the 4th column.
    B = table2array(A(:,4));                
    
   
   for j = 1: length (B)
    x_7m{1,k}{:,1} = table2array(A(:,1)); 
    x_7m{1,k}{:,2} = datetime(x_7m{1,k}{:,1}, 'convertfrom','posixtime') - hours (4);
    x_7m{1,k}{:,3} = table2array(A(:,4));
    x_7m{1,k}{:,4} = table2array(A(:,3));
   
   end
   
end

delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')
  

for j = 1: length(x_7m{1, 1}{1, 2}) 
	Basin3_7m (j,1) =  x_7m{1,1}{1,2}(j,1) ; 
    Basin3_7m_2 (j,1) =  x_7m{1,1}{1,3}(j,1) ; 
    Basin3_7m_2 (j,2) =  x_7m{1,1}{1,4}(j,1) ; 
end
 

for k = 2:numfiles    
    for j = 1: length(x_7m{1, k}{1, 2}) 
         Basin3_7m ((length(x_7m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_7m{1,k}{1,2}(j,1) ;
         Basin3_7m_2 ((length(x_7m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_7m{1,k}{1,3}(j,1) ;
         Basin3_7m_2 ((length(x_7m{1, k-1}{1, 2} ))*(k-1)+j,2) =  x_7m{1,k}{1,4}(j,1) ;
    end
end 
      
    t = datetime(Basin3_7m);
    vp = datevec(Basin3_7m);
    Var_Basin3_1 = datetime(vp(:,1:3));
    Var_Basin3_2 = duration(vp(:,4:end));
    V_Basin3 = cellstr(Var_Basin3_1);
    
    i = 1;
    j = 1;
    
    
while i<= length (Basin3_7m)
     
    F_7m{1,j} = find (strcmpi(V_Basin3,V_Basin3{i,1}));                              % Find all temperature measured in a day.
    s = find (strcmpi(V_Basin3,V_Basin3{i,1}),1,'last');                             
    i=1+s;
    j=j+1;
    
end


for i = 1 : length (F_7m)
    for j = 1 : length (F_7m{1,i})
        vp = (F_7m{1,i}(j,1));
        Finalp_7m{1,i}{j,1} = Basin3_7m_2(vp,1);
    end
end


for i = 1:length (F_7m)
    for j = 1 : length (F_7m{1,i})
       PBasin3_7m (j,i) =  Finalp_7m{1,i}(j,1);  
    end       
end


e = ~cellfun(@isempty,PBasin3_7m);
result = zeros(size(PBasin3_7m));
result(e) = cellfun(@(x)mean(x(:,1)),PBasin3_7m(e));


PAR_Basin3_7m = sum(result,1) ./ sum(result~=0,1);
    
   


for i = 1 : length (F_7m)
    for j = 1 : length (F_7m{1,i})
        vt = (F_7m{1,i}(j,1));
        Finalt_7m{1,i}{j,1} = Basin3_7m_2(vt,2);
    end
end


for i = 1:length (F_7m)
    for j = 1 : length (F_7m{1,i})
       TBasin3_7m (j,i) =  Finalt_7m{1,i}(j,1);  
    end       
end


e2 = ~cellfun(@isempty,TBasin3_7m);
result2 = zeros(size(TBasin3_7m));
result2(e2) = cellfun(@(x)mean(x(:,1)),TBasin3_7m(e));


Temp_Basin3_7m = sum(result2,1) ./ sum(result2~=0,1);

%%
%miniPAR_1.5m

%Reading all text files in the MiniPAR.


textFiles2 = dir ('C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_1.5m_339428\7530-339428\*.txt')   ; 
numfiles2 = length(textFiles2);
mydata2 = cell(1, numfiles2);

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_1.5m_339428\7530-339428')



for k = 1:numfiles2 
     
    fid2 = fopen(textFiles2(k).name, 'rt') ;
    fgets(fid2) ;                                              % Read/discard line.
    %fgetl(fid) ;                                              % Read/discard line.
    buffer2 = fread(fid2, Inf) ;                                % Read rest of the file.
    fclose(fid2);
    fid2 = fopen(textFiles2(k).name, 'w')  ;                    % Open destination file.
    fwrite(fid2, buffer2) ;                                     % Save to file.
    fclose(fid2) ;
    
    %Put a comma after PAR in order to be seperated
    G = regexp( fileread(textFiles2(k).name), '\n', 'split');
    G{2} = sprintf('%s',"Time (sec),  Bat (Volts),   T (deg C),  PAR (umol/(s m^2)),  Ax (g), Ay (g), Az (g)");
    fid2 = fopen(textFiles2(k).name, 'w');
    fprintf(fid2, '%s\n', G{:});
    fclose(fid2);
    
    
    A2 = readtable(textFiles2(k).name,'Format','%f%f%f%f%f%f%f');   % Read the 4th column.
    B2 = table2array(A2(:,4));                
    
   
   for j = 1: length (B2)
    x_1_5m{1,k}{:,1} = table2array(A2(:,1)); 
    x_1_5m{1,k}{:,2} = datetime(x_1_5m{1,k}{:,1}, 'convertfrom','posixtime') - hours (4) ;
    x_1_5m{1,k}{:,3} = table2array(A2(:,4));
    x_1_5m{1,k}{:,4} = table2array(A2(:,3));
   
   end
   
end

delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')
  

for j = 1: length(x_1_5m{1, 1}{1, 2}) 
	Basin3_1_5m (j,1) =  x_1_5m{1,1}{1,2}(j,1) ; 
    Basin3_1_5m_2 (j,1) =  x_1_5m{1,1}{1,3}(j,1) ; 
    Basin3_1_5m_2 (j,2) =  x_1_5m{1,1}{1,4}(j,1) ; 
end
 

for k = 2:numfiles2    
    for j = 1: length(x_1_5m{1, k}{1, 2}) 
         Basin3_1_5m ((length(x_1_5m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_1_5m{1,k}{1,2}(j,1) ;
         Basin3_1_5m_2 ((length(x_1_5m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_1_5m{1,k}{1,3}(j,1) ;
         Basin3_1_5m_2 ((length(x_1_5m{1, k-1}{1, 2} ))*(k-1)+j,2) =  x_1_5m{1,k}{1,4}(j,1) ;
    end
end 
      
    t2 = datetime(Basin3_1_5m);
    vp2 = datevec(Basin3_1_5m);
    Var_Basin3_3 = datetime(vp2(:,1:3));
    Var_Basin3_4 = duration(vp2(:,4:end));
    V2_Basin3 = cellstr(Var_Basin3_3);
    
    i = 1;
    j = 1;
    
    
while i<= length (Basin3_1_5m)
     
    F_1_5m{1,j} = find (strcmpi(V2_Basin3,V2_Basin3{i,1}));                              % Find all temperature measured in a day.
    s2 = find (strcmpi(V2_Basin3,V2_Basin3{i,1}),1,'last');                             
    i=1+s2;
    j=j+1;
    
end


for i = 1 : length (F_1_5m)
    for j = 1 : length (F_1_5m{1,i})
        vp2 = (F_1_5m{1,i}(j,1));
        Finalp_1_5m{1,i}{j,1} = Basin3_1_5m_2(vp2,1);
    end
end


for i = 1:length (F_1_5m)
    for j = 1 : length (F_1_5m{1,i})
       PBasin3_1_5m (j,i) =  Finalp_1_5m{1,i}(j,1);  
    end       
end


e3 = ~cellfun(@isempty,PBasin3_1_5m);
result3 = zeros(size(PBasin3_1_5m));
result3(e3) = cellfun(@(x)mean(x(:,1)),PBasin3_1_5m(e3));


PAR_Basin3_1_5m = sum(result3,1) ./ sum(result3~=0,1);
    
   


for i = 1 : length (F_1_5m)
    for j = 1 : length (F_1_5m{1,i})
        vt2 = (F_1_5m{1,i}(j,1));
        Finalt_1_5m{1,i}{j,1} = Basin3_1_5m_2(vt2,2);
    end
end


for i = 1:length (F_1_5m)
    for j = 1 : length (F_1_5m{1,i})
       TBasin3_1_5m (j,i) =  Finalt_1_5m{1,i}(j,1);  
    end       
end


e4 = ~cellfun(@isempty,TBasin3_1_5m);
result4 = zeros(size(TBasin3_1_5m));
result4(e4) = cellfun(@(x)mean(x(:,1)),TBasin3_1_5m(e4));


Temp_Basin3_1_5m = sum(result4,1) ./ sum(result4~=0,1);



%%

min1 = min(PAR_Basin3_1_5m);
min2 = min(PAR_Basin3_7m);
PAR_1_5m_Basin3_offset = PAR_Basin3_1_5m - min(min1,min2); 
PAR_7m_Basin3_offset = PAR_Basin3_7m - min(min1,min2);
        



figure(1)
hold on
startDate = datenum('07-10-20');                               % X axis                         
endDate = datenum('05-19-21');
xData = linspace(startDate,endDate,endDate - startDate +1);
% ax = gca;
% ax.XTick = xData;

y1 = PAR_1_5m_Basin3_offset;
y2 = PAR_7m_Basin3_offset;



plot(xData,y1,'r','LineWidth',2)



% ylim(1.1*[min(y1) max(y1)]);



datetick('x','dd-mmm-yyyy','keepticks')
ylim([-10 650]);
% set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10]);
xlim([737973 738300]) ;
% ax.XTickMode = 'auto'
% ax.XAxis.LineWidth = 4;
box on
%set(gca,'XTick',[737679 738294]);
%datenum(xlim)


plot(xData,y2,'b','LineWidth',2)
h_label = ylabel('Photosynthetically Active Radiation (PAR)(umol/(s m^2))','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
legend('PAR at 1.5m','PAR at 7m');

title('Tantare Basin 3','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold off


figure(2)

h1 = subplot(2,1,1);

plot(xData,y1,'r','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')

% ylim(1.1*[min(y2) max(y2)]);
xlim([737973 738300]) ;
ylim([260 650]);
%set(gca,'YTick',[5 7 9 11])
% set(ax,'xticklabel',[])


%datenum(xlim)
str = {'(a) PAR at 1.5m'};
text(738001,570,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
title('Tantare Basin 3','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
hold on

h2 = subplot(2,1,2);

plot(xData,y2,'b','LineWidth',2)
hold on

datetick('x','dd-mmm-yyyy','keepticks')
ylim([-10 80]);
%set(gca,'YTick',[0  2 4 6 8 10]);
xlim([737973 738300]) ;
%set(gca,'XTick',[737720 737820 737920 738020 738120 738220 738320]);

str = {'(b) PAR at 7m'};
text(738001,62,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

p1 = get(h1,'position');
p2 = get(h2,'position');
height = p1(2)+p1(4)-p2(2);
h3 = axes('position',[p2(1) p2(2) p2(3) height],'visible','off');
h_label = ylabel('Photosynthetically Active Radiation (PAR)(umol/(s m^2))','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');

%%
kd_Basin3 = (log (PAR_1_5m_Basin3_offset) - log (PAR_7m_Basin3_offset)) / (5.5) ; 
kd_Basin3 (1,157) = (kd_Basin3 (1,155)  + kd_Basin3 (1,156) )/2 ;

figure(3)
hold on
startDate = datenum('07-10-20');                               % X axis                         
endDate = datenum('05-19-21');
xData = linspace(startDate,endDate,endDate - startDate +1);
% ax = gca;
% ax.XTick = xData;

y3 = kd_Basin3;




plot(xData,y3,'b','LineWidth',2)



% ylim(1.1*[min(y1) max(y1)]);



datetick('x','dd-mmm-yyyy','keepticks')
ylim([0.2 2]);
% set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10]);
xlim([737973 738300]) ;
% ax.XTickMode = 'auto'
% ax.XAxis.LineWidth = 4;
box on
%set(gca,'XTick',[737679 738294]);
%datenum(xlim)


h_label = ylabel('Kd (m-1)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')


title('Tantare Basin 3','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold off


    
        