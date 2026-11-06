---
name: maintaining-changelogs
description:
  "Use when adding or editing entries in a Dogmatiq project's CHANGELOG.md:
  recording a change, deciding whether a change needs an entry, wording an
  entry, or marking a breaking change. Triggers: update the changelog, add a
  changelog entry, what goes in [Unreleased], mark as breaking, BC."
argument-hint: "the change to record, e.g. 'renamed Input to VariableSet'"
---

# Maintaining Changelogs

Every Dogmatiq project has a `CHANGELOG.md` in the root of its repository. It's
a human-readable summary of what changed in each release, in [Keep a Changelog]
format. It isn't meant to be exhaustive.

This skill covers recording changes as they're made. To turn `[Unreleased]` into
a release, use the [releasing skill].

## When to add an entry

Add an entry in the same change that causes it, for anything a user of the
project would notice:

- New, changed, deprecated or removed API.
- Changes in behavior.
- Bug fixes.
- Changes to dependencies or supported Go versions that affect users.

Don't add entries for changes users can't observe, such as refactoring, tests,
comment fixes and CI.

## Where entries go

Entries go under the `## [Unreleased]` heading at the top of the file, below the
preamble and its link definitions. If there is no such section, add one above
the newest version heading. Never edit the sections of released versions.

Group entries under the Keep a Changelog headings, using only the ones you need
and keeping this order:

1. `### Added` for new features.
2. `### Changed` for changes to existing behavior.
3. `### Deprecated` for features that will be removed.
4. `### Removed` for features that were removed.
5. `### Fixed` for bug fixes.
6. `### Security` for vulnerabilities.

Never leave a heading with no entries under it. `make tag` refuses to release an
`[Unreleased]` section that contains only headings.

When many related changes need explaining, such as a rename across a whole API,
a short paragraph before the first heading can introduce them.

## Writing an entry

- Write a bullet in the past tense that starts with a verb, such as "Added",
  "Removed" or "Fixed".
- Describe the change from the user's point of view, and name the API in
  backticks.
- For a deprecation, name the replacement.
- Follow the [writing-prose skill] for wrapping, spelling and links. Indent
  continuation lines by two spaces.

```markdown
## [Unreleased]

### Added

- Added `Config.RenderStructFieldName`, a function that controls the name
  displayed for each struct field.

### Deprecated

- Deprecated the `GoX()` functions in favor of the equivalent `WaitGroup.GoX()`
  methods.
```

## Marking breaking changes

Start the entry of a breaking change with the tag **[BC]**:

```markdown
### Changed

- **[BC]** Renamed `Input` to `VariableSet`.
```

A breaking change is one that may require changes to code that uses the library.
Examples are removing or renaming an exported identifier, changing its
signature, and changing behavior that callers can rely on.

These aren't breaking changes, so don't tag them:

- Dropping support for a Go version that is no longer supported.
- Changing an experimental feature, such as an `exp` package or an identifier
  that starts with `X`.

The tag is a reference link. If the changelog doesn't already define it, add
this to its first `<!-- references -->` block, keeping the definitions sorted:

```markdown
[bc]: https://github.com/dogmatiq/.github/blob/main/VERSIONING.md#changelogs
```

Entries with this tag decide the next version number, as described in the
[releasing skill].

## Common Mistakes

- Adding an entry under a released version instead of `[Unreleased]`.
- Writing an entry in the present tense, such as "Adds" or "Removes".
- Leaving a heading with no entries under it.
- Tagging an entry **[BC]** without defining `[bc]` in the changelog.
- Tagging the removal of an unsupported Go version as **[BC]**.
- Adding entries for changes that users can't observe.

<!-- references -->

[keep a changelog]: https://keepachangelog.com/en/1.0.0/
[releasing skill]: ../releasing/SKILL.md
[writing-prose skill]: ../writing-prose/SKILL.md
