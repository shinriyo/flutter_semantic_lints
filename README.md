# flutter_semantic_lints

Not style. Not formatting.

This package detects meaningless Flutter code.

---

## Why this exists

Most lint packages focus on:

- style
- naming
- best practices

But they miss something critical:

Code that works but makes no sense.

This package detects:

- conflicting parameters
- useless parameters
- no-effect widgets

---

## Examples

### Conflicting parameters

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`color` is ignored.

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` is ignored.

### Useless parameters

Bad:

```dart
Expanded(flex: 1)
```

Default value is already `1`.

### No-effect widgets

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

No visual effect. Adds cost only.

## Installation

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## Setup

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Run

```sh
dart run custom_lint
```

## Philosophy

- correctness over style
- semantics over formatting
- signal over noise

## Rule Categories

- `conflicting_parameter`
- `useless_parameter`
- `no_effect_widget`

## Non-goals

- style lint
- naming rules
- formatting
- architecture opinions

## Status

MVP

Initial rules:

- BoxDecoration conflict
- Container conflict
- Expanded(flex: 1)
- Opacity(1.0)

## Contributing

Only submit rules that:

- are objectively correct
- have near-zero false positives
- are explainable in one sentence

## License

MIT
