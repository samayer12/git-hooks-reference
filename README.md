# git-hooks-reference

## Getting started

Git hooks are a great way to standardize team coding habits as part of the git lifecycle.

## Test and Deploy

We can test some of these scripts with BASH. 
`run-all-tests.sh` executes the entire suite.
Otherwise, run the appropriate `test/test-*.sh` file for the hook you're working with.

## Description

This project uses a homebrew set of test-fixtures to let you test changes to your git hooks with confidence.

Key files:

* `test/callers/call-*.sh` - A script used to link test fixtures with the implementation found in `hooks/`.
* `test/input/*.txt` - Text files that provide simulated user input, one test case per line.
* `test/test-*.sh` - A script that calls `run-test-cases.sh` with argument for the hook under test.
* `scripts/*.sh` - Various helper files used by other scripts.
* `run-all-tests.sh` - Executes all `test/test-*.sh` files.
* `run-test-cases.sh` - A generalized loop that processes test cases and logging options for `test/test-*.sh`.

## Installation

You'll need to replace file paths in the `hooks/` directory with the correct paths for your project.
For example, within `pre-push` there is a `FRONTEND_DIRECTORY` and a `BACKEND_DIRECTORY` variable that default to `"test"`.

## Usage

Run `yarn install` to install hooks.


## Support

Contact Sam Mayer on ASWF slack or open an [issue](https://gitlab.create.army.mil/samuel.a.mayer5.ctr/git-hooks-reference/-/issues).

## Roadmap

If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing

Contributions welcome, just open up a MR and explain what your contributions do in the description.

Change your hook implementations in `hooks/` to suit your needs.
Update test cases in `test/input/`.
Unless you want to change logging options, it is unlikely that you'll need to modify `test/callers/`, `test/test-*.sh` or `run-*.sh`.

## License

For open source projects, say how it is licensed.
