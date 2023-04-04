%
%   EE6900 Simultaneous Localization and Mapping (SLAM) for Robotics
%
%   State-transition function based on motion platform model
%   and control action input
%
%   Inputs:     x   -   state vector
%               P   -   state covariance
%               u   -   [speed, steering command]
%               Q   -   actions covariance matrix
%               dt  -   time interval of prediction
%               WB  -   wheel base
%
%   Outputs:    x   -   state vector
%               P   -   covariance matrix
%
%   See: "Autonomous Navigation and Map building Using Laser Range Sensors 
%       in Outdoor Applications," by Jose Guivant, Eduardo Nebot and Stephan Baiker
%
%   Copyright (c) 2015 OU-EECS-AEC-MUdH
%
function [x, P] = prediction_step(x,P,u,Q,dt)
  
    % Local defintions
    H = 0.75;
    L = 2.83;
    b = 0.5;
    a = L + 0.95;
   
    % Extract steering commands
    ve = u(1);
    alpha = u(2);
    
    %vc = ve/(1 - tan(alpha)*H/L);
    ds = u(1)*L*dt/(L - tan(u(2))*H);   % vc*dt;
    vcL = u(1)*dt/(L - tan(u(2))*H); %ds/L;
    
    cosx = cos(x(3));
    sinx = sin(x(3));
    cosa = cos(u(2));
    tana = tan(u(2));
    
    ddsdu1 = dt/(1 - tan(u(2))*H/L);
    dvcLdu1 = dt/(L - tan(u(2))*H);
    dtanadu2 = 1.0/(cosa^2);
    dvcLdu2 = u(1)*H*dtanadu2/(L - tan(u(2))*H)^2;
    ddsdu2 = L*dvcLdu2;
    
    
    % Perform state prediction 'g'
    x(1:3) = [x(1) + ds*cosx - vcL*tana*(a*sinx + b*cosx); 
              x(2) + ds*sinx + vcL*tana*(a*cosx - b*sinx);
              x(3) + vcL*tana];
    
    x(3) = pi_to_pi(x(3));
    
%     x(1:3) = [x(1) + u(1)*dt*cos(u(2)+x(3)); 
%               x(2) + u(1)*dt*sin(u(2)+x(3));
%      pi_to_pi(x(3) + u(1)*dt*sin(u(2))/L)];
 
    % Jacobian w.r.t. pose  [dg1/dx, dg1/dy, dg1/dtheta; dg2/dx ... etc  
    Gx = [ 1 0 -ds*sinx - vcL*tana*(a*cosx - b*sinx);
           0 1  ds*cosx + vcL*tana*(-a*sinx - b*cosx);
           0 0  1];
           
    % Jacobian w.r.t. action  [dg1/du1, etc. 
    Gu= [ddsdu1*cosx - dvcLdu1*tana*(a*sinx + b*cosx),   ddsdu2*cosx - dvcLdu2*tana*(a*sinx + b*cosx) - vcL*dtanadu2*(a*sinx + b*cosx);
         ddsdu1*sinx + dvcLdu1*tana*(a*cosx - b*sinx),  ddsdu2*sinx + dvcLdu2*tana*(a*cosx - b*sinx) + vcL*dtanadu2*(a*cosx - b*sinx);
         dvcLdu1*tana,    dvcLdu2*tana + vcL*dtanadu2 ];
 
%     Gu= [dt*cos(u(2)+x(3)) -u(1)*dt*sin(u(2)+x(3));
%          dt*sin(u(2)+x(3))  u(1)*dt*cos(u(2)+x(3));
%          dt*sin(u(2))/WB    u(1)*dt*cos(u(2))/WB];
%  
    % Perform covariance prediction
    P(1:3,1:3)= Gx*P(1:3,1:3)*Gx' + Gu*Q*Gu';
    if size(P,1)>3
        P(1:3,4:end)= Gx*P(1:3,4:end);
        P(4:end,1:3)= P(1:3,4:end)';
    end    

end
