function M = min_inv(T,B)
% T is a linear transformation (matrix), B is a matrix
% Initialization

M1 = B;
[R, jb] = rref(M1);
r1 = length(jb); % r1 = rank(M1);
condition = 1;
while condition
   r0 = r1;
   M  = M1;
   M1 = [B T*M];
   [R1, jb1] = rref(M1);
   r1 = length(jb1); % r1 = rank(M1);
   condition = (r1 > r0);
end
[R2, jb2] = rref(M');
r2 = length(jb2);
M = R2(1:r2,:)';




