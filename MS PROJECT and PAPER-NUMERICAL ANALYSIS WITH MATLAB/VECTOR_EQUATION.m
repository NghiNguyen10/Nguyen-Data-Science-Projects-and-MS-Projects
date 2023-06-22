A = [-1 3 1 1;
      2 -6 0 2;
      -1 3 2 3;
      1 -3 2 5];
  
b = [-5;
      8;
     -6;
      2];

X = li_sol(A,b);

% The particular solution
x_p = X(:,1);

% The independent solutions
S = X(:,2:end);

    
