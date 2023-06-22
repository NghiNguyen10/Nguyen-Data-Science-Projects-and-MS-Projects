function L_pr  = der_al(L)
% L is a matrix whose columns constitute a basis for L
k = 1;
[R,jb] = rref(L);
d = length(jb);  %d = rank(L);

if d == 1
    L_pr = []; % L is Abelian
else
    for i=1:d-1
        for j=i+1:d
        B = bracket(vec_inv(L(:,i)),vec_inv(L(:,j)));
        STORAGE(:,k) = vec(B);
        k = k+1;
        end
    end
[R1,jb1] = rref(STORAGE');
r = length(jb1);   % r = rank(STORAGE);
    if r == 0
        L_pr = []; % L is Abelian
    else
        L_pr = R1(1:r,:)';
    end
end
