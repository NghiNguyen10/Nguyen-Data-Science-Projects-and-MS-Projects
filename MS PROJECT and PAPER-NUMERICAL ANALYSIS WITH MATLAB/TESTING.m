% 
% COMPUTING THE ASSOCIATED LIE ALGEBRA
% OF LINEAR IMPULSIVE SYSTEMS

% TESTING FOR A NONSOLVABLE LIE ALGEBRA

clear all
clc
close all

% Enter matrix A and an invertible matrix g

A = [1 -1 1;
     1 1 2;
     0 1 1];

g = [1 1 -1;
     0 1 1;
     0 0 1];

% A1 = [1 -1 1;
%      1 1 0;
%      0 1 1];
% 
% g1 = [1 1 -1;
%      0 1 1;
%      0 0 1];
% d1 = det(g1);
% d2 = det(A1);

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
    Levi_factor = []
else
t = 1;
for j = 1:c5
    Levi_factor(:,:,t) =  vec_inv(Le(:,t));
    t = t+1;
end
disp('A bsis for Levi factor is');
Levi_factor
end