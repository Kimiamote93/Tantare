clc
clear all

%%tantare_bassin3

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
    PAR_BOTTOM_1(k,1) = mean (B);                                %Average of PAR for each day.
    
    B2 = table2array(A(:,3));
    T_BOTTOM_1(k,1) = mean (B2); 
    
end


date1 = '07-10-20';
date2 = '05-18-21' ; 
data1 = PAR_BOTTOM_1 ;
data2 = T_BOTTOM_1 ;
[PAR_7m_Basin3] =  missingdata(textFiles,date1,date2,data1) ;
[T_7m_Basin3] =  missingdata(textFiles,date1,date2,data2) ;


%miniPAR_1.5m

%Reading all text files in the MiniPAR.

textFiles2 = dir ('C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_1.5m_339428\7530-339428\*.txt')   ; 
numfiles2 = length(textFiles2);
mydata2 = cell(1, numfiles2);

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_1.5m_339428\7530-339428')

for k = 1:numfiles2
     
    fid = fopen(textFiles2(k).name, 'rt') ;
    fgets(fid) ;                                              % Read/discard line.
    %fgetl(fid) ;                                              % Read/discard line.
    buffer = fread(fid, Inf) ;                                % Read rest of the file.
    fclose(fid);
    fid = fopen(textFiles2(k).name, 'w')  ;                    % Open destination file.
    fwrite(fid, buffer) ;                                     % Save to file.
    fclose(fid) ;
    
    %Put a comma after PAR in order to be seperated
    G = regexp( fileread(textFiles2(k).name), '\n', 'split');
    G{2} = sprintf('%s',"Time (sec),  Bat (Volts),   T (deg C),  PAR (umol/(s m^2)),  Ax (g), Ay (g), Az (g)");
    fid = fopen(textFiles2(k).name, 'w');
    fprintf(fid, '%s\n', G{:});
    fclose(fid);
    
    
    C = readtable(textFiles2(k).name,'Format','%f%f%f%f%f%f%f');   % Read the 4th column.
    D = table2array(C(:,4));                
    PAR_TOP_1(k,1) = mean (D);                                %Average of PAR for each day.
    
    D2 = table2array(C(:,3));
    T_TOP_1(k,1) = mean (D2); 
    
end

%For missing data

data3 = PAR_TOP_1 ;
data4 = T_TOP_1 ;
[PAR_1_5m_Basin3] =  missingdata(textFiles2,date1,date2,data3) ;
[T_1_5m_Basin3] =  missingdata(textFiles2,date1,date2,data4) ;

%the outlier in PAR Bottom

% PAR_BOTTOM_1 (5,1) =  (PAR_BOTTOM_1(4,1)+PAR_BOTTOM_1(6,1))/2;
% PAR_BOTTOM_1 (284,1) =  (PAR_BOTTOM_1(283,1)+PAR_BOTTOM_1(285,1))/2;

delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')


figure(1)
hold on
startDate = datenum('07-10-20');                               % X axis                         
endDate = datenum('05-18-21');
xData = linspace(startDate,endDate,endDate - startDate +1);
% ax = gca;
% ax.XTick = xData;

y1 = PAR_1_5m_Basin3;
y2 = PAR_7m_Basin3;



plot(xData,y1,'r','LineWidth',2)



ylim(1.1*[min(y1) max(y1)]);



datetick('x','dd-mmm-yyyy','keepticks')
ylim([-320 360]);
% set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10]);
xlim([737973 738300]) ;
% ax.XTickMode = 'auto'
% ax.XAxis.LineWidth = 4;
box on
%set(gca,'XTick',[737679 738294]);
%datenum(xlim)


