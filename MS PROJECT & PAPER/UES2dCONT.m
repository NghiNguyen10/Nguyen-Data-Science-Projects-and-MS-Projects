clc
clear
close all

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

mu  = 0.25;
omega   = 1;
a       = 1;
% b       = 3;        % b = a for UES; b > a for instability
% b       = 1;
b       = 0.5;
rho     = b/a;
alpha   = 1/2;

T       = 2*pi/omega;

Ac      = -mu*eye(2) + [0 -omega/rho; omega*rho 0];

sysAc  = ss(Ac, [], eye(size(Ac)), []);

x0 = [1; 0];
t = 0:0.01:50;
state = initial(sysAc, x0, t)';
x1 = state(1,:);
x2 = state(2,:);

% figure
% plot(t,x1, 'r')
% grid on
% xlabel('time (sec)')
% ylabel( strcat('State variable x_',int2str(1)) )
% title('Response to Inital Values')
% 
% figure
% plot(t,x2, 'r')
% grid on
% xlabel('time (sec)')
% ylabel( strcat('State variable x_',int2str(2)) )
% title('Response to Inital Values')


% Plot for rho > 1 (rho = 3)
figure
plot(x1,x2, 'r','LineWidth', 2)
grid on
% title('Sate Portrait')
xlabel('x_1')
ylabel('x_2')
hold on

% Ellipse
teta= 0:0.01:2*pi;
u= cos(teta);
v= rho*sin(teta);
plot(u,v,'--')
% xlim([-3.5, 3.5]);
% ylim([-3.5, 3.5]);

xlim([-2, 2]);
ylim([-2, 2]);

% Circle
r=1;
h = 0;
k = 0;
teta= 0:0.01:2*pi;
w= h + r*cos(teta);
z= k + r*sin(teta);
plot(w,z,'g--')

% Axes
% y1 = -3.2:0.01:3.2;
y1 = -1.5:0.01:1.5;
y2 = 0*y1;
plot(y1,y2,'b --')
plot(y2,y1,'b --')
hold off



% % % % % % % % % % % % % % % % % % % 
figure
teta= 0:0.01:2*pi;
u= cos(teta);
v= rho*sin(teta);
plot(u,v,'LineWidth', 2)
xlim([-4, 4]);
ylim([-4, 4]);
grid on
xlabel('x_1')
ylabel('x_2')

hold on
r=1;
h = 0;
k = 0;
teta= 0:0.01:2*pi;
x1= h + r*cos(teta);
x2= k + r*sin(teta);
plot(x1,x2,'r--','LineWidth', 2)

plot(1,0, 'g*','LineWidth', 2)
plot(0,rho, 'g*','LineWidth', 2)
plot(-1,0, 'g*','LineWidth', 2)
plot(0,-rho, 'g*','LineWidth', 2)

u1 = -3.5:0.01:3.5;
v1 = 0*u1;
plot(u1,v1)
plot(v1,u1)

hold off

