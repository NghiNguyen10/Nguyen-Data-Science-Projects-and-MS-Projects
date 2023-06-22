function Levi_factor = Levi(L)

% L is the Lie algebra (Each element in vector form)
% R = Rad(L) (Each element in vector form)

R = rad(L);
[r,c] = size(L);
[r1,c1] = size(R);
if c1 == c
    Levi_factor = []; % L is solvable
elseif c1 == 0
    Levi_factor = L;  % L is semisimple
else

% The complement of R in L is
Com = comp(L,R);
L1 = [Com R];
% Find structure constants for the quotient space L/R
% L/R <--> {x1_bar, x2_bar ... xm_bar} ~ C <--> {x1, x2 ... xm}
ad_X = str_cons(L1,L1); % Recalculate a set of structure constants for L
                        % with respect to a new basis [C R]
[r,c,p] = size(ad_X);
   for k = 1:p-1
       B = ad_X(:,:,k);
       [r_b,c_b] = size(B);
       % ad_X_bar are induced map from ad_X
       ad_X_bar(:,:,k) = B(1:r_b-1,1:c_b-1); % Delete last columns and last rows
                                             % of ad_Xk
   end
   
   % STEP 1 (RIGHT-HAND SIDE): Calculating the right-hand side tube b_ij of 
   % the EQUATION
   % and STEP 3 (LEFT-HAND SIDE): Calculating the Matrix in the left-hand side of 
   % the EQUATION
   [r1,c1,p1] = size(ad_X_bar);
   column = 1;
   for k = 1:p1-1                      % k is the index of page
       for j = k+1:p1                  % j is the index of column
           Xk = vec_inv(Com(:,k));
           Xj = vec_inv(Com(:,j));
           tube(:,column) = vec(bracket(Xk,Xj)) - Com*ad_X_bar(:,j,k);
           % RIGHT-HAND SIDE
           % There are p1(p1-1)/2 = m(m-1)/2
           b = ad_X_bar(:,j,k);
           Matrix_trans(:,column) = b; % LEFT-HAND SIDE
           column = column+1;
       end
   end

% STEP 2(LEFT-HAND SIDE): Calculating the Yij (scalars) in the left-hand side
% of the EQUATION
   Yij_trans = mat_sol(R,tube); % Yij is a column vector
   Yij = Yij_trans';

   Matrix = Matrix_trans';

   alpha = mat_sol(Matrix,Yij); % alpha is a matrix in which column i goes
                             % with r_i

   % STEP 4: Computing a basis for a Levi factor using the following
   % transformations yi = xi + sum(apha_ji*r_j), i = 1...m
   [r_alpha,c_alpha] = size(alpha);
   for i = 1:r_alpha
       yi = Com(:,i) + R*alpha(i,:)';
       Levi_factor(:,i) = yi; 
    end
end





