function [S] = quadraticSplineInterpolation(x,y)
%   Piecewise polynomial interpolation method (quadratic splines) (page 9)
%   
%   Input:
%           x        : x values of the dataset
%           y        : y values of the dataset
%
%   Output:
%           S        : matrix, that contains the coefficients for the si
%                      polynoms ((x-xi) form)
    
    %% Sanity check of  the dataset
    szx = size(x); % number of x entries of the dataset
    szy = size(y); % number of y entries ot the dataset
    if szx(1) ~= szy(1)
        disp("invalid set of datapoints");
        return
    end
    
    %% Initialisation
    n = szy(1)-1; % number of equations = number of datapoints -1

    % compute hi
    h = ones(n,1);
    for j = 1:n
        h(j) = x(j+1)-x(j);
    end
    % create H
    H = diag(h); % main diagonal
    D1 = diag(h,-1); % sub diagonal
    D1 = D1(:,1:end-1); % delete last column
    D1 = D1(1:end-1,:); % delete last row
    H = H + D1;
    
    % create a, x^0 coeff
    a = y(1:end-1); % delete last row
    
    % create c, x^2 coeff
    c(1) = 0; % c0 = 0
    for j = 1:n-1
        cj = ( (y(j+2)-y(j+1))./ (h(j+1).*h(j+1)) ) - ( (y(j+1)-y(j)) ./ (h(j).*h(j+1)) );
        c = [c;cj] ;
    end
    %c = c
    
    % compute b, x^1 coeff
    b = [];
    for j = 1:n
        bj = ( y(j+1)-y(j)) ./ (h(j)) - (c(j).*h(j) );
        b = [b;bj]; 
    end
    %b = b
    S = [c b a];
    
    %% Plotting
    pp = mkpp(x,S);
    xq = x(1):0.01:x(end);   
    plot(xq,ppval(pp,xq),x,y,'x');
end  

    
