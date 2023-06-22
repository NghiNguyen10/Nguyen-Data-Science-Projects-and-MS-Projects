function [simulation, time] = simimp_original(A,g,Tau,t0,x0)

% A and g are data matrices
% Tau is a set of impulse times given in a row vector
% t0 is an nitial time
% x0 is an initial state

sysA  = ss(A, [], eye(size(A)), []);

Tau   = [t0 Tau];
Delta = diff(Tau);
time  = [];
impulse_state = [];

xp   = x0;

l    = length(Tau);

for k = 1:l-1
    tt = 0:0.01:Delta(k);
    xx = initial(sysA, xp, tt)';
    impulse_state = [impulse_state xx];
    time = [time tt+Tau(k)];
    xn = xx(:, end);
    xp = g * xn;
end

simulation = impulse_state;


