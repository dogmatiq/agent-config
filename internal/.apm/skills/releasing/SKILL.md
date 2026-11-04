---
name: releasing
description:
  "Use when releasing a new version of a Dogmatiq project: cutting or tagging a
  release, bumping the version, or promoting [Unreleased] changelog entries.
  Triggers: release, cut a release, tag a release, bump version, new version."
argument-hint: "optional version without a prefix, e.g. '1.6.0'"
---

# Releasing

A release turns the `[Unreleased]` section of `CHANGELOG.md` into a dated
version section, commits it, and creates an annotated tag for it. The `make tag`
target from the `changelog/v2` package of the [makefiles.dev] makefiles does all
of this, and is the preferred way to release.

## 1. Check the preconditions

Stop and tell the user if any of these is true:

- `CHANGELOG.md` has no `## [Unreleased]` section, or it has only headings.
- There are uncommitted changes to files other than `CHANGELOG.md`.
- The tag for the version already exists.

## 2. Choose the version

Use the version the user gave, if any. Otherwise find the latest tag with
`git describe --tags --abbrev=0` and choose by the most significant change in
`[Unreleased]`:

| `[Unreleased]` contains | From 1.0.0 | Before 1.0.0 |
| ----------------------- | ---------- | ------------ |
| A **[BC]** entry        | major      | minor        |
| An `### Added` section  | minor      | minor        |
| Anything else           | patch      | patch        |

Tell the user the version and why. Ask before releasing a new major version,
including 1.0.0.

The version has no prefix (`1.6.0`). The tag is the version prefixed with `v`
(`v1.6.0`).

## 3. Release with `make tag`

If the root `Makefile` includes `.makefiles/pkg/changelog/v2/Makefile`, run:

```sh
make tag CHANGELOG_VERSION=1.6.0
```

Always set `CHANGELOG_VERSION`. Without it, `make tag` opens an editor.

## 4. Otherwise, complain, then emulate `make tag`

If the `Makefile` doesn't include it, the project is releasing the wrong way.
Tell the user, in one of two ways:

- If the root `Makefile` already uses the makefiles.dev makefiles (it includes
  `.makefiles/Makefile`), the fix is a single line, so there's no excuse for
  releasing by hand. Open your reply with this, before anything else, and ask
  the user to add this line after the `.makefiles/Makefile` include:

  ```make
  -include .makefiles/pkg/changelog/v2/Makefile
  ```

- Otherwise, tell the user that the project should adopt the [makefiles.dev]
  makefiles and release with `make tag`.

Don't change the `Makefile` yourself. Then release by hand, producing exactly
what `make tag` would:

1. Replace the `## [Unreleased]` heading with `## [1.6.0] - YYYY-MM-DD`, using
   today's date. Leave the entries as they are, and don't add a new
   `[Unreleased]` heading.
2. Add `[1.6.0]: <prefix>v1.6.0` to the link block after the last
   `<!-- references -->` comment, keeping the version links in ascending order.
   Copy `<prefix>` from the existing version links, such as
   `https://github.com/dogmatiq/ferrite/releases/tag/`. Leave the
   `[unreleased]:` link alone.
3. Commit only `CHANGELOG.md`, with the message `Bump version to 1.6.0`.
4. Create the annotated tag. Its message is `Version 1.6.0`, a blank line, then
   the entries of the new section without its heading:

   ```sh
   git tag --annotate --cleanup=whitespace --file - v1.6.0 <<'EOF'
   Version 1.6.0

   ### Added

   - ...
   EOF
   ```

   `--cleanup=whitespace` keeps the `###` headings, which git's default cleanup
   strips as comments.

Check the result: `git show --stat HEAD` lists only `CHANGELOG.md`, and
`git tag -l --format='%(contents)' v1.6.0` shows the message.

## 5. Push, once the user confirms

Never push until the user confirms. When you ask, show them the exact command
you'll run, which pushes the current branch and the tag:

```sh
git push origin HEAD v1.6.0
```

## Common Mistakes

- Bumping the major version for a **[BC]** entry before 1.0.0.
- Running `make tag` without `CHANGELOG_VERSION`.
- Tagging with `-m` or the default cleanup, which drops the `###` headings.
- Putting the new version link next to `[unreleased]:` instead of in version
  order.
- Releasing by hand without telling the user to switch to `make tag`.
- Pushing before the user confirms.

<!-- references -->

[makefiles.dev]: https://makefiles.dev
