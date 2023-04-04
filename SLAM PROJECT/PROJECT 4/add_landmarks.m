%
%   EE690 Self Localization and Mapping (SLAM) for Robotics
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
%   Copyright (c) 2012 OU-EECS-AEC-MUdH
%
function [x, P]= add_landmarks(x,P,z,R,cor)

    % Local defintions
    H = 0.75;
    L = 2.83;
    b = 0.5;
    a = L + 0.95;
    
    ct = cos(x(3));
    st = sin(x(3));
    
    % Add all the new measurements
    for ii=1:length(cor),
        
        % Un-associated feature/landmark
        if(cor(ii) < 0.0),
           
            len = length(x);
            sb = sin(z(2,ii)); 
            cb = cos(z(2,ii));
            rho = z(1,ii);

            % Compute the initial marker location
            m = [  x(1) + rho*sb*ct + rho*cb*st; ...
                   x(2) + rho*sb*st - rho*cb*ct];
                  
            % Index range
            rng = len+1:len+2;
            
            % augment x
            x(rng) = m;
            
            % Jacobian wrt pose
            Gx = [ 1 0 -rho*sb*st + rho*cb*ct;
                   0 1  rho*sb*ct + rho*cb*st];
            
            % Jacobian wrt pose
            Gz = [sb*ct+cb*st rho*cb*ct-rho*sb*st;
                  sb*st-cb*ct rho*cb*st+rho*sb*ct];
 
            % Augment P
            P(rng,rng)= Gx*P(1:3,1:3)*Gx' + Gz*R*Gz'; % feature cov
            P(rng,1:3)= Gx*P(1:3,1:3); % vehicle to feature xcorr
            P(1:3,rng)= P(rng,1:3)';
            if len > 3
                rnm = 4:len;
                P(rng,rnm)= Gx*P(1:3,rnm); % map to feature xcorr
                P(rnm,rng)= P(rng,rnm)';  
            end
            
        end
        
    end
end
