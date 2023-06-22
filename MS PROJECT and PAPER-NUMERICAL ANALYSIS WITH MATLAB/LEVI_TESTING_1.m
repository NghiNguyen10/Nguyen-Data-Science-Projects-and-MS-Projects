% NGHI NGUYEN
% Given the Lie algebra L spanned by X1, X2, X3, and X4
clear all
clc
close all

X1 = [0 1 0;
      1 0 0;
      0 0 1];
  
X2 = [1 0 0;
      0 -1 0;
      0 0 1];
  
X3 = [0 1 0;
      0 0 0;
      0 0 1];
  
X4 = [0 1 0;
      1 0 0;
      0 0 0];
  
L = [vec(X1) vec(X2) vec(X3) vec(X4)];
L_pr = der_al(L);

R = rad(L);
[r_R,c_R] = size(R);
for j = 1:c_R
    Rad(:,:,j) =  vec_inv(R(:,j));
end
disp('A bsis for the radical is');
Rad

% START COMPUTING LEVI FACTOR
disp('A basis for a Levi factor is');
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
