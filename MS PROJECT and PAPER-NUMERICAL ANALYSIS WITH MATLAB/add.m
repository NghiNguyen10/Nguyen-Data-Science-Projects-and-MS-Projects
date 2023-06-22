function sum = add(M, N)
% M and N are two matrices having the same number of rows
% and representing two subalgebras
% whose basis are columns of M and N.

STORAGE = [M N];
[R,jb] = rref(STORAGE');
r = length(jb);
% r = rank(STORAGE);
sum = R(1:r,:)'; % find a basis for the sum