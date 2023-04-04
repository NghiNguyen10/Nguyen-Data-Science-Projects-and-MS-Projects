function [ occupancy_grid ] = gen_occu_grid( east_corr, north_corr, resolution )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if resolution == 1
    east_corr = ceil(east_corr);
    north_corr = ceil(north_corr);
end
x=abs(min(min(east_corr)))+abs(max(max(east_corr)))+5;
y=(abs(min(min(north_corr)))+abs(max(max(north_corr))))+5;
occupancy_grid=zeros(x,y);
dim=size(east_corr);
tic;
for i=1:dim(1,2)
    for j= 1:dim(1,1)
        if(isnan(north_corr(j,i))) && (isnan(east_corr(j,i))) 
        else
            l = east_corr(j,i)+ abs(min(min(east_corr)))+1;
            m = north_corr(j,i)+ abs(min(min(north_corr)))+1;
            occupancy_grid(l,m)=occupancy_grid(l,m) + 1;
        end
    end;
end
toc
dim=size(occupancy_grid);    
for i=1:dim(1,1)
    for j=1:dim(1,2)
        if occupancy_grid(i,j)> 30
            occupancy_grid(i,j) = 0;
        else
             occupancy_grid(i,j)= 255;
        end
    end
end

end

