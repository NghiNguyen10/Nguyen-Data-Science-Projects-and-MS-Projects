%
% TESTING FOR A NONSOLVABLE LIE ALGEBRA
%

clc
clear
close all

lambda  = 0.25;
omega   = 1;
a       = 1;
b       = 4;        % b = a for UES; b > a for instability
rho     = b/a;
alpha   = 1/2;

T       = 2*pi/omega;

Ac0     = -lambda*eye(3) + [0 -omega/rho 0; omega*rho 0 0; 0 0 0];
Ai0     = [0 -1 0; 1 0 0; 0 0 1] * alpha;

Q       = [1/2 0 -1/2; 0 1 0; 1/2 0 1/2];
Ac      = Q \ Ac0 * Q
Ai      = Q \ Ai0 * Q

L = Lie(Ac,Ai);
[r,c] = size(L);
k = 1;
for j = 1:c
    M(:,:,k) =  vec_inv(L(:,j));
    k = k+1;
end
disp('A bsis for L is');
M

% The radical
R = rad(L);
[r3,c3] = size(R);
r = 1;
for j = 1:c3
    Rad(:,:,r) =  vec_inv(R(:,j));
    r = r+1;
end
disp('A bsis for Rad is');
Rad

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
Levi_factor
end

% The Killing form of the Levi factor
Kill_Levi = Kill_form(Le,Le)

% Compactness of the Levi factor
K = -Kill_Levi;
[r6,c6] = size(K);
N = cell(1,c6);
m =1;
for i = 1:c6
    N(1,i) = {K(1:i,1:i)};
    if det(N{1,m}) <= 0
    disp('The Levi factor is not compact');
    else m = m+1;
    end
end
if m == c6+1
     disp('The Levi factor is compact');
end
    
