# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

English | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md) | [Português](README.pt.md) | [हिन्दी + English](README.hi.md) | [Bahasa Indonesia](README.id.md) | [Türkçe](README.tr.md) | [Español](README.es.md) | [العربية](README.ar.md)

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

### `visibility_visible_true`

Bad:

```dart
Visibility(
  visible: true,
  child: child,
)
```

The child is already visible.

Good:

```dart
child
```

Good:

```dart
Visibility(
  visible: isVisible,
  child: child,
)
```

Use `Visibility` when visibility is dynamic.

### `edge_insets_all_zero`

Bad:

```dart
EdgeInsets.all(0)
```

`EdgeInsets.zero` already represents zero insets.

Good:

```dart
EdgeInsets.zero
```

### `border_radius_circular_zero`

Bad:

```dart
BorderRadius.circular(0)
```

`BorderRadius.zero` already represents no radius.

Good:

```dart
BorderRadius.zero
```

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

### `padding_zero`

Bad:

```dart
Padding(
  padding: EdgeInsets.zero,
  child: child,
)
```

No spacing is added.

Good:

```dart
child
```

### `transform_scale_one`

Bad:

```dart
Transform.scale(
  scale: 1.0,
  child: child,
)
```

The child is not scaled.

Good:

```dart
child
```

### `rotated_box_zero_turns`

Bad:

```dart
RotatedBox(
  quarterTurns: 0,
  child: child,
)
```

The child is not rotated.

Good:

```dart
child
```

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
- `visibility_visible_true`
- `edge_insets_all_zero`
- `border_radius_circular_zero`

### `no_effect_widget`

- `opacity_one`
- `padding_zero`
- `transform_scale_one`
- `rotated_box_zero_turns`

## Not Included

These are intentionally not linted yet:

- `Duration.zero`
- `Text('')`
- `SizedBox()`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

They may be meaningful depending on the API or context. This package skips
rules unless they are almost always correct.

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
- Visibility(visible: true)
- EdgeInsets.all(0)
- BorderRadius.circular(0)
- Padding(padding: EdgeInsets.zero)
- Transform.scale(scale: 1.0)
- RotatedBox(quarterTurns: 0)

## Contributing

Only submit rules that:

- are objectively correct
- have near-zero false positives
- are explainable in one sentence

## License

MIT
