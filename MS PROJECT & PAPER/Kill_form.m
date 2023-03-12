function Kill = Kill_form(L,L1)

ad_X = str_cons(L,L);
ad_Y = str_cons(L,L1);

[r,c] = size(L); % c is the dimension of L
[r1,c1] = size(L1); % c1 is the dimension of L1

% Finding Killing form with respect to L and L_pr
for j=1:c1
    for i=1:c
        K(j,i) = trace(ad_X(:,:,i)*ad_Y(:,:,j));
    end
end
Kill = K; % Return a matrix