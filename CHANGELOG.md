# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog], and this project adheres to
[Semantic Versioning].

<!-- references -->

[keep a changelog]: https://keepachangelog.com/en/1.0.0/
[semantic versioning]: https://semver.org/spec/v2.0.0.html

## [Unreleased]

### Added

- Added the `gitignore` skill to `dogmatiq/agent-config/internal`. It says that
  a repository's `.gitignore` only ignores what the repository itself produces,
  and helps developers set up a global ignore file for everything else.

## [1.2.0] - 2026-11-09

### Added

- Added the `committing` skill to `dogmatiq/agent-config/internal`. It covers
  what to do before a commit: deciding whether the change needs a changelog
  entry, running `make precommit`, committing the files that belong to the
  change, and writing the commit message.

### Changed

- Moved the guidance on running `make precommit` and on changed files that the
  commit doesn't explain from the `building` skill to the `committing` skill.

## [1.1.1] - 2026-11-08

### Changed

- Changed the `testing-in-go` skill to say never to assert on log records in
  tests.

## [1.1.0] - 2026-11-06

### Added

- Added the `maintaining-changelogs` skill to `dogmatiq/agent-config/internal`.

## [1.0.0] - 2026-11-05

### Added

- Added the `building`, `maintaining-glossaries`, `releasing`, `testing-in-go`,
  `writing-adrs` and `writing-prose` skills to `dogmatiq/agent-config/internal`.

<!-- references -->

[unreleased]: https://github.com/dogmatiq/agent-config
[1.0.0]: https://github.com/dogmatiq/agent-config/releases/tag/v1.0.0
[1.1.0]: https://github.com/dogmatiq/agent-config/releases/tag/v1.1.0
[1.1.1]: https://github.com/dogmatiq/agent-config/releases/tag/v1.1.1
[1.2.0]: https://github.com/dogmatiq/agent-config/releases/tag/v1.2.0
