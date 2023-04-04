function [ probability ] = prob( distance, variance )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
probability=(1/(sqrt(2*pi*variance^2)))*exp(-(1/2)*(distance^2/variance^2));

end

