
function [PAR_Basin3_7m,Temp_Basin3_7m] = Oxygen_Temp(textFiles) ;

warning('off')


numfiles = length(textFiles);
mydata = cell(1, numfiles);

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_7m_639659\7530-639659');


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
    B = table2array(A(:,4));   ;                
    
    
   
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
