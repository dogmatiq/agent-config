---
name: bootstrapping-repositories
description:
  "Use when setting up a new repository in the Dogmatiq organization, or one
  that lacks the standard files: Makefile, .gitignore, apm.yml, mise.toml and
  README.md. Triggers: new repo, set up repo, bootstrap repo, repo basics,
  standard files."
argument-hint: "optional repository name, e.g. 'observatory'"
---

# Bootstrapping Repositories

Every repository in the Dogmatiq organization has the same handful of files.
This skill writes them in the current repository, using what it can look up, so
the user doesn't have to answer questions.

Write only the files described here. Files that vary with the kind of project,
such as `go.mod`, `package.json`, `doc.go`, `.vscode/`, or a makefile package
for JavaScript, Docker, Helm, Protobuf or Prettier, are not part of this skill.
Write them only when the project needs them.

If a file already exists, leave it alone. Mention any way in which it differs
from the template, so the user can decide.

## Find the inputs

- **Name** — the repository's name, taken from `git remote get-url origin`, or
  from the directory name if there is no remote.
- **Description** — `gh repo view --json description --jq .description`, without
  a leading 🚧. If the repository has no description, ask the user once.
- **Go** — whether the repository has a `go.mod`.
- **agent-config version** —
  `gh api repos/dogmatiq/agent-config/releases/latest --jq .tag_name`.

## Files that Terraform generates

[dogmatiq/repos] generates these files in each repository. Most start with a
"DO NOT EDIT!" header. Never write them by hand.

- `LICENSE`
- `codecov.yml`, for Go repositories only
- `.github/dependabot.yml`
- `.github/workflows/ci.yml`
- `.github/workflows/dependabot.yml`, for repositories with auto-merge enabled
- `.github/workflows/publish-release.yml`

Terraform commits these files to the repository's default branch, so run
`git pull` before concluding that one is missing. If the repository still lacks
files that it should have, it is probably not registered in dogmatiq/repos.
Tell the user, and carry on with the rest.

## Makefile

Include the shared makefiles from [makefiles.dev] in this order: the base, the
changelog package, the Go package if the repository is a Go project, and the APM
package. The rule for installing the makefiles goes last.

```make
-include .makefiles/Makefile
-include .makefiles/pkg/changelog/v2/Makefile
-include .makefiles/pkg/go/v1/Makefile
-include .makefiles/pkg/apm/v1/Makefile

.makefiles/%:
	@curl -sfL https://makefiles.dev/v1 | bash /dev/stdin "$@"
```

Leave out the Go package if the repository is not a Go project.

## .gitignore

Follow the [gitignore skill]: ignore only what the repository itself produces.
The makefiles create a `.gitignore` with the first two entries if there isn't
one, so add the others to it if it exists.

```gitignore
/.makefiles/
/artifacts/
apm_modules/
/apm.lock.yaml
```

## apm.yml

Pin the `internal` package of this repository to its latest release, so that
Dependabot can keep it up to date.

```yaml
name: <name>
version: 0.0.0
dependencies:
  apm:
    - "dogmatiq/agent-config/internal#<agent-config version>"
```

## mise.toml

```toml
[tools]
apm = "0"
```

## README.md

Follow the [writing-prose skill]. The title is the repository's name in title
case, and the paragraph is the description. Expand the description into one or
two plain sentences only if it is too short to stand alone. Don't invent
features, installation steps or usage.

```markdown
<div align="center">

# <Title>

<description>

[![Latest Version](https://img.shields.io/github/tag/dogmatiq/<name>.svg?&style=for-the-badge&label=semver)](https://github.com/dogmatiq/<name>/releases)
[![Build Status](https://img.shields.io/github/actions/workflow/status/dogmatiq/<name>/ci.yml?style=for-the-badge&branch=main)](https://github.com/dogmatiq/<name>/actions/workflows/ci.yml)

</div>
```

For a Go project, add these two badges, the first before the others and the
second after them:

```markdown
[![Documentation](https://img.shields.io/badge/go.dev-documentation-007d9c?&style=for-the-badge)](https://pkg.go.dev/github.com/dogmatiq/<name>)
[![Code Coverage](https://img.shields.io/codecov/c/github/dogmatiq/<name>/main.svg?style=for-the-badge)](https://codecov.io/github/dogmatiq/<name>)
```

If the repository has no release tags, add this below the badges:

```markdown
> [!WARNING]
> This project is under development and has not been released.
```

## Check

Run `make`. It installs the shared makefiles and the agent skills, which shows
that the Makefile and `apm.yml` work, and it creates `CHANGELOG.md` if the
repository doesn't have one. Don't write that file yourself. Then run `git status` and check that the
only new or changed files are the ones described here, plus any changes that
were already in progress.

Report which files you wrote, which you skipped because they already existed,
and which generated files are missing.

<!-- references -->

[dogmatiq/repos]: https://github.com/dogmatiq/repos
[gitignore skill]: ../gitignore/SKILL.md
[makefiles.dev]: https://makefiles.dev
[writing-prose skill]: ../writing-prose/SKILL.md
