function ad_X = str_cons(L,L1)

k = 1;
[r1,d1] = size(L);  % d1 = the dimension of L;
[r2,d2] = size(L1); % d2 = the dimension of L1
% Calculating structure constants
for j=1:d2
    for i=1:d1
        Z = bracket(vec_inv(L1(:,j)),vec_inv(L(:,i)));
        STORAGE(:,k) = coor(L,Z);
        k = k+1;
    end
end

% Calculating adjoint representation of L1
[row,c] = size(STORAGE);
r = 1;
m = 1;
n = d1;
while n <= c
    C(:,:,r) = STORAGE(:,m:n);
    r = r+1;
    m = n+1;
    n = r*d1;
end
ad_X = C; % Return a three dimensional array

