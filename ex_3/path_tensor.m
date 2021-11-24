function G = path_tensor(A,k)

G(:,:,1) = A;

for i=2:k
    G(:,:,i) = G(:,:,i-1)*A;
end

G = tensor(G);