function [x,it] = modifiedNewtonMethod(fun, dfun, x0, m, itMax, eps)
%   Implementation of the Newton Method to find multiple roots
%   Issues: dfun(x^k) = 0; multiple roots
%   
%   Input:
%           fun          : function that we want to find a root
%           dfun         : first derivative of fun
%           x0           : initial guess
%           m            : multiplicity (order of the root)
%           itMax        : maximal number of iterations
%           eps          : tolerance
%
%   Output:
%           x            : found root
%           it           : number of performed iterations

   %% Initialisation
    % check, we might are lucky
    it = 0;
    if abs(fun(x0) - 1e-12) < eps
        x = x0;
        return 
    end
    %% Procedure
    while (it < itMax) && (abs(fun(x0) - 1e-12) > eps)
        x0 = x0 - m*(fun(x0)/dfun(x0));
        it = it+1;
    end
    x = x0;

end