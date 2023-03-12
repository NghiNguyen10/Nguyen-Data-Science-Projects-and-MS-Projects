% A = [-2 -1 0 0; 0 -1 0 0; 4 0 0 -1; 0 4 0 1];
% 
% b = [0; 2; 5; -9];

A = [-1 3 1 1;
      2 -6 0 2;
      -1 3 2 3;
      1 -3 2 5];
  
b1 = [-5; 8; -6; 2];
b2 = [4; -2; 7; 5];
b3 = [3; 0; 6; 6];

B = [b1 b2 b3];

[r_b,c_b] = size(B);
% 
I = eye(c_b);
K = kron(I,A);
b = vec(B);
x = li_sol(K,b);

% Particular solution
X_p = reshape(x(:,1),[r_b,c_b])

% General solution
X(:,:,1) = X_p;
[r,c] = size(x);
k = 2;
for j=2:c
    X(:,:,k) = reshape(x(:,k),[r_b,c_b]);
    k = k+1;
end
disp('General solution')
X
