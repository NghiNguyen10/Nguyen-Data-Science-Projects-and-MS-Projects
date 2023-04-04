clc;
clear all;
close all;
load('laserdata.mat')

%grid = gen_occu_grid (peastSICK, pnorthSICK, 1);
[grid_1] = occ_grid_func (peastSICK, pnorthSICK, 1); 
imshow(grid_1);
title('Occupancy grid with 1m resolution'); 
[grid_0_5] = occ_grid_func (peastSICK, pnorthSICK, 0.5);
figure;
imshow(grid_0_5);
title('Occupancy grid with 0.5m resolution');  
[grid_0_2] = occ_grid_func (peastSICK, pnorthSICK, 0.2);
figure;
imshow(grid_0_2);
title('Occupancy grid with 0.2m resolution');  
[grid_0_1] = occ_grid_func (peastSICK, pnorthSICK, 0.1);
figure; 
imshow(grid_0_1);
title('Occupancy grid with 0.1m resolution'); 
[grid_0_0_5] = occ_grid_func (peastSICK, pnorthSICK, 0.05);
figure;
imshow(grid_0_0_5);
title('Occupancy grid with 0.05m resolution');  
%
for var=1:3
likelihood = likelihood_field_gen(grid_1./255,var );
figure;
imshow(likelihood);
end
for var=1:3
likelihood = likelihood_field_gen(grid_0_5./255,var );
figure;
imshow(likelihood);
end
% %for further expansion
% likelihood = likelihood_field_gen(grid_0_2./255,1 );
% figure;
% imshow(likelihood);
% likelihood = likelihood_field_gen(grid_0_1./255,1 );
% figure;
% imshow(likelihood);
% likelihood = likelihood_field_gen(grid_0_0_5./255,1 );
% figure;
% imshow(likelihood);