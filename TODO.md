# TODO

Open tasks for this repository. See also [Known issues](README.md#known-issues).

## 1. Make it run

- [x] Restore `modifiedNewtonMethod.m` and `compositeSimpsonFormula.m`, deleted by mistake in 951cded
- [x] Make the interpolation scripts run in Octave (lowercase plot markers, no `interp1q`)
- [x] Fix `simpsonFormula` (called `f` instead of `fun`)
- [x] Fix the update step in `gaussSeidelMethodWeighting`
- [ ] Check the MATLAB job of the Tests workflow after the first push (only tested locally in GNU Octave 9.2)

## 2. Clean up

- [x] Remove third-party code: the Quarteroni `cubicspline` copy, `naturalspline.m` and the `bakery.m` scripts
- [x] Add `.gitignore` for `*.asv` autosave files
- [x] Move the cheat sheets to `docs/` and write them in English
- [ ] Decide whether to finish or remove the drafts in `Testexam/`

## 3. Tests and CI

- [x] `tests/runTests.m`: one check per function against a known result or a built-in
- [x] `tests/runScripts.m`: run every chapter script without figures
- [x] GitHub Actions workflow with GNU Octave and MATLAB

## 4. Publishing

- [x] MIT license
- [x] README with methods, getting started, tests and known issues
- [ ] Add the lecturer's name to the README, if wanted
- [ ] Rename the repository on GitHub to `numerical-methods-uzh` and update the remote
- [ ] Update the GitHub description and topics
