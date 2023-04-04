function [ grid ] = occ_grid_func( east_corr, north_corr, resolution )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% 

[r,w]= size(east_corr);
x_prime = reshape(east_corr, r*w,1); 
y_prime = reshape(north_corr, r*w,1);

grid_dimention=[min(min(east_corr)) min(min(north_corr)) 
                max(max(east_corr)) max(max(north_corr))]; 
grid_dimention = ceil(grid_dimention)/resolution;
            
grid = zeros(grid_dimention(2,1)- grid_dimention(1,1), grid_dimention(2,2)- grid_dimention(1,2));

x_prime=ceil((x_prime - min(min(east_corr))+1)/resolution);

y_prime=ceil((y_prime - min(min(north_corr))+1)/resolution);
x_prime(isnan(x_prime))= 1;
y_prime(isnan(y_prime))= 1;

i=399*1440;
tic;
while(i~=0)
grid(x_prime((399*1440)-i+1 ,1),y_prime((399*1440)-i+1,1)) = 255;
i=i-1;
end
toc;
grid=255 - rot90(grid);
end

