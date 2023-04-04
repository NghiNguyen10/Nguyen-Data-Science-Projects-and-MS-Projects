function [ res_map ] = likelihood_field_gen( map,var )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[m,n]=size(map);
dist_mer=nan(m*n,1);
% coor=zeros(m*n,2);
res_map=zeros(m,n);
[x,y]=find(map==0);
i=1;
tic;
if var==1
    zhit=2.51;
elseif var==2
    zhit=10;
else
    zhit=7.52;
end;
    
while(i<=m)
    j=1;
    while (j<=n)
        dist_mer(:,:)=nan;
        dist=sqrt((x-i).^2 + (y-j).^2);
        dist_min=min(dist);
        res_map(i,j)=zhit*prob(dist_min,var);
        j=j+1;
    end
    i=i+1;
end
toc;
end

