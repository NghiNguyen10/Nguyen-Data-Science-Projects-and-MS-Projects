% Calculting the Radical of L
% L is a Lie algebra
function Radical = rad(L)

L1 = der_al(L); % The derived algebra of L
[r,c] = size(L); 
[r1,c1] = size(L1);
if c1 == 0
    Radical = L;  % L is solvable
elseif c1 == c
    Radical = []; % L is semisimple
else
Kill = Kill_form(L,L1); % The Killing form

% Calculating coefficients alpha
alpha = null(Kill,'r');
    % if norm(alpha) == 0; or if alpha = zeros(size(alpha))
    %    Radical = [];
    % else
    
% A set of basis vectors for the radical is linear combinations
% of basis vectors X_i in L and alpha
[r_alpha,c_alpha] = size(alpha);
for n = 1:c_alpha
    b = 0; % b is a c-by-1 vector
        for k = 1:c
        b = b + alpha(k,n)*L(:,k);
        end;
    STORAGE(:,n) = b;
    % Rad(:,:,n) = vec_inv(b);
end;

Radical = STORAGE;  % Return a matrix 
end

