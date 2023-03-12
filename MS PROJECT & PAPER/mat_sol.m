function [X_particular, S_0, matrix_solver] = mat_sol(A,B)

% A is a matrix and B is a matrix
% This function is to give a solution to the linear
% equation AX = B

[R,jb] = rref(A);
r_0 = length(jb);
  
A_aug = [A B];
[R1,jb] = rref(A_aug);
r_aug = length(jb);

if r_0 == r_aug
% We just solve the system when it is consistent, i.e. r = r_aug
% Determine the pivot variables and the particular solution
    [r,c] = size(A);
    [r1,c1] = size(B);
    X_p = zeros(c,1); % initialize
    
    k=1;
    for i = 1:c1
        X_p(jb) = R1(1:r_aug,c+i);
        X_par(:,k) = X_p;
        k = k+1;
    end
    X_particular = X_par;
    % Determine the parameterized set of the associated
    % homogeneous equation
    S_0 = null(A,'r');

    % Determine the general solution for the nonhomogeneous equation
    matrix_solver = [X_par S_0];
    
else disp('The equation is not consistent');
    [X_particular, S_0, matrix_solver] = [];
end
