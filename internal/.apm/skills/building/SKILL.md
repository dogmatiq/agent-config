---
name: building
description:
  "Use when building, testing, linting, or formatting a Dogmatiq project, or
  checking whether CI will pass. Triggers: run tests, build, lint, format,
  precommit, make."
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

To run only some Go tests, pass `-run` in `GO_TEST_ARGS`:

```sh
make test GO_TEST_ARGS='-run TestParseID/empty_input'
```

This replaces the project's default test flags, such as `-race`. That's fine for
a focused run, so don't add them back.

Run `make precommit` before every commit, as described in the [committing
skill].

To list every target the project has, with a description of each:

```sh
grep -rhE '^# [a-z][a-z0-9_.-]* ---' .makefiles
```

`.makefiles/` is downloaded by the first `make` run if it's missing. Never edit
files in it. Run `make makefiles` to update it.

<!-- references -->

[committing skill]: ../committing/SKILL.md
[makefiles.dev]: https://makefiles.dev
