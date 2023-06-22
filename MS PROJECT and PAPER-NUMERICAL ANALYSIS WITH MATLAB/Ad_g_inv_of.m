function Ad_g_inv = Ad_g_inv_of(g)

g_inv = ratinv(g);
Ad_g_inv = kron(g',g_inv);

% This function returns a (n^2-by-n^2)matrix representation for Ad_g_inv 