# VERSION.md

## Alpha 2 (`0.1.1-alpha`)

**Release Type:** Alpha (Patch)  
**Audience:** Contributors and early implementors  
**Stability:** Alpha (architecture unchanged; clarifications and artifacts added)

---

## Purpose of This Version

`0.1.1-alpha` is a **patch release** to the initial Alpha version.

This version exists to:

- Correct minor documentation issues discovered during early Alpha use
- Add non-normative visual artifacts to support conceptual understanding
- Improve internal consistency of versioning and changelog records

No new architectural concepts, rules, or behaviors are introduced in this release.

---

## Documentation Changes

- Corrected `docs/ABSTRACT.md` by removing unintended templating artifacts
- Updated `VERSION.md` to reflect the `0.1.1-alpha` patch
- Updated `docs/CHANGELOG.md` to comprehensively record changes across all releases

---

## Artifacts Directory Update

This version adds illustrative schema artifacts to `./artifacts/`:

- `schema.puml`
- `schema.svg`

These artifacts are **reference-only** and do not define or constrain implementations.  
They exist solely to aid understanding of relationships described in the documentation.

---

## Compatibility Notes

- Fully compatible with `0.1.0-alpha`
- No breaking changes
- No semantic or ontological shifts
- All Alpha lifecycle guarantees and limitations remain unchanged

---

## Alpha 1 (`0.1.0-alpha`)

**Release Type:** Alpha  
**Audience:** Contributors and early implementors beginning active testing and experimentation  
**Stability:** Alpha (architecture considered stable; changes remain possible)

---

## Purpose of This Version

`0.1.0-alpha` marks the transition from Pre-Alpha drafts to an Alpha phase where the project is ready for **external testing and contribution** against a more stable conceptual baseline.

This version exists to:

- Establish Alpha readiness for contributor review and testing
- Provide a clear gateway (`README.md`) and stable documentation set in `docs/`
- Introduce a minimal example implementation artifact to support experimentation without prescribing implementations

---

## Documentation

Authoritative documents for this version:

- `docs/ABSTRACT.md`
- `docs/ARCHITECTURE.md`
- `docs/CONTRIBUTING.md`
- `docs/VERSIONING.md`
- `docs/RELEASING.md`

---

## Example Implementation Artifacts

This version introduces an **example implementation** under `./src/`:

- `build.sh`  
  A repository tool that generates an example `./src/System` artifact.

- `./src/System`  
  A generated example representation intended to support exploration and testing.
  It is not required for using or understanding The System, and it does not define the ontology.
  It is one possible representation produced by one build tool in this repository.

No guarantees are made about what this example captures, what it contains, or what can be inferred from it. Any semantics, quality statements, or claims of veracity must be represented explicitly by operators within the Elements/Properties/Rules of their chosen implementation.

---

## Artifacts Directory Policy

The `./artifacts/` directory may be empty in a given version. It exists to hold version-specific or cross-version build artifacts when applicable. For this release, it is intentionally empty (retained in Git via a placeholder file).

---

## Known Limitations (Accepted for Alpha)

- The ontology remains documentation-first; no canonical runtime exists
- The example implementation is illustrative, not normative
- Terminology and phrasing may continue to be refined
- Backward compatibility remains best-effort during Alpha

---

## Compatibility Notes

- Alpha versions follow the project’s lifecycle rules in `docs/VERSIONING.md`
- This release is intended for early adopters and contributors, not prescriptive of outcomes
- Changes may occur within Alpha, but the architecture is treated as stable enough for active contribution
