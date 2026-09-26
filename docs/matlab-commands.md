# Useful Matlab Commands

## Funktion definieren
f = @(x) x^2;\
f(5) % ans = 25

## Funktion in mehreren Positionen auswerten
f = @(x) exp(-25.*x.^2);\
x = [-1.0, -0.75, -0.5, -0.25, 0]\
x2 = linspace(-1,0,5) % ist das gleiche\
y = f(x)

## Funktion interpolieren (Grad 4) und plotten
x = [-55 -25 5 35 65];\
y = [-3.25 -3.2 -3.02 -3.32 -3.1];\
c=polyfit(x,y,4) 			% c = [coeff x^4, coeff x^3, coeff x^2, coeff x^1, coeff x^0]\
z=linspace(x(1),x(end),100); 		% generates 100 equidistrubuted between -55 and 65\
p=polyval(c,z); 			% evaluate the polynom (coeff c) with all the points in z\
plot(z,p,x,y,'o'); 			% z,p -> graph; x,y -> points

## Funktion ableiten (ist f dann function handle? Eher nicht nutzten)
syms x;\
fun = @(x) x^3-3.*x^2-x+3;\
f = x^3-3.*x^2-x+3;\
diff(f)\

## e Schreibweise:
tolerance = 5*10^(-10);\
tolerance = 5e-10\

## Generate Matrices (Zeile zuerst |, Spalte später->)
V = zeros(n,n+1) % init n * n+1 matrix full of "0"\
M = ones(n+1,n)  % init n+1 * n matrix full of "1"

## Matrix Indices
q = A(:,n) %is the n-th column of matrix A.\
r = A(m,:) %is the m-th row of matrix A.

## Calculate h from x vector:
h = nodes(2:end)-nodes(1:end-1); % x2-x1, x3-x2, x4-x3, ...

## Matrix Add row
a = [1 2 3 ; 4 5 6; 7 8 9];\
b=[5 5 5]\
c=[a;b] % add one row\
a=a(:,1:end-1) % remove last column

## Flip Vector indices
A = [1;2;3];\
B = flip(A) % B = [3;2;1]

## Plot Datapoints
x = [-9;-4;-1;7]\
y = [5;2;-2;9]\
plot(x,y,'o')

## Evalute Polynom in specific points
p = [3 2 1]; % polynom 3*x^2 + 2*x^1 + 1*x^0 = 3*x^2 + 2*x + 1\
x = [5 7 9]; % points\
y = polyval(p,x)\
% return 86   162   262

## Chebyshev-Nodes
% Set interval [-5,5]\
a = -5\
b = 5
xc = -cos(pi*[0:n]/n); % calculate plain nodes\
x = (a+b)*0.5+(b-a)*xc*0.5; % linear transformation\
% Generate interpolation polynom\
f= '1./(1+x^2)'; % Runge function\
y = eval(f);\
c = polyfit(x,y,n);\
% Error\
x = linspace(-5,5,1000);\
p=polyval(c,x);\
fx = eval(f);\
err = max(abs(p-fx));

## Piecewise linear Interpolation
x = [3;4.5;7;9];    % dataset\
y = [2.5;1;2.5;0.5];    % dataset\
xeval = [5,6,7]; % where to evaluate\
yeva = interp1(x,y,xeval);

## Plot piecewise polynom
pp = mkpp(breaks,coefs)

## Evaluate the piecewise polynomial pp at the query points xq
v = ppval(pp,xq)

## Spline\
x = [ -55:10:65];\
y = [ -3.25 -3.37 -3.35 -3.2 -3.12 -3.02 -3.02 -3.07 -3.17 -3.32 -3.3 -3.22 -3.1];\
zi = [ -55:1:65];\
s = spline(x,y,zi);

## Qubic Spline interpolation and Plot
xsp = [-55:10:65];\
ysp = [-3.25 -3.37 -3.35 -3.2 -3.12 -3.02 -3.02 -3.07 -3.17 -3.32 -3.3 -3.22 -3.1];\
zsp = [-55:1:65];\
s = spline(xsp,ysp,zsp);\
plot(xsp,ysp,'o',zsp,s)

## Evaluate the polynomial p at each point in x
y = polyval(p,x)

## LU-Decomposition
[L,U,P]=lu(A) % does always permutation by rows,\
[L,U]=lu(A) %L is actually PL,\
[L,U,P,Q]=lu(A) %does total pivoting

## Put diag toghether
D = 2.04 .* ones(n,1); % main diag\
D1 = (-1).* ones(n-1,1); % sub diag\
A = diag(D)+diag(D1,-1)+diag(D1,+1);

## Plot 2 Graphs
hold on\
plot(h,y1,'rx-');\
plot(h,y2,'b*--');\
hold off\
title('Erros of two algebraic identical functions', 'Interpreter', 'latex');\
xlabel('$x, 10^{-16}<=x<=10^{-1}$', 'Interpreter', 'latex');\
ylabel('y = f(x)');\
legend('f1 using cosine','f2 using sine');\
axis([-0.02 0.12 0 0.60])
