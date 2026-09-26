function runTests()
%   Checks every method against a known result or the built-in MATLAB/Octave
%   function. Works in MATLAB and GNU Octave. Exits with an error if a check fails.
%
%   Usage (from the repository root):
%           cd tests; runTests

    root = fileparts(fileparts(mfilename('fullpath')));
    for k = 2:9
        addpath(fullfile(root, sprintf('Chapter%d', k)));
    end
    set(0, 'defaultfigurevisible', 'off');

    failures = {};
    tests = {
        @testRootFinding
        @testInterpolation
        @testPiecewiseInterpolation
        @testLeastSquare
        @testDirectMethods
        @testIterativeMethods
        @testEigenvalues
        @testIntegration
    };
    for k = 1:numel(tests)
        failures = [failures, tests{k}()]; %#ok<AGROW>
    end
    close all;

    if isempty(failures)
        fprintf('\nAll checks passed.\n');
    else
        fprintf('\n%d check(s) failed:\n', numel(failures));
        fprintf('  - %s\n', failures{:});
        error('runTests:failed', '%d check(s) failed', numel(failures));
    end
end

%% Chapter 2: root finding
function failures = testRootFinding()
    failures = {};
    f = @(x) x.^2 - 2;
    df = @(x) 2*x;
    root = sqrt(2);

    x = quiet(@() bisectionMethod(f, 1, 2, 1000, 1e-10));
    failures = check(failures, 'bisectionMethod', abs(x - root) < 1e-8);

    x = quiet(@() newtonMethod(f, df, 1, 100, 1e-12));
    failures = check(failures, 'newtonMethod', abs(x - root) < 1e-10);

    x = quiet(@() secantMethod(f, 1, 2, 100, 1e-12));
    failures = check(failures, 'secantMethod', abs(x - root) < 1e-10);

    x = quiet(@() fixedPointIterationMethod(@(x) x - cos(x), @(x) cos(x), 1, 1000, 1e-12));
    failures = check(failures, 'fixedPointIterationMethod', abs(x - 0.739085133215161) < 1e-10);

    % double root at x = 1
    g = @(x) (x - 1).^2 .* (x + 2);
    dg = @(x) 2*(x - 1).*(x + 2) + (x - 1).^2;
    x = quiet(@() modifiedNewtonMethod(g, dg, 2, 2, 100, 1e-10));
    failures = check(failures, 'modifiedNewtonMethod', abs(x - 1) < 1e-6);
end

%% Chapter 3: polynomial interpolation
function failures = testInterpolation()
    failures = {};
    p = [1 -2 0 3];                 % x^3 - 2x^2 + 3
    x = [-1; 0; 1; 2];
    y = polyval(p, x);
    xeval = [-0.5; 0.5; 1.5];       % column vector: lagrangianInterpolation loops over rows
    yexact = polyval(p, xeval);

    yeval = quiet(@() lagrangianInterpolation(x, y, xeval));
    failures = check(failures, 'lagrangianInterpolation', max(abs(yeval(:) - yexact(:))) < 1e-12);

    yeval = quiet(@() lagrangianInterpolationBarycentric(x, y, xeval));
    failures = check(failures, 'lagrangianInterpolationBarycentric', max(abs(yeval(:) - yexact(:))) < 1e-12);

    yeval = quiet(@() monomialInterpolation(x, y, xeval));
    failures = check(failures, 'monomialInterpolation', max(abs(yeval(:) - yexact(:))) < 1e-12);
end

