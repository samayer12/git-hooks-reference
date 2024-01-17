%title: Encouraging Developer Norms with Git Hooks
%author: Sam Mayer, Broadcom
%date: 2024-02-16

[[_TOC_]]

This readme is written in [mdp](https://github.com/visit1985/mdp) format.
Some things may not render properly on gitlab.
You can install `mdp` view this document as a slideshow.

---

# Encouraging Developer Norms with Git Hooks

Git hooks allow developers to automate actions at different stages of the version control process.

* Maintain code quality
* Enforce project-specific workflows
* Prevent common mistakes

Ultimately, git hooks are about improving collaboration and efficiency.

---

# How do we use git hooks?

* Manage hooks with [Husky](https://typicode.github.io/husky/)
* Lint commit messages (e.g., [commitlint](https://github.com/conventional-changelog/commitlint)) 
* Run test suites (e.g., `yarn test`, `./gradlew test`)

---

# Why Lint Commits?

Given the following commit messages, where would you start troubleshooting?

Without commit linting:
```
Co-authored-by: [REDACTED]
Merge branch 'rename_harbor_vars' into 'main'
push
Merge branch 'update-runner-tags' into 'main'
updating runner tags for learn
Merge branch 'feature/pipeline_refactor' into 'main'
push
commenting out buildscript, adding gradle init
revert to old build
add extends to build-image
push
push
push
testing with tesseract
refactored frontend. moved shard components and services to shared dir. moved todosList to todos dir and renamed to View.
Linked AO-Cocs to README.md
```

[Relevant XKCD](https://xkcd.com/979/).

---

# Why Lint Commits Con't

Given the following commit messages, where would you start troubleshooting?

```
[#184892736] chore: Edits start and end date time error message.
[#184889737] fix: Fixes same start and end date time bug.
[#184816293] chore: Reduce font size of row title to accommodate longer titles.
[#184685570] feature: Adds ability to update all future recurring events.
[#000000000] chore: Refactors recurring event updates and tests.
[#184640163] feature: Adds ability to completely move recurring events or a single instance of recurring events.
[#184685359] feature: Add one day view for Moe/Clarissa.
[#184872698] chore: Upgrades to Spring Boot 2.7.10 and forces nimbus-jose-jwt to use specific version.
[#184869099] fix: Updates day of week in recurring form fields to not error out while start date is undefined.
[#184640163] feature: Adds update event in a weekly recurrence.
[#184685361] feature: Create one week view for users.
[#184730174] fix: Add event bubble padding.
[#184730174] feature: Add date in MMM DD format to event bubble.
[#000000000] chore: Updates CHANGELOG for v1.1.0.
[#184496803] feature: Highlights corresponding event when notification is clicked.
[#184496803] feature: Adds notification click to event date.
[#184805302] fix: Shows actual time the update occured in notifications.
[#000000000] chore: Updates CHANGELOG for v1.0.3.
[#000000001] chore: Removes old team members from local staging access.
```

---

# Code Example 1 - Lint Commits

1. git clone https://github.com/samayer12/git-hooks-reference
2. cd git-hooks-reference
3. yarn install
4. touch myfile.txt
5. git add myfile.txt
6. git commit -m "0: Demo commit hooks"
7. git reset --hard origin/main

---

# What Happened?

1. `pre-commit` ran, linting staged files that match the config in `.linstagedrc.json`.
2. `prepare-commit-message` automatically included a story id.
3. `commit-msg` ran `commitlint` to ensure the git log follows team norms.

---

# Why automatically run tests?

* CI image availability (e.g., Cypress)
* Encourage regular testing with new team members
* Continuous Integration at every level

---

# Code Example 2 - Run Test Suite

1. touch test/myfile.txt
2. git add test/myfile.txt
3. git commit -m "0: Demo pre-push hook"
4. git push origin main
5. git reset HEAD~1
6. git push -f

---

# What Happened? 

`pre-push` detected if "backend" or "frontend" files changed.

Then, it ran the applicable test suite before pushing to `main`.

---
