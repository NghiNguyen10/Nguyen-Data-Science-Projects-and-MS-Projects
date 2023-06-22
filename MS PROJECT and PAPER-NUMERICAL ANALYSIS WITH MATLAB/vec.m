
function Vectorization  = vec(X)
% X is a r-by-c matrix
% If X is a vector or c = 1  then
% vec(X) = X

[r,c] = size(X);
Vectorization = reshape(X,[r*c,1]);