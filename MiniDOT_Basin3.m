clc
clear all

%%tantare_bassin3

%miniDOT_21m

%Reading all text files in the MiniDOT.

warning('off')

textFiles = dir ('C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniDOT_21m_147565\7450-147565\*.txt')   ; 
numfiles = length(textFiles);
mydata = cell(1, numfiles);

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniDOT_21m_147565\7450-147565')

for k = 1:numfiles 
     
    fid = fopen(textFiles(k).name, 'rt') ;
    %fgetl(fid) ;                                              % Read/discard line.
    fgetl(fid) ;                                              % Read/discard line.
    buffer = fread(fid, Inf) ;                                % Read rest of the file.
    fclose(fid) ;
    fid = fopen(textFiles(k).name, 'w')  ;                    % Open destination file.
    fwrite(fid, buffer) ;                                     % Save to file.
    fclose(fid) ;
 
    A = readtable(textFiles(k).name,'Format','%f%f%f%f%f');   % Read the 4th column.
    B = table2array(A(:,4));                
    O_BOTTOM_1(k,1) = mean (B);                                %Average of oxygen for each day.
    
    B2 = table2array(A(:,3));
    T_BOTTOM_1(k,1) = mean (B2); 
    
end

date1 = '09-11-19';
date2 = '05-18-21' ; 
data1 = O_BOTTOM_1 ;
data2 = T_BOTTOM_1 ;
[O_21m_Basin3] =  missingdata(textFiles,date1,date2,data1) ;
[T_21m_Basin3] =  missingdata(textFiles,date1,date2,data2) ;


delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')



%miniDOT_1m

%Reading all text files in the MiniDOT

textFiles2 = dir ('C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniDOT_1m_108904\7450-108904\*.txt')   ; 
numfiles2 = length(textFiles2);
mydata2 = cell(1, numfiles2);

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniDOT_1m_108904\7450-108904')

for k = 1:numfiles2 
     
    fid = fopen(textFiles2(k).name, 'rt') ;
    %fgetl(fid) ;                                              % Read/discard line.
    fgetl(fid) ;                                              % Read/discard line.
    buffer = fread(fid, Inf) ;                                % Read rest of the file.
    fclose(fid);
    fid = fopen(textFiles2(k).name, 'w')  ;                    % Open destination file.
    fwrite(fid, buffer) ;                                     % Save to file.
    fclose(fid) ;
 
    C = readtable(textFiles2(k).name,'Format','%f%f%f%f%f');   % Read the 4th column.
    D = table2array(C(:,4));
    O_TOP_1(k,1) = mean (D);                                   %Average of oxygen for each day.
    
    D2 = table2array(C(:,3));
    T_TOP_1(k,1) = mean (D2); 
    
end

date1 = '09-11-19';
date2 = '05-18-21' ; 
data1 = O_TOP_1 ;
data2 = T_TOP_1 ;
[O_1m_Basin3] =  missingdata(textFiles2,date1,date2,data1) ;
[T_1m_Basin3] =  missingdata(textFiles2,date1,date2,data2) ;



delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')

% Making figures seperately 

% figure(1)
% 
% h1 = subplot(2,1,1);
% 
% startDate = datenum('09-11-19');                               % X axis                         
% endDate = datenum('05-18-21');
% xData = linspace(startDate,endDate,612);
% ax = gca;
% ax.XTick = xData;

% 
% y1 = O_TOP_1;
% plot(xData,y1,'r','LineWidth',2)
% hold on
% 
% 
% datetick('x','dd-mmm-yyyy','keepticks')
% ylim([4 12])
% set(gca,'YTick',[5 7 9 11])
% 
% xlim([737670 738320]) ;
% set(gca,'XTick',[737720 737820 737920 738020 738120 738220 738320]);
% 
% datenum(xlim)
% str = {'(a) DO at 2m'};
% text(737682,11,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
% 
% h2 = subplot(2,1,2);
% 
% y2 = O_BOTTOM_1;
% 
% plot(xData,y2,'b','LineWidth',2)
% hold on
% 
% datetick('x','dd-mmm-yyyy','keepticks')
% ylim([-2 12]);
% set(gca,'YTick',[0  2 4 6 8 10]);
% xlim([737670 738320]) ;
% set(gca,'XTick',[737720 737820 737920 738020 738120 738220 738320]);
% 
% str = {'(b) DO at 14m'};
% text(737682,10.8,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
% xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
% 
% p1 = get(h1,'position');
% p2 = get(h2,'position');
% height = p1(2)+p1(4)-p2(2);
% h3 = axes('position',[p2(1) p2(2) p2(3) height],'visible','off');
% h_label = ylabel('Oxygen Concentration at Tantare bassin3(mg/l)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
% 

figure(2)
hold on
startDate = datenum('09-11-19');                               % X axis                         
endDate = datenum('05-18-21');
xData = linspace(startDate,endDate,endDate - startDate +1);
% ax = gca;
% ax.XTick = xData;

y1 = O_1m_Basin3;
y2 = O_21m_Basin3;

plot(xData,y1,'r','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')
ylim([-0.5 12.5]);
set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10 11 12]);
xlim([737640 738330]) ;
ax.XTickMode = 'auto'
ax.XAxis.LineWidth = 4;
box on
%set(gca,'XTick',[737679 738294]);
%datenum(xlim)


plot(xData,y2,'b','LineWidth',2)
legend('DO at 1m','DO at 21m')
h_label = ylabel('Oxygen Concentration at Tantare basin3(mg/l)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
hold off

%%



