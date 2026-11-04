---
name: writing-prose
description:
  "Use when writing, editing, or reviewing prose in a Dogmatiq project, in
  markdown documentation such as READMEs, ADRs, glossaries and changelogs, or in
  doc comments in code in any language. Triggers: style review, check style,
  prose style, markdown style, check docs, documentation style, style guide, doc
  comments, spelling, US English."
argument-hint: "the file or section to review, e.g. 'docs/glossary.md'"
---

# Writing Prose

These rules apply to markdown documentation and to doc comments in code, in any
language. Rules marked "markdown only" don't apply to doc comments. In those
areas, doc comments follow the conventions of their language, such as Go's
`[Name]` doc links. Skills for particular kinds of document, such as ADRs and
glossaries, add their own rules on top of these.

## Tone

Relaxed but precise. Write as an experienced engineer explaining the topic to
another engineer. Avoid overly formal specification language. Prefer clear,
natural explanations that remain technically accurate. The tone should be
approachable and conversational, but not casual.

Assume readers have an intermediate understanding of software development but
may not know Dogmatiq projects or the document's domain. Avoid jargon, and
explain any technical terms the document needs. Picture the reader as an
application developer with about five years of professional experience, who
knows Go but has little background in algorithms or mathematics.

## File names (markdown only)

Use lowercase file names, such as `glossary.md`, unless an external convention
requires otherwise, such as `LICENSE` or `README.md`.

## Line wrapping (markdown only)

Reflow each paragraph so that every line fits as many words as possible within
80 characters.

## Punctuation

- Use straight quotes and apostrophes (`"`, `'`) in prose, never curly ones.
  Non-ASCII characters are fine in code blocks and formulas.
- Write em dashes with a space on each side, as in `word — word`.
- Use an em dash, not hyphens, as a parenthetical separator.
- Use an em dash for an apposition that defines a term, in lists and in
  paragraphs. Don't use colons, semicolons or parentheses for this.
- Consider restructuring sentences or paragraphs that contain many em dashes.
- Use semicolons sparingly, for contrast (A; B does not), qualification (A;
  however B) or logical consequence (A; therefore B). Prefer a period if the
  clauses read naturally as two separate sentences.
- Replace a double hyphen (`--`) in prose with an em dash where appropriate.
  Otherwise, suggest the correct punctuation.

## Spelling

Use US English. When in doubt, follow go.dev, the Go standard library
documentation, or the AWS and GCP documentation.

| US (correct) | Not US (incorrect) |
| ------------ | ------------------ |
| analyze      | analyse            |
| behavior     | behaviour          |
| canceled     | cancelled          |
| center       | centre             |
| color        | colour             |
| initialize   | initialise         |
| labeled      | labelled           |
| serialize    | serialise          |

## Reference links (markdown only)

- Use reference-style links, never inline links.
- Put the link definitions at the bottom of the file, in groups that each start
  with a labeling HTML comment, such as `<!-- references -->` or
  `<!-- anchors -->`.
- Sort each group alphabetically by label. The exception is the version links in
  a `CHANGELOG.md`, which stay in ascending version order, so `[0.9.0]` comes
  before `[0.10.0]`.
- When a linked term appears in plural form, add a separate definition for the
  plural, such as `[instructions]: #instruction`, so the source reads naturally.
- Every definition must be used at least once. Remove unused definitions.
- Every reference must have a matching definition. Don't leave broken
  references.

## Reviewing

Check the text against every rule above. For each problem, quote the text, name
the rule it breaks, and suggest a correction.
