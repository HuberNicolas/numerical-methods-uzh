%% Author
%{
    Nicolas Huber
    16-936-205
    BA Information Systems @ UZH, Switzerland
%}
%% About
%{
    Skript to investiagte the Lagrangian interpolation method.
    (normal & by using Barycentric weights)
%}

%% Clearing Workspace
clc; clear all; close all;

%% Initialisation
x = [-1;0;1;3];    % dataset
y = [1;3;-7;3];    % dataset
xeval = [1;2;3;4]; % where to evaluate
% number check: https://www.youtube.com/watch?v=9P3s0ULxxa0

% values from lecture
%x = [-9;-4;-1;7]
%y = [5;2;-2;9]


%% Computation
yeval1 = lagrangianInterpolation(x,y,xeval);
yeval2 = lagrangianInterpolationBarycentric(x,y,xeval);
yeval3 = monomialInterpolation(x,y,xeval);
%% Plotting
plot(xeval, yeval1,'ro',xeval,yeval2,'bx', xeval,yeval3,'g*')


%% Plotting