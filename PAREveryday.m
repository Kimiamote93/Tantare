clc
clear all

path(path,'C:\MyLake\Donnees_Brutes_20210519\tantere_bassin3_20210519\miniPAR_1.5m_339428\7530-339428');

    fid = fopen('2020-07-10 180900Z.txt', 'rt') ;
    fgets(fid) ;                                              % Read/discard line.                             
    buffer = fread(fid, Inf) ;                                % Read rest of the file.
    fclose(fid);
    fid = fopen('2020-07-10 180900Z.txt', 'w')  ;                    % Open destination file.
    fwrite(fid, buffer) ;                                     % Save to file.
    fclose(fid) ;

      R = regexp( fileread('2020-07-10 180900Z.txt'), '\n', 'split');
    R{2} = sprintf('%s',"Time (sec),  Bat (Volts),   T (deg C),  PAR (umol/(s m^2)),  Ax (g), Ay (g), Az (g)");
    fid = fopen('2020-07-10 180900Z.txt', 'w');
    fprintf(fid, '%s\n', R{:});
    fclose(fid);
    
    
    A = readtable('2020-07-10 180900Z.txt','Format','%f%f%f%f%f%f%f');   % Read the 4th column.
    B = table2array(A(:,4));      
    C  = table2array(A(:,1));
    D = datetime(C, 'convertfrom','posixtime') - hours (4) ;
    
    delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')
    
    plot(D,B,'b','LineWidth',2)