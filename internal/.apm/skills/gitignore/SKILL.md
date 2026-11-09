---
name: gitignore
description:
  "Use when adding, editing or reviewing a .gitignore in a Dogmatiq project,
  deciding whether a file should be ignored, or when untracked files created by
  the developer's own tools show up. Triggers: gitignore, ignore a file,
  untracked files, .DS_Store, .idea, global gitignore, excludesFile."
argument-hint: "optional file or pattern, e.g. '.DS_Store'"
---

# Gitignore

A repository's `.gitignore` files only ignore what the repository itself
produces, such as the output of its makefiles. Files that exist because of a
developer's choice of operating system, editor or other tools are ignored in
that developer's global ignore file instead.

## What belongs in the repository

Ignore the files that the project itself produces, such as with its makefiles,
and that aren't meant to be committed:

- `/artifacts/` and `/.makefiles/`. The makefiles create a `.gitignore` with
  these two entries if the repository doesn't have one, so leave them in place.
- `apm_modules/` and `/apm.lock.yaml`, which `apm install` produces.

Some makefile packages add their own entries to `.gitignore`. Don't remove them.

Not everything the project produces is ignored. Generated files, such as code
generated from `.proto` files, are usually committed on purpose. If you can't
tell whether a file is meant to be committed, ask the user.

Anchor a path to the root of the repository with a leading slash, as in
`/artifacts/`. Without one, the pattern matches at any depth.

## What doesn't

Don't ignore files that only some developers have, such as:

- Operating system files, such as `.DS_Store` and `Thumbs.db`.
- Editor and IDE files, such as `.idea/` and `*.swp`.
- Agent configuration deployed by `apm install`, such as `.claude/`. It depends
  on the agents each developer uses.
- Scratch files and notes.

The list is endless, it differs between developers, and it clutters the file
for everyone else. There is also a practical reason: `make clean-ignored`
deletes every file that the repository's `.gitignore` files match, but not
those that only a global ignore file matches. A developer's editor settings
listed in the repository's `.gitignore` would be deleted by it.

If the project commits some files in a directory, such as
`.vscode/extensions.json`, don't ignore the whole directory. Ignore only what
the project produces in it.

## Deciding where a file belongs

When asked to ignore a file, or when untracked files show up in `git status`,
find out where the file comes from:

- If the project itself produces it, and it isn't meant to be committed, add it
  to the repository's `.gitignore`.
- If the developer's own tools produce it, don't change the repository. Tell the
  developer, and help them with their global ignore file as described below.

`git check-ignore --verbose <path>` shows which rule ignores a path, and in
which file. If the repository's `.gitignore` already contains entries for a
developer's own tools, say so, but don't remove them unless the user asks.

For a file that only matters in one clone of one repository, `.git/info/exclude`
works like a `.gitignore` that isn't shared.

## The developer's global ignore file

Developers manage their global ignore file in different ways, such as in a
dotfiles repository, with configuration management, or with tools like Nix that
make the file read-only. Find out what they have before suggesting anything:

1. Run `git config --get core.excludesFile`. If it prints a path, that is their
   file.
2. If it prints nothing, Git uses `$XDG_CONFIG_HOME/git/ignore`, which is
   `~/.config/git/ignore` if `XDG_CONFIG_HOME` isn't set. Check whether that
   file exists.

If they already have a file, it's theirs to manage, so don't edit it, even if
it's writable. Tell them which entries it's missing for the files you've seen,
and where it is. If it's a symlink, say where it points, because that's
probably where they manage it. `git check-ignore --verbose <path>` shows
whether it already ignores a path.

If they don't have one, offer to create `~/.config/git/ignore`, which Git reads
without any configuration. Ask which operating system, editors and AI agents
they use, instead of guessing. The `.claude/` directory, for example, is only
relevant to people who use Claude Code. Propose the entries, and wait for a yes
before writing, because the file is personal and outside the repository.

If `make` reports "agent configuration must not be committed", it lists the
deployed files. They are specific to the developer's agents, so they belong in
the developer's global ignore file, not the repository's `.gitignore`. Tell the
developer, or offer to create the file if they have none.

## Common Mistakes

- Adding `.DS_Store`, `.idea/` or `.claude/` to a repository's `.gitignore` to
  make `git status` quiet.
- Removing `/.makefiles/` or `/artifacts/` from a repository's `.gitignore`.
- Ignoring a whole directory when the project commits some of its files.
- Editing a developer's existing global ignore file, instead of telling them
  what it's missing.
- Creating a global ignore file without asking, or without checking
  `core.excludesFile` first.
- Guessing which operating system, editors or agents the developer uses.
