function x_tau = simu(A,g,Tau,t0,x0)

% A and g are data matrices
% Tau is a set of impulse times given in a row vector
% t0 is an nitial time
% x0 is an initial state

l = length(Tau);
x_tau_k = g*exp(A*(Tau(1)-t0))*x0;
impulse_state(:,1) = g*exp(A*(Tau(1)-t0))*x0;
for k = 2:l
    x_tau_k = g*exp(A*(Tau(k)-Tau(k-1)))*x_tau_k;
    impulse_state(:,k) =  x_tau_k;
end
x_tau = impulse_state;


