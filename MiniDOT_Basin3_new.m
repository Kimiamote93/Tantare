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
    
   
   for j = 1: length (B)
    x_21m{1,k}{:,1} = table2array(A(:,1)); 
    x_21m{1,k}{:,2} = datetime(x_21m{1,k}{:,1}, 'convertfrom','posixtime') - hours (4);
    x_21m{1,k}{:,3} = table2array(A(:,4));
    x_21m{1,k}{:,4} = table2array(A(:,3));
   
   end
   
end

delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')


for j = 1: length(x_21m{1, 1}{1, 2}) 
	Basin3_21m (j,1) =  x_21m{1,1}{1,2}(j,1) ; 
    Basin3_21m_2 (j,1) =  x_21m{1,1}{1,3}(j,1) ; 
    Basin3_21m_2 (j,2) =  x_21m{1,1}{1,4}(j,1) ; 
end
 


for k = 2 : size (x_21m,2)  
    for j = 1: length(x_21m{1, k}{1, 2}) 
         Basin3_21m ((length(x_21m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_21m{1,k}{1,2}(j,1) ;
         Basin3_21m_2 ((length(x_21m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_21m{1,k}{1,3}(j,1) ;
         Basin3_21m_2 ((length(x_21m{1, k-1}{1, 2} ))*(k-1)+j,2) =  x_21m{1,k}{1,4}(j,1) ;
    end
end 
      

    t = datetime(Basin3_21m);
    vp = datevec(Basin3_21m);
    Var_Basin3_1 = datetime(vp(:,1:3));
    Var_Basin3_2 = duration(vp(:,4:end));
    V_Basin3 = cellstr(Var_Basin3_1);
    
    i = 1;
    j = 1;
    
  
    
while i<=length (Basin3_21m)
     
    F_21m{1,j} = find (strcmpi(V_Basin3,V_Basin3{i,1}));                              % Find all temperature measured in a day.
    s = find (strcmpi(V_Basin3,V_Basin3{i,1}),1,'last');                             
    i=1+s;
    j=j+1;
    
end


for i = 1 : length (F_21m)
    for j = 1 : length (F_21m{1,i})
        vp = (F_21m{1,i}(j,1));
        FinalO_21m{1,i}{j,1} = Basin3_21m_2(vp,1);
    end
end


for i = 1:length (F_21m)
    for j = 1 : length (F_21m{1,i})
       OBasin3_21m (j,i) =  FinalO_21m{1,i}(j,1);  
    end       
end


e = ~cellfun(@isempty,OBasin3_21m);
result = zeros(size(OBasin3_21m));
result(e) = cellfun(@(x)mean(x(:,1)),OBasin3_21m(e));


O_Basin3_21m = sum(result,1) ./ sum(result~=0,1);
    
   


for i = 1 : length (F_21m)
    for j = 1 : length (F_21m{1,i})
        vt = (F_21m{1,i}(j,1));
        Finalt_21m{1,i}{j,1} = Basin3_21m_2(vt,2);
    end
end


for i = 1:length (F_21m)
    for j = 1 : length (F_21m{1,i})
       TBasin3_21m (j,i) =  Finalt_21m{1,i}(j,1);  
    end       
end


e2 = ~cellfun(@isempty,TBasin3_21m);
result2 = zeros(size(TBasin3_21m));
result2(e2) = cellfun(@(x)mean(x(:,1)),TBasin3_21m(e));


Temp_Basin3_21m = sum(result2,1) ./ sum(result2~=0,1);

%%
% 
% %miniDOT_1m
% 
% %Reading all text files in the MiniDOT
% 
% textFiles2 = dir ('C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniDOT_1m_108904\7450-108904\*.txt')   ; 
% numfiles2 = length(textFiles2);
% mydata2 = cell(1, numfiles2);
% 
% path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniDOT_1m_108904\7450-108904')
% 
% 
% for k = 1:numfiles2 
%      
%     fid = fopen(textFiles2(k).name, 'rt') ;
%     %fgetl(fid) ;                                              % Read/discard line.
%     fgetl(fid) ;                                              % Read/discard line.
%     buffer = fread(fid, Inf) ;                                % Read rest of the file.
%     fclose(fid);
%     fid = fopen(textFiles2(k).name, 'w')  ;                    % Open destination file.
%     fwrite(fid, buffer) ;                                     % Save to file.
%     fclose(fid) ;
%     
%     
%     A2 = readtable(textFiles2(k).name,'Format','%f%f%f%f%f%f%f');   % Read the 4th column.
%     B2 = table2array(A2(:,4));                
%     
%    
%    for j = 1: length (B2)
%     x_1m{1,k}{:,1} = table2array(A2(:,1)); 
%     x_1m{1,k}{:,2} = datetime(x_1m{1,k}{:,1}, 'convertfrom','posixtime') - hours (4) ;
%     x_1m{1,k}{:,3} = table2array(A2(:,4));
%     x_1m{1,k}{:,4} = table2array(A2(:,3));
%    
%    end
%    
% end
% 
% delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')
%   
% 
% for j = 1: length(x_1m{1, 1}{1, 2}) 
% 	Basin3_1m (j,1) =  x_1m{1,1}{1,2}(j,1) ; 
%     Basin3_1m_2 (j,1) =  x_1m{1,1}{1,3}(j,1) ; 
%     Basin3_1m_2 (j,2) =  x_1m{1,1}{1,4}(j,1) ; 
% end
%  
% 
% for k = 2:numfiles2    
%     for j = 1: length(x_1m{1, k}{1, 2}) 
%          Basin3_1m ((length(x_1m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_1m{1,k}{1,2}(j,1) ;
%          Basin3_1m_2 ((length(x_1m{1, k-1}{1, 2} ))*(k-1)+j,1) =  x_1m{1,k}{1,3}(j,1) ;
%          Basin3_1m_2 ((length(x_1m{1, k-1}{1, 2} ))*(k-1)+j,2) =  x_1m{1,k}{1,4}(j,1) ;
%     end
% end 
%       
%     t2 = datetime(Basin3_1m);
%     vp2 = datevec(Basin3_1m);
%     Var_Basin3_3 = datetime(vp2(:,1:3));
%     Var_Basin3_4 = duration(vp2(:,4:end));
%     V2_Basin3 = cellstr(Var_Basin3_3);
%     
%     i = 1;
%     j = 1;
%     
%     
% while i<=length (Basin3_1m)
%      
%     F_1m{1,j} = find (strcmpi(V2_Basin3,V2_Basin3{i,1}));                              % Find all temperature measured in a day.
%     s2 = find (strcmpi(V2_Basin3,V2_Basin3{i,1}),1,'last');                             
%     i=1+s2;
%     j=j+1;
%     
% end
% 
% 
% for i = 1 : length (F_1m)
%     for j = 1 : length (F_1m{1,i})
%         vp2 = (F_1m{1,i}(j,1));
%         FinalO_1m{1,i}{j,1} = Basin3_1m_2(vp2,1);
%     end
% end
% 
% 
% for i = 1:length (F_1m)
%     for j = 1 : length (F_1m{1,i})
%        OBasin3_1m (j,i) =  FinalO_1m{1,i}(j,1);  
%     end       
% end
% 
% 
% e3 = ~cellfun(@isempty,OBasin3_1m);
% result3 = zeros(size(OBasin3_1m));
% result3(e3) = cellfun(@(x)mean(x(:,1)),OBasin3_1m(e3));
% 
% 
% O_Basin3_1m = sum(result3,1) ./ sum(result3~=0,1);
%     
%    
% 
% 
% for i = 1 : length (F_1m)
%     for j = 1 : length (F_1m{1,i})
%         vt2 = (F_1m{1,i}(j,1));
%         Finalt_1m{1,i}{j,1} = Basin3_1m_2(vt2,2);
%     end
% end
% 
% 
% for i = 1:length (F_1m)
%     for j = 1 : length (F_1m{1,i})
%        TBasin3_1m (j,i) =  Finalt_1m{1,i}(j,1);  
%     end       
% end
% 
% 
% e4 = ~cellfun(@isempty,TBasin3_1m);
% result4 = zeros(size(TBasin3_1m));
% result4(e4) = cellfun(@(x)mean(x(:,1)),TBasin3_1m(e4));
% 
% 
% Temp_Basin3_1m = sum(result4,1) ./ sum(result4~=0,1);
% 
% %%
% 
% 
% figure(1)
% hold on
% startDate = datenum('07-10-20');                               % X axis                         
% endDate = datenum('05-19-21');
% xData = linspace(startDate,endDate,endDate - startDate +1);
% % ax = gca;
% % ax.XTick = xData;
% 
% y1 = O_Basin3_1m;
% y2 = O_Basin3_21m;
% 
% 
% 
% plot(xData,y1,'r','LineWidth',2)
% 
% 
% 
% % ylim(1.1*[min(y1) max(y1)]);
% 
% 
% 
% datetick('x','dd-mmm-yyyy','keepticks')
% ylim([-10 650]);
% % set(gca,'YTick',[0 1 2 3 4 5 6 7 8 9 10]);
% xlim([737973 738300]) ;
% % ax.XTickMode = 'auto'
% % ax.XAxis.LineWidth = 4;
% box on
% %set(gca,'XTick',[737679 738294]);
% %datenum(xlim)
% 
% 
% plot(xData,y2,'b','LineWidth',2)
% h_label = ylabel('Oxygen Concentration(mg/l)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
% xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
% legend('Oxygen Concentrationat at 1m ','Oxygen Concentrationat at 21m');
% 
% title('Tantare Basin 3','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
% 
% hold off
% 
% 
% figure(2)
% 
% h1 = subplot(2,1,1);
% 
% plot(xData,y1,'r','LineWidth',2)
% datetick('x','dd-mmm-yyyy','keepticks')
% 
% xlim([737973 738300]) ;
% ylim([260 650]);
% 
% 
% str = {'(a) Oxygen Concentrationat at 1m'};
% text(738001,570,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
% title('Tantare Basin 3','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
% hold on
% 
% h2 = subplot(2,1,2);
% 
% plot(xData,y2,'b','LineWidth',2)
% hold on
% 
% datetick('x','dd-mmm-yyyy','keepticks')
% ylim([-10 80]);
% %set(gca,'YTick',[0  2 4 6 8 10]);
% xlim([737973 738300]) ;
% %set(gca,'XTick',[737720 737820 737920 738020 738120 738220 738320]);
% 
% str = {'(b) Oxygen Concentrationat at 21m'};
% text(738001,62,str,'FontSize',12,'FontName','FixedWidth','FontWeight','bold')
% xlabel('Date','FontSize',12,'FontName','Times New Roman','FontWeight','bold')
% 
% p1 = get(h1,'position');
% p2 = get(h2,'position');
% height = p1(2)+p1(4)-p2(2);
% h3 = axes('position',[p2(1) p2(2) p2(3) height],'visible','off');
% h_label = ylabel('Oxygen Concentration(mg/l)','visible','on','FontSize',12,'FontName','Times New Roman','FontWeight','bold');
% 
% 
