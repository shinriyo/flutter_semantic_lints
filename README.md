# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

English | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md)

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

## Rules

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`color` is ignored.

Good:

```dart
BoxDecoration(
  color: Colors.red,
)
```

Good:

```dart
BoxDecoration(
  gradient: LinearGradient(...),
)
```

Use either `color` or `gradient`, not both.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` conflicts with `decoration`.

Good:

```dart
Container(
  color: Colors.red,
)
```

Good:

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.red,
  ),
)
```

Move the color into `decoration` when using `decoration`.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

Default value is already `1`.

Good:

```dart
Expanded(
  child: child,
)
```

Good:

```dart
Expanded(
  flex: 2,
  child: child,
)
```

Omit `flex` when the value is `1`.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

No visual effect. Adds cost only.

Good:

```dart
child
```

Good:

```dart
Opacity(
  opacity: 0.5,
  child: child,
)
```

Remove `Opacity` when the value is `1.0`.

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

## Configuration

All rules are enabled by default.

Disable a rule:

```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - opacity_one: false
```

Enable only selected rules:

```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  enable_all_lint_rules: false
  rules:
    - box_decoration_color_gradient
    - container_color_decoration
```

## Philosophy

- correctness over style
- semantics over formatting
- signal over noise

## Rule Categories

### `conflicting_parameter`

- `box_decoration_color_gradient`
- `container_color_decoration`

### `useless_parameter`

- `expanded_flex_one`

### `no_effect_widget`

- `opacity_one`

## Testing

The example project doubles as integration coverage.

```sh
cp example/analysis_options.custom_lint.yaml example/analysis_options.yaml
cd example
dart run custom_lint
```

Positive cases use `// expect_lint:` comments. Negative and edge cases live in
separate example files and should stay quiet.

## Non-goals

- style lint
- naming rules
- formatting
- architecture opinions

## Status

MVP

Implemented rules:

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
