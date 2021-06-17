
function [x] = missingdata(textFiles,date1,date2,data) ;

Q = struct2cell(textFiles); 

startDate = datenum(date1);                               % X axis                         
endDate = datenum(date2);
dd = endDate - startDate + 1 ;
xData = linspace(startDate,endDate,dd);


splitcells = regexp(Q(1,:), '\s+', 'split');

for i = 1 : length (splitcells)
   
    B{i,1} =  splitcells {1, i}{1, 1}  ;
    B{i,2} = datenum( B{i,1} );
    
end


load data.mat

x = data;

for i = 1: length (textFiles)
    W(i,1) = B{i,2};
end


if length (xData) == length (data)
    disp ('There is no missing data found')
else
    disp ('The missing data are:')
    for j=1:dd
        if W(j,1) ~= xData (1,j)
              W = [W(1:j-1,1) ; 0 ;W(j:end,1)];
              Formatspec = 'The missing data:';
              fprintf('<a href = "%s">%s</a>\n',Formatspec,B{j,1})
             
        end
    end
end

for j=1:length (textFiles)
        if W(j,1) ~= xData (1,j)
            x = [x(1:j-1,1) ; (x(j-1,1)+x(j,1))/2 ;x(j:end,1)];
        end
end
     
delete('C:\MyLake\Donnees_Brutes_20210519/*.txt')

    
