% 
% TESTING FOR A SOLVABLE LIE ALGEBRA

clear all
clc
close all

% These are 3-by-3 matrices
A1 = [-2 1 0; 0 -1 0; 0 0 -1];

g1 = [1/2 1 -1; 0 0 -1/2; 0 1 0];

T  = [1 0 0; 0 0 1; 1 1 0];
 
% g1 = [1 1 -1;
%      0 0 -1;
%      0 1 0];
% eig(g1)
% 
Q = [1 0 0;
     1 1 -1;
     0 0 1];
% Q = [1 0 0;
%      1 1 -1;
%      0 1 1];
% This Q does not work 
% Q = [1 0 -1;
%      1 1 -1;
%      0 1 1];
% 
d1 = det(T);
T_inv = ratinv(T);
A = T_inv*A1*T
g = T_inv*g1*T
eig(g)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% This example works
% A = [-2 1 0;
%      0 -1 0;
%      0 0 -1];
%  
% g = [1 1 -1;
%      0 0 -1;
%      0 1 0];

% This example works
% A = [-2 1 0;
%      0 -1 0;
%      0 0 -1];
%  
% g = [0 1 -1;
%      1 0 -1;
%      0 1 0];

% This example from ACC2018-works
% A = [-2 1 1 1;
%       1 -2 -1 0;
%       -1 2 0 2
%       0 1 0 -1];
% 
% g = [-1 2 1 1;
%      1 -1 0 -1;
%      -1 3 1 2
%      0 1 -1 1];

% This example from ACC2018-works
% A = [-1 0 -1 2;
%       0 -2 1 0;
%       0 0 -1 -1
%       0 0 1 -1];
% 
% g = [0 1 -1 1;
%      1 0 1 -1;
%      0 0 0 -1
%      0 0 1 0];
 
% These examples are original for ACC2018
% A1 = [1 0 -1 0 2 1;
%      0 -1 3 -2 0 -3;
%      0 0 2 0 0 0;
%      0 0 0 -3 0 0;
%      0 0 0 0 2 0;
%      0 0 0 0 0 -3];
%  
% g1 = [0 2 1 -2 0 2;
%      1 0 -3 0 -1 3;
%      0 0 0 0 0 -1;
%      0 0 1 0 0 0;
%      0 0 0 1 0 -2;
%      0 0 0 0 1 0];
%  
% P =[1 0 0 0 0 0;
%      0 1 0 0 0 0;
%      0 1 1 0 1 0;
%      0 1 0 1 0 0;
%      1 0 0 0 1 0;
%      0 -1 0 0 -1 1];
%  
% P_inv = inv(P);
% A = P_inv*A1*P;
% g = P_inv*g1*P;

% This example works
% A = [1 0 -1 0 2 1;
%      0 -1 3 -2 0 -3;
%      0 0 2 0 0 0;
%      0 0 0 -3 0 0;
%      0 0 0 0 2 0;
%      0 0 0 0 0 -3];
%  
% g = [0 2 1 -2 0 2;
%      1 0 -3 0 -1 3;
%      0 0 0 0 0 -1;
%      0 0 1 0 0 0;
%      0 0 0 1 0 -2;
%      0 0 0 0 1 0];

% Transformed matrices A and g
% A = [-3 2 -1 0 4 1;
%      6 -5 3 -2 -6 -3;
%      6 -7 5 -2 -6 -3;
%      6 -2 3 -5 -6 -3;
%     -5 2 -1 0 6 1;
%     -1 2 -3 2 1 0];
% 
% g = [-1 5 1 -2 1 2;
%      -4 6 -3 0 5 3;
%      -1 2 -3 1 2 0;
%      -3 5 -2 0 4 3;
%       1 2 1 -1 -1 0;
%       1 -3 3 -1 -2 -1];

L = Lie(A,g);
[r,c] = size(L);
k = 1;
for j = 1:c
    M(:,:,k) =  vec_inv(L(:,j));
    k = k+1;
end
disp('A bsis for L is');
M;

% The derived algebra
L_pr  = der_al(L);
[r1,c1] = size(L_pr);
k = 1;
for j = 1:c1
    N(:,:,k) = vec_inv(L_pr(:,j));
    k = k+1;
end
disp('A bsis for L_prime is');
N;

% Structure constants
ad_X = str_cons(L,L);

% The Killing form
Kill = Kill_form(L,L_pr);

% The radical
R = rad(L);
[r3,c3] = size(R);
r = 1;
for j = 1:c3
    Rad(:,:,r) =  vec_inv(R(:,j));
    r = r+1;
end
disp('A bsis for Rad is');
Rad;

% A complement of the radical
Com = comp(L,R);
[r4,c4] = size(Com);
if c4 == 0
    disp('A complement is');
    [];
else
l = 1;
for j = 1:c4
    C_comp(:,:,l) =  vec_inv(Com(:,j));
    l = l+1;
end
disp('A basis for a complement');
C_comp;
end

% START COMPUTING LEVI FACTOR
disp('A basis for Levi factor is');
Le = Levi(L);
[r5,c5] = size(Le);
if c5 == 0
    Levi_factor = [];
else
t = 1;
for j = 1:c5
    Levi_factor(:,:,t) =  vec_inv(Le(:,t));
    t = t+1;
end
disp('A bsis for Levi factor is');
Levi_factor;
end