plot(xData,y2,'b','LineWidth',2)
h_label = ylabel('Photosynthetically Active Radiation (PAR) at Tantare basin3(umol/(s m^2))','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
legend('PAR at 1.5m','PAR at 7m');

hold off


%Making figures seperately 

figure(2)

h1 = subplot(2,1,1);

plot(xData,y1,'r','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')


xlim([737973 738300]) ;
ylim([-20 360]);
%set(gca,'YTick',[5 7 9 11])
% set(ax,'xticklabel',[])


%datenum(xlim)
str = {'(a) PAR at 1.5m'};
text(738001,300,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')

hold on

h2 = subplot(2,1,2);

plot(xData,y2,'b','LineWidth',2)
hold on

datetick('x','dd-mmm-yyyy','keepticks')
ylim([-290 -210]);
%set(gca,'YTick',[0  2 4 6 8 10]);
xlim([737973 738300]) ;
%set(gca,'XTick',[737720 737820 737920 738020 738120 738220 738320]);

str = {'(b) PAR at 7m'};
text(738001,-220,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

p1 = get(h1,'position');
p2 = get(h2,'position');
height = p1(2)+p1(4)-p2(2);
h3 = axes('position',[p2(1) p2(2) p2(3) height],'visible','off');
h_label = ylabel('Photosynthetically Active Radiation (PAR) at Tantare basin3(umol/(s m^2))','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');

%Showing different seasons

figure(3)
hold on
% ax = gca;
% ax.XTick = xData;


plot(xData,y1,'r','LineWidth',2)



ylim(1.1*[min(y1) max(y1)]);



datetick('x','dd-mmm-yyyy','keepticks')
ylim([-320 360]);
% set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10]);
xlim([737973 738300]) ;
% ax.XTickMode = 'auto'
% ax.XAxis.LineWidth = 4;
box on
%set(gca,'XTick',[737679 738294]);
%datenum(xlim)


plot(xData,y2,'b','LineWidth',2)
h_label = ylabel('Photosynthetically Active Radiation (PAR) at Tantare basin3(umol/(s m^2))','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')


box1= [737973 737973 738064 738064];
box2=[738065  738065 738156 738156];
box3=[738157 738157 738246 738246];
box4=[738247 738247 738300 738300];

boxy=[-1 1 1 -1]*max(y1)*1.2;



patch(box1,boxy,[1 0 0],'FaceAlpha',0.2)
patch(box2,boxy,[0 0 1],'FaceAlpha',0.2)
patch(box3,boxy,[0 1 0],'FaceAlpha',0.2)
patch(box4,boxy,[1 1 0],'FaceAlpha',0.2)

legend('PAR at 1.5m','PAR at 7m');


%Making figures seperately 

figure(4)

h1 = subplot(2,1,1);

plot(xData,y1,'r','LineWidth',2)
datetick('x','dd-mmm-yyyy','keepticks')


xlim([737973 738300]) ;
ylim([-20 360]);
%set(gca,'YTick',[5 7 9 11])
% set(ax,'xticklabel',[])


%datenum(xlim)
str = {'(a) PAR at 1.5m'};
text(738001,300,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')


box1= [737973 737973 738064 738064];
box2=[738065  738065 738156 738156];
box3=[738157 738157 738246 738246];
box4=[738247 738247 738300 738300];

boxy=[-1 1 1 -1]*max(y1)*1.2;



patch(box1,boxy,[1 0 0],'FaceAlpha',0.2)
patch(box2,boxy,[0 0 1],'FaceAlpha',0.2)
patch(box3,boxy,[0 1 0],'FaceAlpha',0.2)
patch(box4,boxy,[1 1 0],'FaceAlpha',0.2)

hold on

h2 = subplot(2,1,2);

plot(xData,y2,'b','LineWidth',2)
hold on

datetick('x','dd-mmm-yyyy','keepticks')
ylim([-290 -210]);
%set(gca,'YTick',[0  2 4 6 8 10]);
xlim([737973 738300]) ;
%set(gca,'XTick',[737720 737820 737920 738020 738120 738220 738320]);

 
box1= [737973 737973 738064 738064];
box2=[738065  738065 738156 738156];
box3=[738157 738157 738246 738246];
box4=[738247 738247 738300 738300];

boxy=[-1 1 1 -1]*max(y2)*1.6;



patch(box1,boxy,[1 0 0],'FaceAlpha',0.2)
patch(box2,boxy,[0 0 1],'FaceAlpha',0.2)
patch(box3,boxy,[0 1 0],'FaceAlpha',0.2)
patch(box4,boxy,[1 1 0],'FaceAlpha',0.2)



str = {'(b) PAR at 7m'};
text(738001,-220,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')

p1 = get(h1,'position');
p2 = get(h2,'position');
height = p1(2)+p1(4)-p2(2);
h3 = axes('position',[p2(1) p2(2) p2(3) height],'visible','off');
h_label = ylabel('Photosynthetically Active Radiation (PAR) at Tantare basin3(umol/(s m^2))','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');


%%

