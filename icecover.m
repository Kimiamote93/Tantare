
function [startdate,enddate] = icecover(T_Bottom,T_TOP,date1,date2) ;

for i = date1:date2
    diff (i-date1+1,1) = T_Bottom(i,1) - T_TOP(i,1)  ;   
end

Xptr = 0;  Yptr = 1; row = 1;

while Xptr<numel(diff)    
    Xptr = Xptr+1;
    if diff(Xptr)>0.1
        Y(row,Yptr)=diff(Xptr);
        Yptr = Yptr+1;
    elseif Xptr>1
        row = row+1;
        Yptr = 1;
    end
      
end

XXptr = 1;
[r, c] = size(Y);

for i = 1:r
    if Y(i,1)>0
       XX(XXptr,:) = Y(i,:);
       XXptr = XXptr+1;
    end
end


startdate = find(diff==XX(end,1));
enddate = find(diff==XX(2,end));

