% SIMULATION & PLOT STATE TRAJECTORIES OF LINEAR IMPULSIVE SYSTEM
clear all
clc
close all

A1 = [-2 1 0; 0 -1 0; 0 0 -1];

g1 = [1/2 1 -1; 0 0 -1/2; 0 1 0];

T  = [1 0 0; 0 0 1; 1 1 0];
d1 = det(T);

T_inv = ratinv(T);
A = T_inv*A1*T
g = T_inv*g1*T
eig(g);
s = rng;
rng(s);
Delta = 3.5 - randi(3,1,10);
d = length(Delta);
t0 = 0;
Tau(1) = t0;
for j = 2:d+1
    B = Tau(j-1) + Delta(j-1);
    Tau(j) = B;
end
Tau;
x0 = [0.5; 0.5; 1];


[impulse_state,time] = simimp(A,g,Delta,t0,x0);
[row, p] = size( impulse_state );
l    = length(Tau);

for k = 1:row
figure
grid on
title('Response to Inital Values')
xlabel('time (sec)')
ylabel(strcat('State variable x_',int2str(k)))
hold on
xk = impulse_state(k,:);
plot(time,xk,'--b')
m = 1; % begining point of each interval
n = 100*Delta(1)+1; % ending point of each interval
for i=1:l-2
    plot(time(m:n),xk(m:n),'r') % Plot continuous trajectories wth respect to each interval [Tau_k,Tau_(k+1)]
    plot(time(n),xk(n),'ok')    % Plot @ jumps for the ending with empty circle
    plot(time(n+1),xk(1,n+1),'.k') % Plot @ jump for the starting with filled circle
    d = 100*Delta(i+1) + 1;
    m = n+1;
    n = n+d;
end
plot(time(m:n),xk(m:n),'k')  % Plot the last interval
hold off
end

% 
figure
grid on
title('Sate Portrait')
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
hold on
x1 = impulse_state(1,:);
x2 = impulse_state(2,:);
x3 = impulse_state(3,:);
plot3(x1,x2,x3,'--b')

m = 1;
n = 100*Delta(1)+1;
for i=1:l-2
    x1 = impulse_state(1,m:n);
    x2 = impulse_state(2,m:n);
    x3 = impulse_state(3,m:n);
    plot3(x1,x2,x3,'r')
    plot3(impulse_state(1,n),impulse_state(2,n),impulse_state(3,n),'y')
    plot3(impulse_state(1,n+1),impulse_state(2,n+1),impulse_state(3,n+1),'.k')
    d = 100*Delta(i+1) + 1;
    m = n+1;
    n = n+d;
end
x1 = impulse_state(1,m:n);
x2 = impulse_state(2,m:n);
x3 = impulse_state(3,m:n);
plot3(x1,x2,x3,'k')
hold off

