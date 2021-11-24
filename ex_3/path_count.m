function count = path_count(G)

%calculate sum of elements in every fiber G(i,j,:) 
I = ones(size(G,3),1);
count = ttv(G,I,3);
end