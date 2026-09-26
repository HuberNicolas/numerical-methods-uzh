<div align="center">

# Numerical Methods (UZH)

**MATLAB implementations of the classic numerical methods, from root finding to numerical integration**

[![Tests](https://github.com/HuberNicolas/numerical-methods-uzh/actions/workflows/tests.yml/badge.svg)](https://github.com/HuberNicolas/numerical-methods-uzh/actions/workflows/tests.yml)
![MATLAB](https://img.shields.io/badge/MATLAB-0076A8)
![GNU Octave](https://img.shields.io/badge/GNU_Octave-9.2-0790C0?logo=octave&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow)

[Methods](#methods) · [Getting started](#getting-started) · [Tests](#tests) · [Cheat sheets](#cheat-sheets)

</div>

Coursework for *Numerical Methods for Informatics* at the University of Zurich, fall semester 2020. Every method is
written from scratch as a MATLAB function, and each chapter has a script that tries the methods on an example and
compares them with the built-in MATLAB functions.

- 🎯 **Root finding:** bisection, fixed-point iteration, Newton (also for multiple roots), secant
- 📈 **Interpolation:** monomial, Lagrange, barycentric Lagrange, piecewise linear, quadratic and cubic splines
- 📉 **Least squares:** polynomial fit via the normal equations
- 🧮 **Linear systems:** substitution, Gaussian elimination, LU (dense and banded), Cholesky, Thomas, QR (Gram-Schmidt)
- 🔁 **Iterative solvers:** Jacobi, Gauss-Seidel, Gauss-Seidel with relaxation
- 🔢 **Eigenvalues:** power method, inverse power method, with fixed and dynamic shift
- ∫ **Integration:** midpoint, trapezoidal and Simpson rule, simple and composite

> [!NOTE]
> Unofficial study material, written in 2020/21 while taking the course. The code is kept as it was back then, with
> the original names, typos included (`qubicSplineInterpolation`, `piecewiese…`). Since then a few bugs were fixed
> and tests were added. The repository is not developed further. Course slides and exercise sheets are not
> included.

## Contents

- [Methods](#methods)
- [Repository structure](#repository-structure)
- [Getting started](#getting-started)
- [Tests](#tests)
- [Cheat sheets](#cheat-sheets)
- [Known issues](#known-issues)
- [License](#license)
- [Author](#author)

## Methods

Chapter numbers follow the course. Every folder has one or more `*Script.m` files that run the methods on an example.

| Chapter | Topic | Functions |
|---|---|---|
| [2](Chapter2) | Nonlinear equations | `bisectionMethod`, `fixedPointIterationMethod`, `newtonMethod`, `modifiedNewtonMethod`, `secantMethod` |
| [3](Chapter3) | Polynomial interpolation | `monomialInterpolation`, `lagrangianInterpolation`, `lagrangianInterpolationBarycentric` |
| [4](Chapter4) | Piecewise interpolation, splines | `linearPiecewiseInterpolation`, `quadraticSplineInterpolation`, `quadraticSplineInterpolation2`, `qubicSplineInterpolation` |
| [5](Chapter5) | Least squares | `leastSquare` |
| [6](Chapter6) | Direct methods for linear systems | `forwardSubstitution`, `backwardSubstitution`, `forwardGaussianElimination`, `forwardGaussianEliminationU`, `LUFactorisationNonPivoting`, `gaussLUFactorisation`, `choleskyFactorisation`, `thomasFactorisation`, `QRFactorisation`, `QRFactorisationEconomic` |
| [7](Chapter7) | Banded LU, iterative methods | `LUFactorisationNonPivotingSparse`, `jacobiMethod`, `gaussSeidelMethod`, `gaussSeidelMethodWeighting` |
| [8](Chapter8) | Eigenvalues | `powerMethod`, `powerMethodDynShift`, `inversePowerMethod`, `inversePowerMethodShift` |
| [9](Chapter9) | Numerical integration | `midpointFormula`, `trapezoidalFormula`, `simpsonFormula`, `compositeMidpointFormula`, `compositeTrapezoidalFormula`, `compositeSimpsonFormula` |

Each function starts with a comment block that describes its inputs and outputs, so `help bisectionMethod` works.

## Repository structure

| Path | Content |
|---|---|
| [`Chapter2`](Chapter2) … [`Chapter9`](Chapter9) | Functions and example scripts per chapter |
| [`Testexam`](Testexam) | Unfinished attempts from the exam preparation (see [Known issues](#known-issues)) |
| [`tests`](tests) | `runTests.m` checks every function, `runScripts.m` runs every example script |
| [`docs`](docs) | Cheat sheets with MATLAB commands and built-in functions |
| [`functionTemplate.m`](functionTemplate.m), [`scriptTemplate.m`](scriptTemplate.m) | Templates all functions and scripts were started from |

## Getting started

You need MATLAB or [GNU Octave](https://octave.org). No toolboxes are required.

1. Clone the repository:

   ```bash
   git clone https://github.com/HuberNicolas/numerical-methods-uzh.git
   ```

2. Open MATLAB or Octave, change into a chapter folder and run its script, for example:

   ```matlab
   cd Chapter2
   newtonMethodScript
   ```

   The scripts start with `clc; clear all; close all;` and open figure windows.

3. Or call a function directly from its folder:

   ```matlab
   cd Chapter2
   [x, it] = bisectionMethod(@(x) x.^2 - 2, 1, 2, 1000, 1e-10)
   ```

Without a local installation, Octave also runs in Docker. On Apple silicon, add `--platform linux/amd64`:

```bash
docker run --rm -it -v "$PWD":/work -w /work gnuoctave/octave:9.2.0 octave-cli
```

## Tests

[`tests/runTests.m`](tests/runTests.m) compares every function with a known result or the built-in function (`eig`,
`polyfit`, `interp1`, `integral`, `\`). [`tests/runScripts.m`](tests/runScripts.m) runs every `Chapter*/*Script.m`
without figures and fails if one throws an error. Both run in MATLAB and Octave, from the repository root:

```matlab
cd tests; runTests; runScripts
```

With Docker instead of a local installation:

```bash
docker run --rm -v "$PWD":/work -w /work gnuoctave/octave:9.2.0 octave-cli --eval "cd tests; runTests; runScripts"
```

The [Tests workflow](.github/workflows/tests.yml) runs both on every push, once in GNU Octave and once in MATLAB.

## Cheat sheets

| File | Content |
|---|---|
| [`docs/matlab-commands.md`](docs/matlab-commands.md) | Snippets: function handles, plotting, Chebyshev nodes, splines, LU |
| [`docs/matlab-functions.md`](docs/matlab-functions.md) | Built-in functions for interpolation, decompositions and matrices |

## Known issues

- The files in [`Testexam`](Testexam) are unfinished drafts from the exam preparation and contain syntax errors
  (`x[x2]` in `ex1_poly.m`, an incomplete `err =` in `ex3_nonlin.m` and `stdNewton.m`). They are kept as they were
  and are not part of the tests.
- The root-finding methods stop when `abs(fun(x) - 1e-12) < eps`. With a tolerance below `1e-12` this never holds;
  for a root that is hit exactly, `modifiedNewtonMethod` then divides 0 by 0 and returns `NaN`.
- `lagrangianInterpolation` loops over the rows of `xeval` and evaluates only the first point of a row vector. Pass
  `xeval` as a column vector.
- `quadraticSplineInterpolation2` returns the coefficients in monomial form, `quadraticSplineInterpolation` in the
  `(x - x_i)` form that `mkpp` expects.
- Many functions print intermediate values because of missing semicolons.

## License

The code is licensed under the [MIT License](LICENSE).

## Author

Nicolas Huber, then a Bachelor's student in Information Systems at the University of Zurich. Written for the course *Numerical Methods for
Informatics*, fall semester 2020.
