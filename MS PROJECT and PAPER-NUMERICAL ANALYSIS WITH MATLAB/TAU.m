% clear all
% clc
% close all

s = rng;
Delta = 3.5 - randi(3,1,10)
rng(s);
Delta = 3.5 - randi(3,1,10)
l = length(Delta);
t0 = 0;
Tau(1) = t0;
for j = 2:l+1
    T = Tau(j-1) + Delta(j-1);
    Tau(j) = T;
end
Tau