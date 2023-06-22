% NGHI NGUYEN
% Given the Lie algebra L spanned by X1, X2, X3, and X4
% Test Example in Dagli

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

% 
% START COMPUTING LEVI FACTOR 
% C = comp(L,Rad);

% Find structure constants for the quotient space L/R
% L/R <--> {x1_bar, x2_bar ... xm_bar} ~ C <--> {x1, x2 ... xm}  
L1 = [L(:,1:3) R]; % L1 = [C R];
C1 = L(:,1:3); % or C1 = comp(L1,R);
ad_X = str_cons(L1,L1);

[r,c,p] = size(ad_X);

for k = 1:p-1
    B = ad_X(:,:,k);
    [r_b,c_b] = size(B);
    % Delete last columns and last rows of ad_Xk
    % B(:,c_b) = [];
    % B(r_b,:) = [];
    % ad_X_bar(:,:,k) = B;
    ad_X_bar(:,:,k) = B(1:r_b-1,1:c_b-1); 
    % ad_X_bar are induced map from ad_X
end

% STEP 1 (RIGHT-HAND SIDE): Calculating the right-hand side tube b_ij of the EQUATION
[r1,c1,p1] = size(ad_X_bar);
l = 1;
for k = 1:p1-1      % k is the index of page
    for j = k+1:p1  % k is the index of column
        Xk = vec_inv(C1(:,k));
        Xj = vec_inv(C1(:,j));
        % for s = 1:r1 % the number of columns of C = r1
        %    q = C(:,s)*ad_X_bar(s,j,k);
        %    tube(:,l) = vec(bracket(Xk,Xj)) - q;
        %end
        tube(:,l) = vec(bracket(Xk,Xj)) - C1*ad_X_bar(:,j,k);
        % There are p1(p1-1)/2 = m(m-1)/2
        l = l+1;
    end
end

%
%
% STEP 2 (LEFT-HAND SIDE): Calculating the Yij (scalars) in the left-hand side of the EQUATION
R1 = -R;
Yij_trans = mat_sol(R1,tube); % Yij is a column vector
% Yij = [2; 1; -2];

% STEP 3 (LEFT-HAND SIDE): Calculating the Matrix in the left-hand side of the EQUATION
column = 1;
for k = 1:p1-1 % k is the index of page
    for j = k+1:p1 % k is the index of column
        b = ad_X_bar(:,j,k);
        Matrix_trans(:,column) = b;
        column = column+1;
    end
end
% STEP 1 & STEP 3 can be combined in one block (loop)

Matrix = Matrix_trans';
Yij = Yij_trans';
alpha = mat_sol(Matrix,Yij); % alpha is a matrix in which column i goes
                             % with r_i

% Computing a basis for a Levi factor
% yi = xi + sum(apha_ji*r_j)
[r_alpha,c_alpha] = size(alpha);
for i = 1:r_alpha
    yi = C1(:,i) + R1*alpha(i,:)';
    % M(:,i) = yi;
    Levi_factor(:,:,i) = vec_inv(yi); 
end

[r_R1,c_R1] = size(R1);
for j = 1:c_R1
    Rad(:,:,j) =  vec_inv(R1(:,j));
end
disp('A basis for the radical is');
Rad
disp('A basis for a Levi factor is');
Levi_factor







