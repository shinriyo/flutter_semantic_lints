# AGENTS.md

## Project
Package name: flutter_semantic_lints

Goal:
Detect **meaningless, conflicting, or no-effect Flutter code** using custom lint rules.

This is NOT a style lint package.
This is NOT a best-practices package.

This package enforces **semantic correctness in Flutter UI code**.

---

## Core Philosophy

We detect only:

1. Code that compiles but is **meaningless**
2. Code that is **conflicting**
3. Code that has **no real effect**

We DO NOT detect:
- style issues
- formatting
- naming
- architecture
- preferences

---

## Rule Categories (STRICT)

All rules MUST belong to exactly one category:

### 1. conflicting_parameter
Detect parameter combinations where one overrides or invalidates another.

Examples:
- BoxDecoration(color + gradient)
- Container(color + decoration)

Implemented rules:
- box_decoration_color_gradient
- container_color_decoration

---

### 2. useless_parameter
Detect parameters that are redundant or equal to default values.

Examples:
- Expanded(flex: 1)
- Visibility(visible: true)

Implemented rules:
- expanded_flex_one

---

### 3. no_effect_widget
Detect widgets that do not affect layout, rendering, or behavior.

Examples:
- Opacity(opacity: 1.0)

Implemented rules:
- opacity_one

---

## Architecture Rules

- 1 file = 1 rule
- 1 class = 1 lint rule
- Rule name MUST match lint code
- Each rule must be independently testable
- No shared logic abstraction initially (keep simple)

---

## Folder Structure

lib/
  flutter_semantic_lints.dart
  src/
    plugin.dart
    rules/
      conflicting_parameter/
      useless_parameter/
      no_effect_widget/

---

## Initial Required Rules

The following 4 rules are mandatory:

### conflicting_parameter
- box_decoration_color_gradient
- container_color_decoration

### useless_parameter
- expanded_flex_one

### no_effect_widget
- opacity_one

These 4 rules must be implemented first.

---

## Additional Rules Policy

Additional rules may be implemented only if all conditions below are satisfied:

1. The rule belongs to exactly one of:
   - conflicting_parameter
   - useless_parameter
   - no_effect_widget

2. The rule is almost always correct

3. The rule has near-zero false positives

4. The rule is explainable in one sentence

5. The rule is documented in:
   - AGENTS.md
   - README.md

6. The rule has tests:
   - positive case
   - negative case
   - edge case

If any of the above is not satisfied, do not implement the rule.

---

## Implemented Rules

The current package implements only the MVP rules.

### conflicting_parameter
- box_decoration_color_gradient
- container_color_decoration

### useless_parameter
- expanded_flex_one

### no_effect_widget
- opacity_one

New rules may be added only when they clearly fit one of the three categories
and have near-zero false positives.

---

## Detection Policy

A rule is valid ONLY if:
- It is almost always correct
- It has near-zero false positives
- It is explainable in one sentence

If unsure, DO NOT implement.

---

## Error Message Rules

Each lint MUST include:

- clear problem message
- short explanation
- actionable suggestion

Bad:
"avoid this"

Good:
"Do not use both color and gradient. Color is ignored when gradient is set."

---

## Quick Fix (Future)

Not required for MVP, but design for:

- remove useless parameter
- remove conflicting parameter
- unwrap no-effect widget

---

## Testing Rules

Each rule MUST include:

1. positive case
2. negative case
3. edge case (should NOT trigger)

Current test coverage is in the example project:

- `example/lib/main.dart` contains positive cases with `// expect_lint:`
- `example/lib/negative_cases.dart` contains cases that should not trigger
- `example/lib/edge_cases.dart` contains boundary cases that should not trigger

Run:

```sh
cd example
dart run custom_lint
```

The command should report no issues because expected lints are matched and
negative/edge cases stay quiet.

To manually verify real diagnostics, temporarily remove the `// expect_lint:`
comments from `example/lib/main.dart` and run the same command. The four MVP
rules should be reported.

---

## Current Status

Done:

1. Created custom_lint package
2. Implemented plugin.dart
3. Implemented 4 MVP rules:
   - BoxDecoration conflict
   - Container conflict
   - Expanded(flex: 1)
   - Opacity(1.0)
4. Added example project
5. Verified lint triggers correctly

---

## Coding Principles

- prefer clarity over abstraction
- avoid over-engineering
- write minimal AST checks
- no premature optimization

---

## Release Command Policy

Before suggesting or running pub.dev release/auth commands, verify the actual
Dart executable and available `dart pub` subcommands in the current environment.

Run:

```sh
which dart
dart --version
dart pub --help
```

Do not assume that `dart pub login`, `dart pub logout`, or `dart pub token`
exist for the user's active Dart SDK. Only suggest commands shown by
`dart pub --help` or confirmed by the user.

For release readiness, use:

```sh
dart analyze
cd example
dart run custom_lint
cd ..
dart pub publish --dry-run
```

Only publish after `dart pub publish --dry-run` reports zero warnings.

For actual publishing, use:

```sh
dart pub publish
```

or, if the user explicitly accepts the irreversible publish confirmation:

```sh
dart pub publish --force
```

Publishing is irreversible. Do not create a git release tag until pub.dev
publish succeeds.

If publish fails after OAuth with:

```text
gzip decoder failed: FormatException: Filter error, bad data.
```

treat it as a publish transport/SDK/environment problem, not as proof that the
package archive is invalid. First inspect the real verbose log:

```sh
dart pub publish --force -v
tail -n 80 ~/.pub-cache/log/pub_log.txt
```

Then verify whether the package actually exists:

```sh
curl -i https://pub.dev/api/packages/flutter_semantic_lints
```

If the package is still not published, try a different confirmed Dart SDK,
network, or clean `PUB_CACHE`. Do not invent auth commands.

After a successful `0.1.0` publish, create and push the git tag:

```sh
git tag -a v0.1.0 -m "Release 0.1.0"
git push origin v0.1.0
```

---

## Mindset

Value is NOT number of rules.

Value is:
- correctness
- usefulness
- zero noise
- real-world impact

This is a **precision tool**, not a rule dump.
