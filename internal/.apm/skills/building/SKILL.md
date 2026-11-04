---
name: building
description:
  "Use when building, testing, linting, or formatting a Dogmatiq project,
  preparing changes to commit, or checking whether CI will pass. Triggers: run
  tests, build, lint, format, precommit, ready to commit, make."
argument-hint: "optional target, e.g. 'test' or 'precommit'"
---

# Building

Dogmatiq projects build with the [makefiles.dev] makefiles. Their targets do
more than the language tools on their own: they regenerate generated files, add
the project's flags (such as `-race` for Go tests), build every binary, and
format code. Always use `make`. Never run `go test`, `go build`, `go vet`,
`gofmt`, `npm test` or similar directly.

| To                            | Run              |
| ----------------------------- | ---------------- |
| Run the tests                 | `make`           |
| Check changes before a commit | `make precommit` |
| Run the checks CI runs        | `make ci`        |
| Lint                          | `make lint`      |

Run `make precommit` before every commit. It can rewrite files, for example by
formatting them. Include its changes to the files you changed.

If it changes any other files, such as by regenerating generated code, don't
revert them and don't commit them. Tell the user which files changed. Only the
user can tell whether the changes are noise or a real problem, such as a tool
version that differs from the one that generated the committed files.

To list every target the project has, with a description of each:

```sh
grep -rhE '^# [a-z][a-z0-9_.-]* ---' .makefiles
```

`.makefiles/` is downloaded by the first `make` run if it's missing. Never edit
files in it. Run `make makefiles` to update it.

<!-- references -->

[makefiles.dev]: https://makefiles.dev
