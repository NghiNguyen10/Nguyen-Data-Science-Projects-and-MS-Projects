A = [-1 3 1 1;
      2 -6 0 2;
      -1 3 2 3;
      1 -3 2 5];
  
b1 = [-5; 8; -6; 2];
b2 = [4; -2; 7; 5];
b3 = [3; 0; 6; 6];

B = [b1 b2 b3];
[r_b,c_b] = size(B);

A_aug = [A B];

[X_p, S_0, X] = mat_sol(A,B);
[r0,c0] = size(S_0);

% Particular solution
disp('Particular solution')
X_p

% Independent columns
disp('Independent columns')
S_0

% General solution
disp('General solution is a combination of X_p and c0*c_b matrices.')
disp('The later matrices are the same size as that of B in which all')
disp('columns are zero except only one. The nonzero columns is taken')
disp('from one of columns of S_0')
X