%% Chapter 4: piecewise interpolation and splines
function failures = testPiecewiseInterpolation()
    failures = {};
    x = [3; 4.5; 7; 9];
    y = [2.5; 1; 2.5; 0.5];
    xeval = [6, 9, 5, 7, 3];

    yeval = quiet(@() linearPiecewiseInterpolation(x, y, xeval));
    failures = check(failures, 'linearPiecewiseInterpolation', ...
        max(abs(yeval(:) - reshape(interp1(x, y, xeval), [], 1))) < 1e-12);

    % the splines have to interpolate the data at all nodes
    S = quiet(@() quadraticSplineInterpolation(x, y));
    failures = check(failures, 'quadraticSplineInterpolation', ...
        max(abs(ppval(mkpp(x, S), x) - y)) < 1e-12);

    % quadraticSplineInterpolation2 returns the coefficients in monomial form
    S = quiet(@() quadraticSplineInterpolation2(x, y));
    s = zeros(numel(x), 1);
    for j = 1:numel(x) - 1
        s(j) = polyval(S(j, :), x(j));
    end
    s(end) = polyval(S(end, :), x(end));
    failures = check(failures, 'quadraticSplineInterpolation2', max(abs(s - y)) < 1e-12);

    xs = linspace(0, 5, 20)';
    ys = xs.*cos(xs) - (xs - 2).^2 - 1;
    coeff = quiet(@() qubicSplineInterpolation(xs, ys));
    failures = check(failures, 'qubicSplineInterpolation', ...
        max(abs(ppval(mkpp(xs, coeff), xs) - ys)) < 1e-10);
end

%% Chapter 5: least squares
function failures = testLeastSquare()
    failures = {};
    x = (0:0.5:5)';
    y = sin(x) + 0.1*x.^2;
    C = quiet(@() leastSquare(x, y, 3));
    failures = check(failures, 'leastSquare', max(abs(C(:) - reshape(polyfit(x, y, 3), [], 1))) < 1e-8);
end

