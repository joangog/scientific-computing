function count = path_count(G)
% Author : и . цыцоу , ал 1054388 , Date : 16/2/2021

%calculate sum of elements in every fiber G(i,j,:) 
I = ones(size(G,3),1);
count = ttv(G,I,3);
end