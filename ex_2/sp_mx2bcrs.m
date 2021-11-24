function [val,col_idx,row_blk] = sp_mx2bcrs(A,nb)
% Author : … . √Ÿ√œ’ , ¡Ã 1054388 , Date : 20/2/2021

if( ~issparse(A) || size(A,1)~=size(A,2) )
    error("Error: Invalid input. First parameter must be sparse, square matrix.")
end

n = length(A);

nd = n/nb;  % dimension size of A in blocks

if(floor(nd)~=nd)
    error("Error: Division of matrix dimension with block dimension has remainder.")
end


% init outputs with maximum possible size
val = zeros(nb,nb*nd^2);  
col_idx = zeros(1,nd^2);
row_blk = zeros(1,nd+1);

k = 0; %counter for nnz blocks

for j=1:nd  % for every row
    for i=1:nd  % for every block
        Aij = A(nb*(j-1)+1:nb*j,nb*(i-1)+1:nb*i);
        if nnz(Aij)~=0  % if block nnz
            k = k + 1;
            val(1:nb,1+nb*(k-1):nb*k) = Aij;
            col_idx(k) = i;
            row_blk(j+1) = k;
        end     
    end
end

val = val(1:nb,1:k*nb);
col_idx = col_idx(1:k);

end

