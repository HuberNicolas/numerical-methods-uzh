# MATLAB functions used in the course

Built-in functions that the course relied on, with a short description. The chapter implementations in this
repository re-implement several of them; the tests compare against these built-ins.

## Roots

```matlab
r = roots(p) % roots of the polynomial p as a column vector
```

## Interpolation

```matlab
vq1 = interp1(x,v,xq);          % linear interpolation (default)
vq2 = interp1(x,v,xq,'spline'); % spline interpolation

s = spline(x,y,xq)      % interpolated values s at the query points xq
pp = spline(x,y)        % piecewise polynomial structure for ppval and unmkpp
pp = mkpp(breaks,coefs) % piecewise polynomial from its breaks and coefficients
p = polyfit(x,y,n)      % coefficients of the polynomial of degree n that best fits y (least squares)

y = polyval(p,x) % evaluates the polynomial p (coefficients in descending powers) at each point in x
v = ppval(pp,xq) % evaluates the piecewise polynomial pp at the query points xq

C = cond(A)     % 2-norm condition number: ratio of the largest to the smallest singular value of A
w = conv(u,v)   % convolution of u and v (= product of two polynomials)
k = polyder(p)  % derivative of the polynomial p
```

## Decompositions

```matlab
[L,U,P] = lu(A)   % permutation of rows
[L,U] = lu(A)     % L is actually PL
[L,U,P,Q] = lu(A) % row and column permutation (sparse A only)
R = chol(A)       % symmetric positive definite A = R'*R, R upper triangular
[Q,R] = qr(A)     % A = Q*R for an m-by-n matrix A
```

## Matrices

### Triangular

```matlab
U = triu(A,k) % elements on and above the k-th diagonal of A
U = triu(A)   % upper triangular part of A
L = tril(A)   % lower triangular part of A
L = tril(A,k) % elements on and below the k-th diagonal of A
```

### Diagonal

```matlab
D = diag(v)   % square matrix with v on the main diagonal
D = diag(v,k) % v on the k-th diagonal: k = 0 main, k > 0 above, k < 0 below
x = diag(A)   % main diagonal of A as a column vector
x = diag(A,k) % k-th diagonal of A as a column vector
```

### Sparse

```matlab
spy(S)            % plots the sparsity pattern of S
N = nnz(X)        % number of nonzero elements in X
S = sparse(A)     % converts a full matrix to sparse form
v = nonzeros(A)   % nonzero elements of A as a column vector, ordered by columns
Bout = spdiags(A) % nonzero diagonals of A as the columns of Bout
```