%% Chapter 6 and 7: direct methods for linear systems
function failures = testDirectMethods()
    failures = {};
    A = [4 -1 0 1; -1 4 -1 0; 0 -1 4 -1; 1 0 -1 4];   % symmetric positive definite
    b = [1; 2; 3; 4];
    xexact = A\b;

    L = tril(A);
    U = triu(A);
    x = quiet(@() forwardSubstitution(L, b));
    failures = check(failures, 'forwardSubstitution', norm(x - L\b) < 1e-12);
    x = quiet(@() backwardSubstitution(U, b));
    failures = check(failures, 'backwardSubstitution', norm(x - U\b) < 1e-12);

    [Ag, bg] = quiet(@() forwardGaussianElimination(A, b));
    failures = check(failures, 'forwardGaussianElimination', norm(triu(Ag)\bg - xexact) < 1e-12);
    [Ag, bg] = quiet(@() forwardGaussianEliminationU(A, b));
    failures = check(failures, 'forwardGaussianEliminationU', norm(Ag\bg - xexact) < 1e-12);

    [L, U] = quiet(@() LUFactorisationNonPivoting(A));
    failures = check(failures, 'LUFactorisationNonPivoting', norm(L*U - A) < 1e-12);

    LU = quiet(@() gaussLUFactorisation(A));
    L = tril(LU, -1) + eye(size(A));
    U = triu(LU);
    failures = check(failures, 'gaussLUFactorisation', norm(L*U - A) < 1e-12);

    R = quiet(@() choleskyFactorisation(A));
    failures = check(failures, 'choleskyFactorisation', norm(R'*R - A) < 1e-12);

    [Q, R] = quiet(@() QRFactorisation(A));
    failures = check(failures, 'QRFactorisation', norm(Q*R - A) < 1e-12);
    B = [1 2; 3 4; 5 6; 7 9];
    [Q, R] = quiet(@() QRFactorisationEconomic(B));
    failures = check(failures, 'QRFactorisationEconomic', norm(Q*R - B) < 1e-12);

    T = diag(2.04*ones(5, 1)) + diag(-ones(4, 1), -1) + diag(-ones(4, 1), 1);
    [L, U] = quiet(@() thomasFactorisation(T));
    failures = check(failures, 'thomasFactorisation', norm(L*U - T) < 1e-12);

    [L, U] = quiet(@() LUFactorisationNonPivotingSparse(T, 1, 1));
    failures = check(failures, 'LUFactorisationNonPivotingSparse', norm(L*U - T) < 1e-12);
end

%% Chapter 7: iterative methods for linear systems
function failures = testIterativeMethods()
    failures = {};
    A = [10 -1 2 0; -1 11 -1 3; 2 -1 10 -1; 0 3 -1 8];  % strictly diagonally dominant
    b = [6; 25; -11; 15];
    x0 = zeros(4, 1);
    xexact = A\b;

    x = quiet(@() jacobiMethod(A, b, x0, 1000, 1e-12));
    failures = check(failures, 'jacobiMethod', norm(x - xexact) < 1e-8);
    x = quiet(@() gaussSeidelMethod(A, b, x0, 1000, 1e-12));
    failures = check(failures, 'gaussSeidelMethod', norm(x - xexact) < 1e-8);
    x = quiet(@() gaussSeidelMethodWeighting(A, b, x0, 1000, 1e-12, 1.1));
    failures = check(failures, 'gaussSeidelMethodWeighting', norm(x - xexact) < 1e-8);
end

%% Chapter 8: eigenvalues
function failures = testEigenvalues()
    failures = {};
    A = [2 1 0; 1 3 1; 0 1 4];
    ev = sort(eig(A));
    x0 = ones(3, 1);

    lambda = quiet(@() powerMethod(A, x0, 1000, 1e-12));
    failures = check(failures, 'powerMethod', abs(lambda - ev(end)) < 1e-6);
    lambda = quiet(@() inversePowerMethod(A, x0, 1000, 1e-12));
    failures = check(failures, 'inversePowerMethod', abs(lambda - ev(1)) < 1e-6);
    lambda = quiet(@() inversePowerMethodShift(A, 3.2, x0, 1000, 1e-12));
    failures = check(failures, 'inversePowerMethodShift', abs(lambda - ev(2)) < 1e-6);
end

%% Chapter 9: numerical integration
function failures = testIntegration()
    failures = {};
    % degree of exactness: midpoint and trapezoidal 1, Simpson 3
    p1 = @(x) 3*x + 1;
    p3 = @(x) x.^3 - 2*x.^2 + 1;
    I1 = 3*2 + 2;                   % integral of p1 over [0, 2]
    I3 = 4 - 16/3 + 2;              % integral of p3 over [0, 2]

    failures = check(failures, 'midpointFormula', abs(quiet(@() midpointFormula(p1, 0, 2)) - I1) < 1e-12);
    failures = check(failures, 'trapezoidalFormula', abs(quiet(@() trapezoidalFormula(p1, 0, 2)) - I1) < 1e-12);
    failures = check(failures, 'simpsonFormula', abs(quiet(@() simpsonFormula(p3, 0, 2)) - I3) < 1e-12);

    f = @(x) exp(-x.^2);
    Iref = integral(f, 0, 1);
    failures = check(failures, 'compositeMidpointFormula', abs(quiet(@() compositeMidpointFormula(f, 0, 1, 100)) - Iref) < 1e-5);
    failures = check(failures, 'compositeTrapezoidalFormula', abs(quiet(@() compositeTrapezoidalFormula(f, 0, 1, 100)) - Iref) < 1e-5);
    failures = check(failures, 'compositeSimpsonFormula', abs(quiet(@() compositeSimpsonFormula(f, 0, 1, 100)) - Iref) < 1e-9);
end

%% Helpers
function failures = check(failures, name, ok)
    if ok
        fprintf('  ok    %s\n', name);
    else
        fprintf('  FAIL  %s\n', name);
        failures{end+1} = name;
    end
end

function varargout = quiet(fn)
%   Calls fn and hides what it prints (many methods print intermediate values).
    varargout = cell(1, max(nargout, 1));
    evalc('[varargout{:}] = fn();');
end
