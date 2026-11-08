---
name: committing
description:
  "Use when committing changes in a Dogmatiq project: checking a change is ready
  to commit, choosing which files to stage, or writing a commit message.
  Triggers: commit, git commit, ready to commit, commit message, stage."
argument-hint: "optional description of the change being committed"
---

# Committing

A commit should contain one change, formatted by the project's tooling, and
nothing else.

## Before committing

Do these in order:

1. Decide whether the change needs a changelog entry. Most commits don't:
   refactoring, tests and CI are invisible to users. If users of the project
   would notice the change, add an entry to the `[Unreleased]` section of
   `CHANGELOG.md` in the same commit, as described in the
   [maintaining-changelogs skill].
2. Run `make precommit`, as described in the [building skill]. It can rewrite
   files, such as by formatting or regenerating them, and that includes the
   changelog, so run it after editing it.

## Choosing what to commit

Commit every file that belongs to the change, including files the makefiles
generate or format because of it. For example, a change to a `.proto` file
regenerates the code built from it, and that code goes in the same commit. The
makefiles also do this before `make test`, so these files may already have
changed by the time you run `make precommit`.

If files have changed that your change can't explain, such as generated code
whose source you didn't touch, don't commit them and don't revert them. Tell the
user which files changed. Only the user can tell whether the changes are noise
or a real problem, such as a tool version that differs from the one that
generated the committed files.

Leave alone any other changes that were already in the working tree before you
started.

## Writing the message

Write the first line as a sentence that says what merging the commit would do to
the codebase. Use the imperative mood and end with a period, such as "Return an
error from `ParseID` when the input is empty." If the reason for the change
isn't obvious, add it in the body after a blank line.

## Common Mistakes

- Committing a change that users would notice without a changelog entry.
- Editing the changelog after running `make precommit`.
- Leaving out generated files whose source the commit changes.
- Committing changes to generated files that your change can't explain.
- Reverting unrelated changes to "clean up" the working tree.

<!-- references -->

[building skill]: ../building/SKILL.md
[maintaining-changelogs skill]: ../maintaining-changelogs/SKILL.md
