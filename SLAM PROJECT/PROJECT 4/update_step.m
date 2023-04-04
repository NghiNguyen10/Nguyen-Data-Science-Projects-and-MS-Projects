function [x,P] = update_step(x,P,z,R,cor)

S = H*P*H'+R;     % calculating the matrix S
K = P*H'*inv(S);  % calculating the matrix K

% finding the update mean
N = (length(x)-3)/2;

h = [];

for k=1:N;
    h = [ h;
          sqrt(x(1)-x(2*k+2))^2 + (x(2) - x(2*k+3))^2;
          atan((x(2)-x(2*k+3))/(x(1)-x(2*k+2)))-x(3)-(pi/2)]; 
end;

x = x + K*(z-h);
J = eye(K*H);
P = (J - K*H)*P;   

end
    