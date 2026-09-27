function [y_eval] = lagrangianInterpolation(x,y,xeval)
%   Lagrangian interpolation method to compute y values for a given set
%   x for a interpolated function given by a dataset
%   
%   Input:
%           x        : x values of the dataset
%           y        : y values of the dataset
%           xeval    : x values for he new 
%
%   Output:
%           y_eval   : vector containing all the new computed y values that
%                      corresponds to the xeval values
    
    %% Sanity check of  the dataset
    szx = size(x); % number of x entries of the dataset
    szy = size(y); % number of y entries ot the dataset
    if szx(1) ~= szy(1)
        disp("invalid set of datapoints");
        return
    end
    
    %% Initialisation
    n = szy(1); % number of datapoints
    sz = size(xeval); % number of points that need to be evaluated
    
    %% Computation
    for m = 1:sz(1) % compute every new y value for the provided x values
        y_eval(m) = 0; % init new y value
        for k = 1:n % compute sum of all L_k's
            L_k = 1; % init Lagrangian Polynom L_k
            for j = 1:n % compute Lagrangian weight
                if j ~= k
                    L_k = L_k .* ((xeval(m)-x(j))./(x(k)-x(j)));
                end
            end
            y_eval(m) = y_eval(m) + y(k).* L_k;
        end
    end
end  

    
