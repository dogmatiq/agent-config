<div align="center">

# Dogmatiq Agent Configuration

AI agent skills and configuration for Dogmatiq projects, packaged for [APM].

</div>

This repository is an [APM] package. It holds the skills that coding agents use
when working on Dogmatiq projects, such as how to build and test a project, how
to write an ADR, and the prose style for documentation.

## Usage

Add the package to the `apm.yml` file of a Dogmatiq repository, pinned to a
release tag:

```yaml
dependencies:
  apm:
    - dogmatiq/agent-config#v0.1.0
```

Which agents receive the skills is up to each developer, so the repository's
`apm.yml` does not declare `targets`. Set the target once per machine, then run
`apm install` in each repository:

```sh
apm config set target claude
apm install
```

Without a configured target, APM falls back to detecting agent-specific files
such as `CLAUDE.md`, and fails with "No harness detected" if there are none.

Projects outside the Dogmatiq organization can install a subset of the skills
by listing them by name:

```yaml
dependencies:
  apm:
    - git: dogmatiq/agent-config
      ref: v0.1.0
      skills: [prose, testing]
```

Several skills assume Dogmatiq conventions — for example, `build-and-test`
expects every operation to go through `make`.

## Layout

Each skill lives in `.apm/skills/<name>/SKILL.md`. Other kinds of agent
configuration, such as instructions or prompts, belong in sibling directories
under `.apm/`.

<!-- references -->

[apm]: https://github.com/microsoft/apm
