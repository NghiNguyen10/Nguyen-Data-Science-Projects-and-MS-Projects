%
% 3-dimensional non-UES example
%

clc
clear
close all

mu  = 0.25;
omega   = 1;
a       = 1;
b       = 4;        % b = a for UES; b > a for instability
rho     = b/a;
alpha   = 1/2;

T       = 2*pi/omega;

Ac0     = -mu*eye(3) + [0 -omega/rho 0; omega*rho 0 0; 0 0 0];
Ai0     = [0 -1 0; 1 0 0; 0 0 1] * alpha;

Q       = [1/2 0 -1/2; 0 1 0; 1/2 0 1/2];
Ac      = Q \ Ac0 * Q;
Ai      = Q \ Ai0 * Q;

stab_val    = alpha * rho * exp(-mu*T/4)
lambda_crit = 2*omega/pi * abs( log(rho * alpha) )

%
% Simulate impulsive system
%
t0         = 0;
x0         = Q \ [1; 0; 0];

kstop      = 10;
delta      = T/4;
tau        = (1:kstop) * delta;

[state,time] = simimp_original(Ac, Ai, tau, t0, x0);
%[time, state] = impsim(Ac, Ai, tau, t0, x0);
%impplot(time, state);
%impplot3(time, state);

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
x3 = state(3,:);
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