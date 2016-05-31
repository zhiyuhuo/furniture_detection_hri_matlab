function createVAT(X)

D = pdist2(X,X);
N = [];
M = [1:size(D,1)];

%find largest edge
[i,j] = find(D == max(max(D)));

N(1) = i(1);
M = setdiff(M, i);

for i = 2:size(D,1)-1
    Dsub = D(N,M);
    [~, j] = find(Dsub == min(min(Dsub)));
    N(i) = M(j);
    M = setdiff(M, M(j));  
end

figure; imagesc(D(N,N));