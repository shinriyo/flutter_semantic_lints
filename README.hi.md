# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md) | [Português](README.pt.md) | हिन्दी + English | [Bahasa Indonesia](README.id.md) | [Türkçe](README.tr.md) | [Español](README.es.md) | [العربية](README.ar.md)

यह style lint नहीं है। यह formatting lint भी नहीं है।

यह package semantically meaningless Flutter code detect करता है।

---

## यह क्यों है

Most lint packages focus करते हैं:

- style
- naming
- best practices

लेकिन वे एक important चीज़ miss कर सकते हैं:

Code जो चलता है, पर उसका कोई real meaning नहीं होता।

यह package detect करता है:

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

`gradient` set होने पर `color` ignored होता है।

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

`color` या `gradient` में से सिर्फ एक use करें।

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` और `decoration` conflict करते हैं।

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

`decoration` use करते समय color को `decoration` के अंदर रखें।

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

Default value पहले से `1` है।

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

जब value `1` हो, `flex` omit करें।

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

कोई visual effect नहीं है। सिर्फ cost add होती है।

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

Value `1.0` हो तो `Opacity` remove करें।

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

## Rule configuration

All rules default में enabled हैं।

```yaml
custom_lint:
  rules:
    - opacity_one: false
```

## Philosophy

- correctness over style
- semantics over formatting
- signal over noise

## Implemented rules

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
- `empty_sized_box`

## Not included yet

- `Duration.zero`
- `Text('')`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

ये API या context के हिसाब से meaningful हो सकते हैं।

## License

MIT
