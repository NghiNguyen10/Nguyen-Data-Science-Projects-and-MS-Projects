function Matrixize = vec_inv(x)
% x is a vector
r = length(x);
Matrixize = reshape(x,[sqrt(r),sqrt(r)]);