# git-hooks-reference


## Getting started

Git hooks are a great way to standardize team coding habits as part of the git lifecycle.

## Add your files


## Test and Deploy

We can test some of these scripts with BASH.

## Description

This project uses a homebrew set of test-fixtures to let you test changes to your git hooks with confidence.

Key files:

* `test/callers/call-*.sh` - A script used to link test fixtures with the implementation found in `hooks/`.
* `test/test-*.sh` - A script that contains test cases for each commit hook under test.
* `scripts/*.sh` - Various helper files used by other scripts.
* `run-all-tests.sh` - Executes all `test/test-*.sh` files.

## Installation

You'll need to replace file paths in the `hooks/` directory with the correct paths for your project.
For example, within `pre-push` there is a `FRONTEND_DIRECTORY` and a `BACKEND_DIRECTORY` variable that default to `"test"`.

## Usage

Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support

Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap

If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing

State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status

If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
