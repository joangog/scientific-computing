function [y]= spmv_bcrs(y,val,col_idx,row_blk,x)
nd = length(row_blk);
nb = size(val,1);

for i=1:nd-1  % for every row
   for j=row_blk(i)+1:row_blk(i+1)  % for every nnzb of that row
       y(nb*(i-1)+1:nb*i) = y(nb*(i-1)+1:nb*i) + ...  
           val(1:nb,nb*(j-1)+1:nb*j)*x(nb*(col_idx(j)-1)+1:nb*col_idx(j));  % y = y * Ax
   end
end
end

