function [x,P] = add_landmarks(x,P,z,R,cor)

gm = [x(1) + z(1)*sin(z(2)+x(3));
      x(2) - z(1)*cos(z(2)+x(3))];

Gm_x = [1 0 -z(1)*cos(z(2)-(3));
        0 1 z(1)*sin(z(2)+x(3))];
    
Gm_z = [sin(z(2)+x(3)) z(1)*cos(z(2)+x(3));
        -cos(z(2)+x(3)) z(1)*sin(z(2)+x(3))];
    
x =[x gm];
% prediction_step(x,P,u,Q,dt);
Pxx = P; 

Pxm = Gm_x*Pxx;
Pmm = Gm_x*Pxx*Gm_x' + Gm_z*R*Gm_z';
Pmx = Gm_x*Pmm;

P = [Pxx Pxm;
     Pxm' Pmm];
end