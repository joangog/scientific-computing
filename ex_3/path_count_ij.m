function count = path_count_ij(G,i,j)

%calculate sum of elements in fiber G(i,j,:)
I = ones(size(G,3),1);
count = ttv(G(i,j,:),I);
end