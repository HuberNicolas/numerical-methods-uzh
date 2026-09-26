function [I] = compositeSimpsonFormula(fun,a,b,n)
%   Composite method of the simpson integration formula
%   
%   Input:
%           fun      : to be integrated function
%           a        : lower x value of the integral
%           b        : upper x value of the intergral
%           n        : number of steps
%
%   Output:
%           I        : value of the integral of f(x) between a and b
%

    %% Initialisation
    h = (b-a)/n; % stepwidth
    xk = linspace(a,b,n+1); % generate n intervals between a and b with width = h
    sum = 0;
    
    %% Computation 
    for j = 1:length(xk)-1
        xm = (xk(j)+xk(j+1))./2; % midpoint of interval j
        sum = sum + fun(xk(j)) + 4*fun(xm) + fun(xk(j+1));
    end
    I = (h/6)* sum;
   
end