%
% Compute the inverse of a rational matrix
%
function B = ratinv(A)

n    = size(A,1)
R    = rref( [A eye(n)] );
B    = R(:, n+1:2*n );
