# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md) | [Português](README.pt.md) | [हिन्दी + English](README.hi.md) | [Bahasa Indonesia](README.id.md) | [Türkçe](README.tr.md) | [Español](README.es.md) | العربية

ليس lint للـ style. وليس lint للـ formatting.

هذه الحزمة تكتشف كود Flutter الذي لا يحمل معنى دلاليا.

---

## لماذا توجد

معظم حزم lint تركز على:

- style
- naming
- best practices

لكنها قد تفوت شيئا مهما:

كود يعمل، لكنه لا معنى له.

هذه الحزمة تكتشف:

- conflicting parameters
- useless parameters
- no-effect widgets

---

## القواعد

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

يتم تجاهل `color` عند استخدام `gradient`.

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

استخدم `color` أو `gradient`، وليس الاثنين معا.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` يتعارض مع `decoration`.

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

عند استخدام `decoration`، ضع اللون داخل `decoration`.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

القيمة الافتراضية هي بالفعل `1`.

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

احذف `flex` عندما تكون القيمة `1`.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

لا يوجد أي تأثير بصري. يضيف تكلفة فقط.

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

احذف `Opacity` عندما تكون القيمة `1.0`.

## التثبيت

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## الإعداد

```yaml
analyzer:
  plugins:
    - custom_lint
```

## التشغيل

```sh
dart run custom_lint
```

## إعداد القواعد

كل القواعد مفعلة افتراضيا.

```yaml
custom_lint:
  rules:
    - opacity_one: false
```

## الفلسفة

- correctness over style
- semantics over formatting
- signal over noise

## القواعد المنفذة

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

## غير مضاف حاليا

- `Duration.zero`
- `Text('')`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

قد تكون لهذه الحالات قيمة حسب الـ API أو السياق.

## License

MIT
