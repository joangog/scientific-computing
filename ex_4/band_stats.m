function P = band_stats(mxid,p)

% if input is integer scalar (e.x 1497)
% or char array (e.x. 'Rajat/rajat04' not "Rajat/rajat04")
if isscalar(mxid) && int32(mxid)==mxid || ischar(mxid) 
    A = ssget(mxid).A; 
% if input is matrix
elseif ismatrix(mxid)
    A = mxid;
else
    error("Error: Invalid input. First parameter must be int, char array or matrix.")
end

if p > length(A)-1 % if p is such that the band covers MORE than the whole matrix
    p = length(A)-1; % then stop the algorithm when the band covers EXACTLY the whole matrix
end

P = [ones(1,p);zeros(1,p)];

for q = [0:p]
    Ak = triu(tril(A,q),-q);
    P(1,q+1) = nnz(Ak)/nnz(A);
    P(2,q+1) = norm(A-Ak,'fro')/norm(A,'fro');
    if P(2,q+1) == 0  % if error is zero then stop algorithm
        break;
    end
end
