# Useful MATLAB commands

Snippets collected while working through the course. They run in MATLAB and, unless noted, in GNU Octave.

## Define a function

```matlab
f = @(x) x^2;
f(5) % ans = 25
```

## Evaluate a function at several points

```matlab
f = @(x) exp(-25.*x.^2);
x = [-1.0, -0.75, -0.5, -0.25, 0]
x2 = linspace(-1,0,5) % the same
y = f(x)
```

## Interpolate a function (degree 4) and plot it

```matlab
x = [-55 -25 5 35 65];
y = [-3.25 -3.2 -3.02 -3.32 -3.1];
c = polyfit(x,y,4)             % c = [coeff x^4, coeff x^3, coeff x^2, coeff x^1, coeff x^0]
z = linspace(x(1),x(end),100); % generates 100 equidistributed points between -55 and 65
p = polyval(c,z);              % evaluate the polynomial (coeff c) at all points in z
plot(z,p,x,y,'o');             % z,p -> graph; x,y -> points
```

## Differentiate a function

Needs the Symbolic Math Toolbox (MATLAB) or the `symbolic` package (Octave). The result is a symbolic expression,
not a function handle.

```matlab
syms x;
fun = @(x) x^3-3.*x^2-x+3;
f = x^3-3.*x^2-x+3;
diff(f)
```

## Scientific notation

```matlab
tolerance = 5*10^(-10);
tolerance = 5e-10
```

## Create matrices (rows first, then columns)

```matlab
V = zeros(n,n+1) % n x (n+1) matrix full of 0
M = ones(n+1,n)  % (n+1) x n matrix full of 1
```

## Matrix indices

```matlab
q = A(:,n) % n-th column of matrix A
r = A(m,:) % m-th row of matrix A
```

## Compute h from the x vector

```matlab
h = nodes(2:end)-nodes(1:end-1); % x2-x1, x3-x2, x4-x3, ...
```

## Add a row to a matrix

```matlab
a = [1 2 3; 4 5 6; 7 8 9];
b = [5 5 5]
c = [a;b]          % add one row
a = a(:,1:end-1)   % remove last column
```

## Flip a vector

```matlab
A = [1;2;3];
B = flip(A) % B = [3;2;1]
```

## Plot data points

```matlab
x = [-9;-4;-1;7]
y = [5;2;-2;9]
plot(x,y,'o')
```

## Evaluate a polynomial at given points

```matlab
p = [3 2 1]; % polynomial 3*x^2 + 2*x + 1
x = [5 7 9]; % points
y = polyval(p,x)
% returns 86   162   262
```

## Chebyshev nodes

```matlab
% interval [-5,5]
a = -5
b = 5
xc = -cos(pi*[0:n]/n);         % nodes on [-1,1]
x = (a+b)*0.5+(b-a)*xc*0.5;    % linear transformation to [a,b]
% interpolation polynomial
f = '1./(1+x^2)';              % Runge function
y = eval(f);
c = polyfit(x,y,n);
% error
x = linspace(-5,5,1000);
p = polyval(c,x);
fx = eval(f);
err = max(abs(p-fx));
```

## Piecewise linear interpolation

```matlab
x = [3;4.5;7;9];       % dataset
y = [2.5;1;2.5;0.5];   % dataset
xeval = [5,6,7];       % where to evaluate
yeval = interp1(x,y,xeval);
```

## Build a piecewise polynomial

```matlab
pp = mkpp(breaks,coefs)
```

## Evaluate the piecewise polynomial pp at the query points xq

```matlab
v = ppval(pp,xq)
```

## Spline

```matlab
x = [-55:10:65];
y = [-3.25 -3.37 -3.35 -3.2 -3.12 -3.02 -3.02 -3.07 -3.17 -3.32 -3.3 -3.22 -3.1];
zi = [-55:1:65];
s = spline(x,y,zi);
```

## Cubic spline interpolation and plot

```matlab
xsp = [-55:10:65];
ysp = [-3.25 -3.37 -3.35 -3.2 -3.12 -3.02 -3.02 -3.07 -3.17 -3.32 -3.3 -3.22 -3.1];
zsp = [-55:1:65];
s = spline(xsp,ysp,zsp);
plot(xsp,ysp,'o',zsp,s)
```

## Evaluate the polynomial p at each point in x

```matlab
y = polyval(p,x)
```

## LU decomposition

```matlab
[L,U,P] = lu(A)   % always permutes rows
[L,U] = lu(A)     % L is actually PL
[L,U,P,Q] = lu(A) % total pivoting (sparse A only)
```

## Build a tridiagonal matrix

```matlab
D = 2.04 .* ones(n,1);   % main diagonal
D1 = (-1).* ones(n-1,1); % sub- and superdiagonal
A = diag(D)+diag(D1,-1)+diag(D1,+1);
```

## Plot two graphs

```matlab
hold on
plot(h,y1,'rx-');
plot(h,y2,'b*--');
hold off
title('Errors of two algebraically identical functions', 'Interpreter', 'latex');
xlabel('$x, 10^{-16}<=x<=10^{-1}$', 'Interpreter', 'latex');
ylabel('y = f(x)');
legend('f1 using cosine','f2 using sine');
axis([-0.02 0.12 0 0.60])
```
