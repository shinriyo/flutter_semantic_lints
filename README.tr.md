# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md) | [Português](README.pt.md) | [हिन्दी + English](README.hi.md) | [Bahasa Indonesia](README.id.md) | Türkçe | [Español](README.es.md) | [العربية](README.ar.md)

Style lint değildir. Formatting lint değildir.

Bu paket, anlamsal olarak gereksiz Flutter kodunu tespit eder.

---

## Neden var

Çoğu lint paketi şunlara odaklanır:

- style
- naming
- best practices

Ama kritik bir şeyi kaçırabilirler:

Çalışan ama anlamı olmayan kod.

Bu paket şunları tespit eder:

- conflicting parameters
- useless parameters
- no-effect widgets

---

## Kurallar

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`gradient` ayarlandığında `color` yok sayılır.

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

`color` veya `gradient` kullanın, ikisini birlikte kullanmayın.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color`, `decoration` ile çakışır.

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

`decoration` kullanırken rengi `decoration` içine taşıyın.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

Varsayılan değer zaten `1`.

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

Değer `1` ise `flex` yazmayın.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

Görsel etkisi yoktur. Sadece maliyet ekler.

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

Değer `1.0` ise `Opacity` kaldırın.

## Kurulum

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## Ayar

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Çalıştırma

```sh
dart run custom_lint
```

## Kural ayarı

Tüm kurallar varsayılan olarak aktiftir.

```yaml
custom_lint:
  rules:
    - opacity_one: false
```

## Felsefe

- correctness over style
- semantics over formatting
- signal over noise

## License

MIT
