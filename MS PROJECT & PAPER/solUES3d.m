clear all
clc
close all

% GIVEN THE DATA MATRICES A AND g
A1 = [-2 1 0; 0 -1 0; 0 0 -1];

g1 = [1/2 1 -1; 0 0 -1/2; 0 1 0];

T  = [1 0 0; 0 0 1; 1 1 0];

d1 = det(T);
T_inv = ratinv(T);
A = T_inv*A1*T;
g = T_inv*g1*T;
eig(g);

% Simulation
% s = rng;
% Delta = 3.5 - randi(3,1,10);
% rng(s);
Delta = [0.5 0.5 2.5 0.5 2.5 1.5 1.5 0.5 1.5 0.5]; 
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

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
[n, p] = size( impulse_state );
l      = length(Tau);
dtime  = diff(time);
inc    = max(dtime);
tol    = inc / 100;
idx    = [0 find( abs(dtime) < tol ) length(time)];
num    = length(idx); 

% Plot state trajectories
for k = 1:n
    xk  = impulse_state(k,:);
    figure(k)
    grid on
    % title('Response to Inital Values')
    xlabel('time (sec)')
    ylabel( strcat('State variable x_',int2str(k)) )
    hold on
    for j = 1:num-1
        plot( time( idx(j)+1:idx(j+1) ), xk( idx(j)+1:idx(j+1) ), 'r')
        if j > 1
            line( time( idx(j) )*[1 1], [xk( idx(j) ) xk( idx(j)+1 )], 'Color', 'b', 'LineStyle', '--')
            plot( time( idx(j) ), xk( idx(j) ), 'ko')
            plot( time( idx(j) ), xk( idx(j)+1 ), 'ko', 'MarkerFaceColor', 'k')
        end
    end
    hold off
end

% Plot state portrait
x1 = impulse_state(1,:);
x2 = impulse_state(2,:);
x3 = impulse_state(3,:);
figure
grid on
% title('Sate Portrait')
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
hold on

for j = 1:num-1
   plot3( x1( idx(j)+1:idx(j+1) ),x2( idx(j)+1:idx(j+1) ), x3( idx(j)+1:idx(j+1) ), 'r')
   if j > 1
      line([x1(idx(j)) x1(idx(j)+1)],[x2(idx(j)) x2(idx(j)+1)], [x3(idx(j)) x3(idx(j)+1)], 'Color', 'b', 'LineStyle', '--')
      plot3( x1( idx(j) ), x2( idx(j) ), x3( idx(j) ), 'ko')
      plot3( x1( idx(j)+1 ), x2( idx(j)+1 ), x3( idx(j)+1 ), 'ko', 'MarkerFaceColor', 'k')
   end
end
hold off

% Plot Lyapunov function
P = [9 8 0; 8 8 0; 0 0 16];
for i = 1:length(time)
    V(i) = impulse_state(:,i)'*P*impulse_state(:,i);
end
figure
grid on
xlabel('time (sec)')
ylabel('Lyapunov Function')
hold on
for j = 1:num-1
        plot( time( idx(j)+1:idx(j+1) ), V( idx(j)+1:idx(j+1) ), 'r')
        if j > 1
            line( time( idx(j) )*[1 1], [V( idx(j) ) V( idx(j)+1 )], 'Color', 'b', 'LineStyle', '--')
            plot( time( idx(j) ), V( idx(j) ), 'ko')
            plot( time( idx(j) ), V( idx(j)+1 ), 'ko', 'MarkerFaceColor', 'k')
        end
end
hold off