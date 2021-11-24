function count = path_count_ij(G,i,j)
% Author : и . цыцоу , ал 1054388 , Date : 16/2/2021

%calculate sum of elements in fiber G(i,j,:)
I = ones(size(G,3),1);
count = ttv(G(i,j,:),I);
end