function Complement = comp(S,V)

% X is the entire space
% S is a subspace of X
% V is a subspace of S
% Find a complement W to V in S
[R1,jb1] = rref(S);
[R2, jb2] = rref(V);
d1 = length(jb1);  % d1 = rank(S);
d2 = length(jb2);  % d2 = rank(V);

if d2 == d1
    Complement = [];
elseif d2 == 0
    Complement = S;
else
U = mat_sol(S,V);
U_perp = null(U','r');
W = S*U_perp;
Complement = W; % In matrix form. 
                % (vec_inv of each column a basis matrix-vector for W)
end
