<div align="center">

# Dogmatiq Agent Configuration

AI agent skills for Dogma and Dogmatiq projects, packaged for [APM].

</div>

This repository holds two [APM] packages of skills for coding agents:

- `dogmatiq/agent-config`, at the repository root, is for any project that uses
  [Dogma].
- `dogmatiq/agent-config/internal`, in the `internal` directory, is only for
  repositories in the Dogmatiq organization. Its skills assume Dogmatiq
  conventions, such as running every build and test operation through `make`.

Each package only deploys its own skills.

## Usage

Add the packages that apply to the project to its `apm.yml` file, pinned to a
release tag. Both packages share the repository's tags. Repositories in the
Dogmatiq organization already have an `apm.yml`.

```yaml
dependencies:
  apm:
    - dogmatiq/agent-config#v1.1.0 # in a project that uses Dogma
    - dogmatiq/agent-config/internal#v1.1.0 # in a Dogmatiq repository
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

Pin an exact tag rather than a range such as `^1.0.0`, so that [Dependabot] can
keep it up to date. It doesn't update ranges. Enable its `apm` ecosystem in
`.github/dependabot.yml`, and it opens a pull request when there's a newer
release, including a new major version:

```yaml
version: 2
updates:
  - package-ecosystem: apm
    directory: "/"
    schedule:
      interval: daily
```

In repositories in the Dogmatiq organization, the `dependabot.yml` that
Terraform generates from [dogmatiq/repos] already includes it. Merging the pull
request changes `apm.yml`, so in a project that uses the `apm` package of the
[makefiles.dev] makefiles, the next `make` installs the new release. Otherwise,
run `apm install`.

Add `apm_modules/` and `apm.lock.yaml` to the repository's `.gitignore`. Don't
commit the lockfile: it records the files deployed for the target that generated
it, so it differs between developers. Deployed skills, such as
`.claude/skills/`, depend on each developer's target, so they belong in each
developer's global gitignore instead.

Don't commit deployed skills. A repository that provides its own skills keeps
them under `.apm/`, as described in [Layout], and `apm install` deploys them
alongside its dependencies.

Projects can also install a subset of a package's skills by listing them by
name. Add `path: internal` to select from the `internal` package:

```yaml
dependencies:
  apm:
    - git: dogmatiq/agent-config
      ref: v1.1.0
      skills: [<name>, <name>]
```

Dependabot doesn't update this form, so update its `ref` by hand.

## Layout

Each skill for projects that use Dogma lives in `.apm/skills/<name>/SKILL.md`,
and each skill for Dogmatiq repositories lives in
`internal/.apm/skills/<name>/SKILL.md`. Other kinds of agent configuration, such
as instructions or prompts, belong in sibling directories under the same `.apm/`
directory.

<!-- anchors -->

[layout]: #layout

<!-- references -->

[apm]: https://github.com/microsoft/apm
[dependabot]: https://docs.github.com/en/code-security/dependabot/dependabot-version-updates
[dogma]: https://github.com/dogmatiq/dogma
[dogmatiq/repos]: https://github.com/dogmatiq/repos
[makefiles.dev]: https://makefiles.dev
