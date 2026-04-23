# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md) | [Português](README.pt.md) | [हिन्दी + English](README.hi.md) | Bahasa Indonesia | [Türkçe](README.tr.md) | [Español](README.es.md) | [العربية](README.ar.md)

Bukan lint untuk style. Bukan lint untuk formatting.

Package ini mendeteksi kode Flutter yang tidak bermakna secara semantik.

---

## Mengapa ada

Sebagian besar package lint fokus pada:

- style
- naming
- best practices

Namun mereka bisa melewatkan hal penting:

Kode yang berjalan, tetapi tidak masuk akal.

Package ini mendeteksi:

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

`color` diabaikan ketika `gradient` digunakan.

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

Gunakan `color` atau `gradient`, jangan keduanya.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` bertentangan dengan `decoration`.

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

Saat memakai `decoration`, pindahkan warna ke dalam `decoration`.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

Nilai default sudah `1`.

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

Hilangkan `flex` ketika nilainya `1`.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

Tidak ada efek visual. Hanya menambah biaya.

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

Hapus `Opacity` ketika nilainya `1.0`.

## Instalasi

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

## Jalankan

```sh
dart run custom_lint
```

## Konfigurasi rule

Semua rule aktif secara default.

```yaml
custom_lint:
  rules:
    - opacity_one: false
```

## Filosofi

- correctness over style
- semantics over formatting
- signal over noise

## Rule yang sudah diimplementasikan

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

## Belum termasuk

- `Duration.zero`
- `Text('')`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

Hal-hal ini bisa bermakna tergantung API atau konteks.

## License

MIT
