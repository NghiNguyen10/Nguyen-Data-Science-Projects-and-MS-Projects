function linear_solver = li_sol(A,b)

% A is a matrix and b is a vector
% This function is to give a solution to the linear
% equation Ax = b

[R,jb] = rref(A);
r_0 = length(jb);
  
A_aug = [A b];
[R1,jb1] = rref(A_aug);
r_aug = length(jb1);

if r_0 == r_aug
% We just solve the system when it is consistent, i.e. r = r_aug
% Determine the pivot variables and the particular solution
    [r,c] = size(A);
    x_p = zeros(c,1);
    x_p(jb1) = R1(1:r_aug,end);

    x_par = x_p;

    % Determine the parameterized set of the associated homogeneous equation
    S = null(A,'r');

    % Determine the general solution for the nonhomogeneous equation
    linear_solver = [x_par S];
else disp('The equation is not consistent');
    linear_solver = [];
end
