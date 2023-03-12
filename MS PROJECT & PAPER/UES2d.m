%
% UES: 2-dimensional example from 2013 ACC paper
%

clc
clear
close all

mu  = 0.25;
omega   = 1;
a       = 1;
% b       = 3;        % b = a for UES; b > a for instability
b       = 1;
% b       = 0.5;
rho     = b/a;
alpha   = 1/2;

T       = 2*pi/omega;

Ac      = -mu*eye(2) + [0 -omega/rho; omega*rho 0];
Ai      = [0 -1; 1 0];

stab_val    = rho * exp(-mu*T/4);
lambda_crit = 2*omega/pi * log(rho*alpha)

%
% Simulate impulsive system
%
t0         = 0;
x0         = [1 0]';
% x0         = [10 10]';

kstop      = 10;
delta      = T/4;
tau        = (1:kstop) * delta

[state,time] = simimp_original(Ac, Ai, tau, t0, x0);
% impplot(time, state);
% impplot2(time, state);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
[n, p] = size( state );
l      = length(tau);
dtime  = diff(time);
inc    = max(dtime);
tol    = inc / 10;
idx    = [0 find( abs(dtime) < tol ) length(time)];
num    = length(idx); 

% Plot state trajectories
for k = 1:n
    xk  = state(k,:);
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
x1 = state(1,:);
x2 = state(2,:);
figure
grid on
% title('Sate Portrait')
xlabel('x_1')
ylabel('x_2')
hold on

for j = 1:num-1
   plot( x1( idx(j)+1:idx(j+1) ),x2( idx(j)+1:idx(j+1) ), 'r')
   if j > 1
      line([x1(idx(j)) x1(idx(j)+1)],[x2(idx(j)) x2(idx(j)+1)], 'Color', 'b', 'LineStyle', '--')
      plot( x1( idx(j) ), x2( idx(j) ), 'ko')
      plot( x1( idx(j)+1 ), x2( idx(j)+1 ), 'ko', 'MarkerFaceColor', 'k')
   end
end
hold off

