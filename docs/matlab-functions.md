# Basic Matlab Syntax

## Roots
r = roots(p) % returns the roots of the polynomial represented by p as a column vector.

## Interpolations
vq1 = interp1(x,v,xq);          % default linear interpolation\
vq2 = interp1(x,v,xq,'spline'); % spline interpolation

s = spline(x,y,xq)      % returns a vector of interpolated values s corresponding to the query points in xq.\
pp = spline(x,y)        % returns a piecewise polynomial structure for use by ppval and the spline utility unmkpp.\
pp = mkpp(breaks,coefs) % builds a piecewise polynomial pp from its breaks and coefficients.\
p = polyfit(x,y,n)      % returns the coefficients for a polynomial p(x) of degree n that is a best fit (in a least-squares sense) for the data in y (Normal equation)

y = polyval(p,x) % evaluates the polynomial p at each point in x. The argument p is a vector of length n+1 whose elements are the coefficients (in descending powers) of an nth-degree polynomial\
v = ppval(pp,xq) % evaluates the piecewise polynomial pp at the query points xq.

C = cond(A)     % returns the 2-norm condition number for inversion, equal to the ratio of the largest singular value of A to the smallest.\
w = conv(u,v)   % returns the convolution of vectors u and v.\
k = polyder(p)  % returns the derivative of the polynomial represented by the coefficients in p

## Decompositions
[L,U,P] = lu(A)   % permutation by rows\
[L,U] = lu(A)     % L is acutally PL\
[L,U,P,Q] = lu(A) % does total pivoting\
R = chol(A)       % factorizes symmetric positive definite matrix A into an upper triangular R that satisfies A = R'*R\
[Q,R] = qr(A)     % performs a QR decomposition on m-by-n matrix A such that A = Q*R.

## Matrices
### Triagonal
U = triu(A,k) % returns the elements on and above the kth diagonal of A\
U = triu(A)   % returns the upper triangular portion of matrix A.\
L = tril(A)   % returns the lower triangular portion of matrix A.\
L = tril(A,k) % returns the elements on and below the kth diagonal of A.

### Diagonal
D = diag(v)   % returns a square diagonal matrix with the elements of vector v on the main diagonal\
D = diag(v,k) % places the elements of vector v on the kth diagonal. k=0 represents the main diagonal, k>0 is above the main diagonal, and k<0 is below the main diagonal.\
x = diag(A)   % returns a column vector of the main diagonal elements of A.\
x = diag(A,k) % returns a column vector of the elements on the kth diagonal of A.

### Sparse
spy(S)            % plots the sparsity pattern of matrix S.\
N = nnz(X)        % returns the number of nonzero elements in matrix X.\
S = sparse(A)     % converts a full matrix into sparse form by squeezing out any zero elements.\
v = nonzeros(A)   % returns a full column vector of the nonzero elements in A. The elements in v are ordered by columns.\
Bout = spdiags(A) % extracts the nonzero diagonals from m-by-n matrix A and returns them as the columns in min(m,n)-by-p matrix Bout, where p is the number of nonzero diagonals.
