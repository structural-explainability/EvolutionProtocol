# Structural Explainability: Evolution Protocol

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/license/MIT)
![Build Status](https://github.com/structural-explainability/EvolutionProtocol/actions/workflows/ci-lean.yml/badge.svg?branch=main)
[![Check Links](https://github.com/structural-explainability/EvolutionProtocol/actions/workflows/links.yml/badge.svg)](https://github.com/structural-explainability/EvolutionProtocol/actions/workflows/links.yml)

> Lean 4 formalization of the Evolution Protocol schemas.

## What This Formalizes

This repository provides a Lean 4 formalization
of the structural core of the Evolution Protocol,
including canonical record schemas for
entities, relationships, and evolutions;
a shared RecordEnvelope;
retention-policy data shapes;
and basic graph-oriented data structures.
The code machine-checks the well-formedness and
typing of these structures and verifies that
the protocol's core representations are
internally consistent and composable,
without embedding causal, normative, or policy interpretations.

## Build and Run

```shell
lake update
lake build
lake exe verify
```

## Developer (running pre-commit)

Pre-commit is optional; CI will report exact commands if it fails.

Steps to run pre-commit locally. Install `uv`.

Initialize once:

```shell
uv self update
uvx pre-commit install
uvx pre-commit run --all-files
```

Save progress as needed:

```shell
git add -A
# If pre-commit makes changes, re-run `git add -A` before committing.
git commit -m "update"
git push -u origin main
```

## Annotations

[ANNOTATIONS.md](./ANNOTATIONS.md)

## Citation

[CITATION.cff](./CITATION.cff)

## License

[MIT](./LICENSE)
