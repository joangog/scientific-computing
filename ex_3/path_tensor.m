function G = path_tensor(A,k)
% Author : и . цыцоу , ал 1054388 , Date : 16/2/2021

G(:,:,1) = A;

for i=2:k
    G(:,:,i) = G(:,:,i-1)*A;
end

G = tensor(G);