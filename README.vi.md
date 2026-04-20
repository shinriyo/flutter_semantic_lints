# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | Tiếng Việt | [中文](README.zh.md)

Không phải lint về style. Không phải lint về formatting.

Gói này phát hiện mã Flutter vô nghĩa về mặt ngữ nghĩa.

---

## Vì sao gói này tồn tại

Phần lớn các gói lint tập trung vào:

- style
- naming
- best practices

Nhưng chúng có thể bỏ sót một điều quan trọng.

Mã vẫn chạy, nhưng không có ý nghĩa.

Gói này phát hiện:

- conflicting parameters
- useless parameters
- no-effect widgets

---

## Quy tắc

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`color` bị bỏ qua khi có `gradient`.

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

Chỉ dùng một trong hai: `color` hoặc `gradient`.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` xung đột với `decoration`.

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

Khi dùng `decoration`, hãy đưa màu vào trong `decoration`.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

Giá trị mặc định đã là `1`.

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

Bỏ `flex` khi giá trị là `1`.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

Không có hiệu ứng hiển thị. Chỉ tăng chi phí.

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

Loại bỏ `Opacity` khi giá trị là `1.0`.

## Cài đặt

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## Thiết lập

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Chạy

```sh
dart run custom_lint
```

## Triết lý

- correctness over style
- semantics over formatting
- signal over noise

## Nhóm quy tắc

### `conflicting_parameter`

- `box_decoration_color_gradient`
- `container_color_decoration`

### `useless_parameter`

- `expanded_flex_one`

### `no_effect_widget`

- `opacity_one`

## Kiểm thử

example project cũng đóng vai trò integration coverage.

```sh
cd example
dart run custom_lint
```

Positive case dùng `// expect_lint:`. Negative case và edge case nằm trong các file riêng và không được phát sinh lint.

## Không hướng tới

- style lint
- naming rules
- formatting
- architecture opinions

## Trạng thái

MVP

Quy tắc đã triển khai:

- BoxDecoration conflict
- Container conflict
- Expanded(flex: 1)
- Opacity(1.0)

## Contributing

Chỉ gửi quy tắc đáp ứng các điều kiện sau:

- objectively correct
- near-zero false positives
- explainable in one sentence

## License

MIT
