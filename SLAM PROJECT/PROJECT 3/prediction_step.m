function [x, P] = prediction_step(x,P,u,Q,dt)

H = 0.75;
L = 2.83;
a = L + 0.95;
b = 0.5;

% x = [x(1);x(2);x(3)];
% u = [u(1); u(2)];

eta = dt/(1-H/L*tan(u(2)));
A = (a*sin(x(3)) + b*cos(x(3)))*1/L;
B = (a*cos(x(3)) - b*sin(x(3)))*1/L;

eta_dot = (dt*H/L*(sec(u(2)))^2)/(1-H/L*(tan(u(2)))^2);

% A_dot = (a*cos(x(3)) - b*sin(x(3))*1/L = B;
% B_dot = -(a*sin(x(3)) + b*cos(x(3)))*1/L = -A;

g = [x(1) + eta*u(1)*(cos(x(3)) - A*tan(u(2)));
     x(2) + eta*u(1)*(sin(x(3)) + B*tan(u(2)));
     x(3) + 1/L*eta*u(1)*tan(u(2))];
 
G_x = [1 0 u(1)*eta*(-sin(x(3)) - B*tan(u(2)));
       0 1 u(1)*eta*(cos(x(3)) - A*tan(u(2)));
       0 0 1];
                
G_u = [eta*(cos(x(3))-A*tan(u(2))) u(1)*eta_dot*(cos(x(3)) - A*tan(u(2))) - u(1)*eta*A*(sec(u(2)))^2;
       eta*(sin(x(3)) + B*tan(u(2))) u(1)*eta_dot*(sin(x(3)) + B*tan(u(2))) + u(1)*eta*B*(sec(u(2)))^2;
       1/L*eta*tan(u(2)) 1/L*u(1)*eta_dot*tan(u(2)) + 1/L*u(1)*eta*(sec(u(2)))^2];

x = g;
P = G_x*P*(G_x)' + G_u*Q*(G_u)'; 
  
end