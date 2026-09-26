function [coeff] = qubicSplineInterpolation(x,y)
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
    szx = size(x) % number of x entries of the dataset
    szy = size(y) % number of y entries ot the dataset
    if szx(1) ~= szy(1)
        disp("invalid set of datapoints");
        return
    end
    
    %% Initialisation
    n = szy(1); % number of equations = number of datapoints -1
    
    % construct H
    % compute hi
    %h = ones(n,1);
    for j = 1:n-1
        h(j) = x(j+1)-x(j);
    end
    h = h';
    %h = x(2:end)-x(1:end-1) % does also work
    H = diag(h(1:end-1)); % main diagonal h: first to second last
    H = H + diag(h(2:end)); % main diagonal h: second to last
    D1 = diag(h(1:end-2),-1); % sub diagonal 
    D2 = diag(h(2:end-1),1); % upper diagonal 
    H = H + D1 + D2; % put togehter
    M = diag(h(1:end-2),-1)+diag(h(1:end-1)+h(2:end))+diag(h(2:end-1),1);
    
    % Construct A to solve Ac = y
    A = zeros(n);
    A(2:end-1,2:end-1) = H; % "put H in the middle of C; (2,2) to (end-1;end-1)
    A(2,1) = h(1);
    A(1,1) = 1; % c0 = 0
    A(end,:) = [zeros(1,n-2), h(end-1), 2*(h(end-1)+h(end))]; % last row: n-2: all zeros, second last: h(end-1), last: 2* h + h...
    A = A./3;
    
    % Construct y vector
    b = ((y(3:end)-y(2:end-1))./h(2:end)) - ((y(2:end-1)-y(1:end-2))./h(1:end-1));
    b = [0; b ;0]; % add zero on top and bottom of b
    
    % Compute ci coefficients
    c = A\b;
    
    % Compute di coefficients
    d = (1/3).*(c(2:end)-c(1:end-1))./(h);
    
    % Computing bi
    b = (y(2:end)-y(1:end-1)-c(1:end-1).*h.^2-d.*h.^3)./h;
    
    %% Defining the coefficient matrix
    coeff = [d, c(1:end-1), b, y(1:end-1)];
    
    %% Plotting
%     pp = mkpp(x,coeff);
%     xq = x(1):0.01:x(end);   
%     plot(xq,ppval(pp,xq),x,y,'x');
end  

    
