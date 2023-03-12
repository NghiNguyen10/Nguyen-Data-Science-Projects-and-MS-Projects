function ad_A = ad_A_of(A)
% A is a matrix

I = eye(size(A));
ad_A = (kron(I,A)-kron(A',I));

% This function returns a (n^2-by-n^2)matrix representation for ad_A 