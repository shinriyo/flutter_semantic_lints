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

---

### 2. useless_parameter
Detect parameters that are redundant or equal to default values.

Examples:
- Expanded(flex: 1)
- Visibility(visible: true)

---

### 3. no_effect_widget
Detect widgets that do not affect layout, rendering, or behavior.

Examples:
- Opacity(opacity: 1.0)

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

## Initial MVP Rules

Implement ONLY these first:

### conflicting_parameter
- box_decoration_color_gradient
- container_color_decoration

### useless_parameter
- expanded_flex_one

### no_effect_widget
- opacity_one

---

## Detection Policy

A rule is valid ONLY if:
- It is almost always correct
- It has near-zero false positives
- It is explainable in one sentence

If unsure → DO NOT implement

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

---

## Coding Principles

- prefer clarity over abstraction
- avoid over-engineering
- write minimal AST checks
- no premature optimization

---

## First Task for Codex

1. Create custom_lint package
2. Implement plugin.dart
3. Implement 4 rules:
   - BoxDecoration conflict
   - Container conflict
   - Expanded(flex:1)
   - Opacity(1.0)
4. Add example project
5. Ensure lint triggers correctly

---

## Mindset

Value is NOT number of rules.

Value is:
- correctness
- usefulness
- zero noise
- real-world impact

This is a **precision tool**, not a rule dump.
