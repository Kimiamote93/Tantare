clc
clear all

%%
%miniPAR_10m

%Reading all text files in the MiniPAR.

warning('off')

textFiles = dir ('C:\MyLake\Donnees_Brutes_20210519\tantare_bassin4_20210519\miniPAR_10m_435024\7530-435024\*.txt')   ; 
numfiles = length(textFiles);
mydata = cell(1, numfiles);

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantare_bassin4_20210519\miniPAR_10m_435024\7530-435024');


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
    x_10m{1,k}{:,1} = table2array(A(:,1)); 
    x_10m{1,k}{:,2} = datetime(x_10m{1,k}{:,1}, 'convertfrom','posixtime') - hours (4) ;
    x_10m{1,k}{:,3} = table2array(A(:,4));
    x_10m{1,k}{:,4} = table2array(A(:,3));
   
   end
   
end

delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')
  

for j = 1: length(x_10m{1, 1}{1, 2}) 
	Basin4_10m (j,1) =  x_10m{1,1}{1,2}(j,1) ; 
    Basin4_10m_2 (j,1) =  x_10m{1,1}{1,3}(j,1) ; 
    Basin4_10m_2 (j,2) =  x_10m{1,1}{1,4}(j,1) ; 
end
 

for k = 2:numfiles    
    for j = 1: length(x_10m{1, k}{1, 2}) 
         Basin4_10m ((length(x_10m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_10m{1,k}{1,2}(j,1) ;
         Basin4_10m_2 ((length(x_10m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_10m{1,k}{1,3}(j,1) ;
         Basin4_10m_2 ((length(x_10m{1, k-1}{1, 2} ))*(k-1)+j,2) =  x_10m{1,k}{1,4}(j,1) ;
    end
end 
      



    t = datetime(Basin4_10m);
    vp = datevec(Basin4_10m);
    Var_Basin4_1 = datetime(vp(:,1:3));
    Var_Basin4_2 = duration(vp(:,4:end));
    V_Basin4 = cellstr(Var_Basin4_1);
    
    i = 1;
    j = 1;
    
    
while i<=length (Basin4_10m)
     
    F_10m{1,j} = find (strcmpi(V_Basin4,V_Basin4{i,1}));                              % Find all temperature measured in a day.
    s = find (strcmpi(V_Basin4,V_Basin4{i,1}),1,'last');                             
    i=1+s;
    j=j+1;
    
end


for i = 1 : length (F_10m)
    for j = 1 : length (F_10m{1,i})
        vp = (F_10m{1,i}(j,1));
        Finalp_10m{1,i}{j,1} = Basin4_10m_2(vp,1);
        Date_10m{1,i}{j,1} = Basin4_10m (vp,1);
    end
end


for i = 1:length (F_10m)
    for j = 1 : length (F_10m{1,i})
       PBasin4_10m (j,i) =  Finalp_10m{1,i}(j,1);  
       FinalDate_10m (j,i)=  Date_10m{1,i}{j,1} ;
    end       
end


e = ~cellfun(@isempty,PBasin4_10m);
result = zeros(size(PBasin4_10m));
result(e) = cellfun(@(x)mean(x(:,1)),PBasin4_10m(e));


PAR_Basin4_10m = sum(result,1) ./ sum(result~=0,1);
    
   


for i = 1 : length (F_10m)
    for j = 1 : length (F_10m{1,i})
        vt = (F_10m{1,i}(j,1));
        Finalt_10m{1,i}{j,1} = Basin4_10m_2(vt,2);
    end
end


for i = 1:length (F_10m)
    for j = 1 : length (F_10m{1,i})
       TBasin4_10m (j,i) =  Finalt_10m{1,i}(j,1);  
    end       
end


e2 = ~cellfun(@isempty,TBasin4_10m);
result2 = zeros(size(TBasin4_10m));
result2(e2) = cellfun(@(x)mean(x(:,1)),TBasin4_10m(e));


Temp_Basin4_10m = sum(result2,1) ./ sum(result2~=0,1);


%%


%miniPAR_1m

%Reading all text files in the MiniPAR.


textFiles2 = dir ('C:\Users\Kimia\Desktop\7530-345582\*.txt')   ; 
numfiles2 = length(textFiles2);
mydata2 = cell(1, numfiles2);

path(path,'C:\Users\Kimia\Desktop\7530-345582')



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
    x_1m{1,k}{:,1} = table2array(A2(:,1)); 
    x_1m{1,k}{:,2} = datetime(x_1m{1,k}{:,1}, 'convertfrom','posixtime') - hours (4) ;
    x_1m{1,k}{:,3} = table2array(A2(:,4));
    x_1m{1,k}{:,4} = table2array(A2(:,3));
   
    
   end
  
end

delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')
  

for j = 1: length(x_1m{1, 1}{1, 2}) 
	Basin4_1m (j,1) =  x_1m{1,1}{1,2}(j,1) ; 
    Basin4_1m_2 (j,1) =  x_1m{1,1}{1,3}(j,1) ; 
    Basin4_1m_2 (j,2) =  x_1m{1,1}{1,4}(j,1) ;
    
end
 

for k = 2:numfiles2    
    for j = 1: length(x_1m{1, k}{1, 2}) 
         Basin4_1m ((length(x_1m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_1m{1,k}{1,2}(j,1) ;
         Basin4_1m_2 ((length(x_1m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_1m{1,k}{1,3}(j,1) ;
         Basin4_1m_2 ((length(x_1m{1, k-1}{1, 2} ))*(k-1)+j,2) =  x_1m{1,k}{1,4}(j,1) ;
    end
end 




    t2 = datetime(Basin4_1m);
    vp2 = datevec(Basin4_1m);
    Var_Basin4_3 = datetime(vp2(:,1:3));
    Var_Basin4_4 = duration(vp2(:,4:end));
    V2_Basin4 = cellstr(Var_Basin4_3);
    
    i = 1;
    j = 1;
    
    
while i<=length (Basin4_1m)
     
    F_1m{1,j} = find (strcmpi(V2_Basin4,V2_Basin4{i,1}));                              % Find all temperature measured in a day.
    s2 = find (strcmpi(V2_Basin4,V2_Basin4{i,1}),1,'last');                             
    i=1+s2;
    j=j+1;
    
end


for i = 1 : length (F_1m)
    for j = 1 : length (F_1m{1,i})
        vp2 = (F_1m{1,i}(j,1));
        Finalp_1m{1,i}{j,1} = Basin4_1m_2(vp2,1);
        Date_1m{1,i}{j,1} = Basin4_1m (vp2,1);
    end
end


for i = 1:length (F_1m)
    for j = 1 : length (F_1m{1,i})
       PBasin4_1m (j,i) =  Finalp_1m{1,i}(j,1);  
       FinalDate_1m (j,i) =  Date_1m{1,i}{j,1} ;
    end       
end


e3 = ~cellfun(@isempty,PBasin4_1m);
result3 = zeros(size(PBasin4_1m));
result3(e3) = cellfun(@(x)mean(x(:,1)),PBasin4_1m(e3));


PAR_Basin4_1m = sum(result3,1) ./ sum(result3~=0,1);
    
   


for i = 1 : length (F_1m)
    for j = 1 : length (F_1m{1,i})
        vt2 = (F_1m{1,i}(j,1));
        Finalt_1m{1,i}{j,1} = Basin4_1m_2(vt2,2);
    end
end


for i = 1:length (F_1m)
    for j = 1 : length (F_1m{1,i})
       TBasin4_1m (j,i) =  Finalt_1m{1,i}(j,1);  
    end       
end


e4 = ~cellfun(@isempty,TBasin4_1m);
result4 = zeros(size(TBasin4_1m));
result4(e4) = cellfun(@(x)mean(x(:,1)),TBasin4_1m(e4));


Temp_Basin4_1m = sum(result4,1) ./ sum(result4~=0,1);



%%

 
%Outlier
PAR_Basin4_10m(1,6) =  (PAR_Basin4_10m(1,5) + PAR_Basin4_10m(1,7))/2 ;


min1 = min(PAR_Basin4_1m);
min2 = min(PAR_Basin4_10m);
PAR_1m_Basin4_offset = PAR_Basin4_1m - min(min1,min2); 
PAR_10m_Basin4_offset = PAR_Basin4_10m - min(min1,min2);



figure(1)
hold on
startDate = datenum('07-10-20');                               % X axis                         
endDate = datenum('05-19-21');
xData = linspace(startDate,endDate,endDate - startDate +1);
% ax = gca;
% ax.XTick = xData;

y1 = PAR_1m_Basin4_offset;
y2 = PAR_10m_Basin4_offset;



plot(xData,y1,'r','LineWidth',2)



% ylim(1.1*[min(y1) max(y1)]);



datetick('x','dd-mmm-yyyy','keepticks')
ylim([-10 280]);
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
legend('PAR at 1m','PAR at 10m');

title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold off


figure(2)

h1 = subplot(2,1,1);

plot(xData,y1,'r','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')

% ylim(1.1*[min(y2) max(y2)]);
xlim([737973 738300]) ;
ylim([-10 280]);
%set(gca,'YTick',[5 7 9 11])
% set(ax,'xticklabel',[])


%datenum(xlim)
str = {'(a) PAR at 1m'};
text(738001,570,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
hold on

h2 = subplot(2,1,2);

plot(xData,y2,'b','LineWidth',2)
hold on

datetick('x','dd-mmm-yyyy','keepticks')
ylim([-1 6]);
%set(gca,'YTick',[0  2 4 6 8 10]);
xlim([737973 738300]) ;
%set(gca,'XTick',[737720 737820 737920 738020 738120 738220 738320]);

str = {'(b) PAR at 10m'};
text(738001,62,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

p1 = get(h1,'position');
p2 = get(h2,'position');
height = p1(2)+p1(4)-p2(2);
h3 = axes('position',[p2(1) p2(2) p2(3) height],'visible','off');
h_label = ylabel('Photosynthetically Active Radiation (PAR)(umol/(s m^2))','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');

%%


kd_Basin4 = (log (PAR_1m_Basin4_offset) - log (PAR_10m_Basin4_offset)) / (9) ; 
kd_Basin4 (1,5) = (kd_Basin4 (1,4)  + kd_Basin4 (1,6) )/2 ;

figure(3)
hold on
startDate = datenum('07-10-20');                               % X axis                         
endDate = datenum('05-19-21');
xData = linspace(startDate,endDate,endDate - startDate +1);
% ax = gca;
% ax.XTick = xData;

y3 = kd_Basin4;




plot(xData,y3,'b','LineWidth',2)



% ylim(1.1*[min(y1) max(y1)]);



datetick('x','dd-mmm-yyyy','keepticks')
ylim([0 0.7]);
% set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10]);
xlim([737973 738300]) ;
% ax.XTickMode = 'auto'
% ax.XAxis.LineWidth = 4;
box on
%set(gca,'XTick',[737679 738294]);
%datenum(xlim)


h_label = ylabel('Kd (m-1)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')


title('Tantare Basin 4','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

hold on

figure (10)


x22 = [1:96];

for i=1:96
    test (i,1) = Finalp_1m{1,50}{i,1};
    
end
plot(x22,test,'b','LineWidth',2)
grid on

        