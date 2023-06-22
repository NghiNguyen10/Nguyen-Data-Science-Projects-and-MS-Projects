function coordinate = coor(L,X)

% L is the Lie algebra (each column is basic columns)
% Find coordinates of matrix X with respect to
% the basis columns of L

b = vec(X);
coordinate = mat_sol(L,b);

