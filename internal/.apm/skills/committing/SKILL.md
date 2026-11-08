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
   files, for example by formatting them, and that includes the changelog, so
   run it after editing it.

## Choosing what to commit

Commit the files you changed, together with any changes `make precommit` made to
them.

If `make precommit` changes other files, such as by regenerating generated code,
don't revert them and don't commit them. Tell the user which files changed. Only
the user can tell whether the changes are noise or a real problem, such as a
tool version that differs from the one that generated the committed files.

Do the same for any other changes that were already in the working tree before
you started.

## Writing the message

Write the first line as a sentence in the imperative mood that ends with a
period, such as "Say never to assert on log records in tests." Describe what the
commit does, not how you did it. If the reason for the change isn't obvious, add
it in the body after a blank line.

## Common Mistakes

- Committing a change that users would notice without a changelog entry.
- Editing the changelog after running `make precommit`.
- Committing files that `make precommit` changed but you didn't.
- Reverting unrelated changes to "clean up" the working tree.

<!-- references -->

[building skill]: ../building/SKILL.md
[maintaining-changelogs skill]: ../maintaining-changelogs/SKILL.md
