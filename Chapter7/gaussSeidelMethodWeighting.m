function [x,it] = gaussSeidelMethodWeighting(A,b,x0,itMax,eps,w)
%   Using the Gauss-Seidel method with weight w to iteratively solve the linear system Ax = b
%   % SOR if 1 < w < 2
%
%   Input:
%           A        : square matrix A (no zero elements on diagonal)
%           b        : right side b of the system Ax = b
%           x0       : initial guess
%           itMax    : maximal number of iterations
%           eps      : tolerance
%           w        : weight omega ( 0 < w < 2)
%
%   Output:
%           x        : computed x
%           it       : number of iterations
%

    
    % not needed just to print iteration matrix B
    diag(A);
    D = diag(diag(A));
    B = D^(-1)*(D-A); % Iteration matrix
    %% Initialisation
    
    it = 1;
    n = length(x0);
    x = x0; % copy
    % Residual & Error
    r = b-A*x0; % definitaion of residual
    r0 = norm(r);
    err = r0;
    %% Computation
    while it < itMax && err > eps
        for j = 1 : n % caculate all compoenets of x^(k+1)
            % sum j = 1 to n (j~=n) from a(i,j)*x(j)
            sum = 0;
            for k = 1:n
                if j ~= k % skip x1 in first equation, x2 in second, ...
                    sum = sum + x(k).*A(j,k);
                end
            end
            x(j) =  (1-w)*x(j) +  ((w ./ A(j,j)) .* (b(j) - sum));

        end
        % Compute new residual & error
        r = b - A * x;
        err = norm(r) / r0;
        it = it + 1;
    end
end  

    
