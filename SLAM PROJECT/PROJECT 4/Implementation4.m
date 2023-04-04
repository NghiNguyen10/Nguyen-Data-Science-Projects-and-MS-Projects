%  
%   EE6900 Simultaneous Localization and Mapping (SLAM) for Robotics
%
%   Project #4 - Nghi Nguyen
%
%   Clean environment

clear all
close all
clc

%   Load data
FileName = 'LaserData02'; % 'aa3_lsr2.mat' ;
load(FileName);

FileName = 'aa3_dr.mat' ;
load(FileName);

FileName = 'aa3_gpsx.mat' ;
load(FileName);

% Control/action noise parameters
sigmaV = 0.05; %m/s
sigmaG = (3.0*pi/180); % radians
Q = [sigmaV^2 0; 0 sigmaG^2];

% Observation noises
sigmaR = 0.4; % metres
sigmaB = (6*pi/180); % radians
R = [sigmaR^2 0; 0 sigmaB^2];

%   Wheel base
WB = 2.83;  % L in the drawing

% ----------------------------------------------------------------------
% Perform EKF SLAM
% ----------------------------------------------------------------------
x = [0; 0; atan2(Lo_m(2)-Lo_m(1),La_m(2)-La_m(1))];
P = eye(3);

index = 1;
h = waitbar(0,'Please wait...');
for ii=1:7100,
   
    % Extract the current and next time epochs
    tCurrent    = time(ii)/1000.0;
    tNext       = time(ii+1)/1000.0;
    
    % Extract robot "action"
    u(1) = speed(ii);
    u(2) = steering(ii);
    
    % Find out if there is a laser measurement between the current and the
    % enxt time epochs
    ind = find( (timeLaser>tCurrent) & (timeLaser<=tNext) );
    
    % If not, predict only
    if isempty(ind),
   
        % Compute time interval
        dt = tNext - tCurrent;
        
        % Perform prediction step
        [x, P] = prediction_step(x,P,u,Q,dt);
        
    % Else, perform EKF SLAM steps
    else
              
        % Extract landmark observations as obtained from the laser
        % measurements
        z = [xyLaser{ind}.r; xyLaser{ind}.phi];
        
        % Number of observed landmarks
        L = length(xyLaser{ind}.r);
        
        % Initialize the correspondence vector
        c = zeros(1,L);
        
        % Perform data associations with the map
        c = data_association_step(x,P,z,R);
        
        % Update step of the EKF
        [x,P] = update_step(x,P,z,R,c);
        xout(:,index) = x(1:3);
        index = index + 1;
        
        % Add new landmarks
        [x,P] = add_landmarks(x,P,z,R,c);
        
        % Compute time interval
        dt = tNext - tCurrent;
        
        % Perform prediction step
        [x, P] = prediction_step(x,P,u,Q,dt);
                
    end
    
    xout(:,ii) = x(1:3);
    waitbar(ii/length(time),h);
end

close(h);

% Find corresponding GPS measurements
jj = find( (timeGps < time(ii)) & (timeGps > time(1)) );

% Extract the landmarks
m = x(4:length(x));
indx = 1:2:length(m);
indy = 2:2:length(m);
mx = m(indx);
my = m(indy);

% New figure
figure(2)

% Plot EKF SLAM solution
plot(xout(1,:)+La_m(jj(1)),xout(2,:)-Lo_m(jj(1)),'.'); grid on; hold on
xlabel('x [m]','FontSize',12,'FontWeight','bold');
ylabel('y [m]','FontSize',12,'FontWeight','bold');
title('Estimated Trajectory using EKF-SLAM (blue) and Stand-alone GPS (red)','FontSize',12,'FontWeight','bold');

% Plot GPS solution
plot(La_m(jj), -Lo_m(jj),'r.');

% Plot the landmarks
plot(mx+La_m(jj(1)),my-Lo_m(jj(1)),'m*'); 

