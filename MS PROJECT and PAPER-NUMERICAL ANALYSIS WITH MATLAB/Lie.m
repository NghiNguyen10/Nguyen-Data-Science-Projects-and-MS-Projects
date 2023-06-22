% COMPUTING IMPULSIVE LIE ALGEBRA
%
function L = Lie(A,g)

ad_A = ad_A_of(A);
Ad_g_inv = Ad_g_inv_of(g);

L_0 = min_inv(Ad_g_inv, vec(A));
L_1 = add(L_0, min_inv(Ad_g_inv, ad_A*L_0));

N1 = L_0;
[R, jb] = rref(N1);
r1 = length(jb);
% r1 = rank(N1);
condition = 1;
while condition
   r0 = r1;
   N  = N1;
   N1 = add(L_0, min_inv(Ad_g_inv, ad_A*N));
   [R1, jb1] = rref(N1);
   r1 = length(jb1); 
   condition = (r1 > r0);
end
[R2,jb2] = rref(N');
r2 = length(jb2);
L = R2(1:r2,:)'; % In matrix form

