# git-hooks-reference

## Getting started

Git hooks are a great way to standardize team coding habits as part of the git lifecycle.
As norms evolve over time, you can update the behavior of git hooks using the existing test suite to suit your team's needs.

## Test and Deploy

We can test some of these scripts with bash. 
`run-all-tests.sh` executes the entire suite.
Execute this file from the `test/` directory.
Otherwise, run the appropriate `test/test-*.sh` file for the hook you're working with.

## Description

This project uses a set of test-fixtures to let you test changes to your git hooks with confidence.

Key files:

* `test/callers/call-*.sh` - A script used to link test fixtures with the implementation found in `hooks/`.
* `test/input/*.txt` - Text files that provide simulated user input, one test case per line.
* `test/test-*.sh` - A script that calls `run-test-cases.sh` with arguments for the hook under test.
* `scripts/*.sh` - Various helper files used by other scripts.
* `run-all-tests.sh` - Executes all `test/test-*.sh` files.
* `run-test-cases.sh` - A generalized loop that processes test cases and logging options for `test/test-*.sh`.

## Installation

Replace file paths in the `hooks/` directory with the correct paths for your project.
For example, within `pre-push` there is a `FRONTEND_DIRECTORY` and a `BACKEND_DIRECTORY` variable that default to `"test"`.

Run `yarn install` to install hooks.

## Usage

Attempt to commit, and see how the git hooks execute.
You can update the test cases and hook implementation details to suit your team norms.

If you want ANSI color highlighting while viewing a `.log` file from IntelliJ, try the [ANSI Highlighter Premium](https://plugins.jetbrains.com/plugin/9707-ansi-highlighter-premium) plugin.
This is a paid plugin with a trial period.
Restart your IDE after installation if you choose to try it out.

## Support

Open an issue on GitHub or message me on Slack.

## Roadmap

* Consider sharing this config across multiple projects with [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

## Contributing

Contributions welcome, just open up a MR and explain what your contributions do in the description.

Change your hook implementations in `hooks/` to suit your needs.
Update test cases in `test/input/`.

Unless you want to change logging options, it is unlikely that you'll need to modify `test/callers/`, `test/test-*.sh` or `run-*.sh`.
