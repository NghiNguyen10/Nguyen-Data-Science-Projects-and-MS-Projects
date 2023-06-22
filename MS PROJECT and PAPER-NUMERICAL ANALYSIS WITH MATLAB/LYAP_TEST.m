clear all
clc
close all
% CQLF calculations
%
%
A1 = [-2 1 0;
     0 -1 0;
     0 0 -1];
g1 = [1/2 1 -1;
        0 0 -1/2;
        0 1 0];
T  = [1 0 0; 0 0 1; 1 1 0];
  
  A = T\A1*T
  g = T\g1*T

  P1 = diag([1 16 8]);
  M1 = -A1'*P1 - P1*A1;
  R1 = P1 - g1'*P1*g1;
  
  P = T' * P1 * T
  M = T' * M1 * T;
  R = T' * R1 * T;
  
  EM = A'*P + P*A
  
  EN = g'*P*g - P
  
  