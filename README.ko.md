# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | 한국어 | [Tiếng Việt](README.vi.md) | [中文](README.zh.md)

스타일 린트가 아닙니다. 포맷팅 린트도 아닙니다.

이 패키지는 의미 없는 Flutter 코드를 감지합니다.

---

## 왜 필요한가

대부분의 lint 패키지는 다음에 집중합니다.

- style
- naming
- best practices

하지만 중요한 것을 놓칠 때가 있습니다.

동작하지만 의미가 없는 코드입니다.

이 패키지는 다음을 감지합니다.

- conflicting parameters
- useless parameters
- no-effect widgets

---

## 규칙

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`gradient` 가 설정되면 `color` 는 무시됩니다.

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

`color` 와 `gradient` 중 하나만 사용하세요.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` 는 `decoration` 과 충돌합니다.

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

`decoration` 을 사용할 때는 색상을 `decoration` 안으로 옮기세요.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

기본값은 이미 `1` 입니다.

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

값이 `1` 이면 `flex` 를 생략하세요.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

시각적 효과가 없습니다. 비용만 추가됩니다.

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

값이 `1.0` 이면 `Opacity` 를 제거하세요.

## 설치

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## 설정

```yaml
analyzer:
  plugins:
    - custom_lint
```

## 실행

```sh
dart run custom_lint
```

## 철학

- correctness over style
- semantics over formatting
- signal over noise

## 규칙 카테고리

### `conflicting_parameter`

- `box_decoration_color_gradient`
- `container_color_decoration`

### `useless_parameter`

- `expanded_flex_one`

### `no_effect_widget`

- `opacity_one`

## 테스트

example project 는 integration coverage 역할도 합니다.

```sh
cd example
dart run custom_lint
```

positive case 는 `// expect_lint:` 를 사용합니다. negative case 와 edge case 는 별도 파일에 있으며, lint 가 나오지 않아야 합니다.

## 하지 않는 것

- style lint
- naming rules
- formatting
- architecture opinions

## 상태

MVP

구현된 규칙:

- BoxDecoration conflict
- Container conflict
- Expanded(flex: 1)
- Opacity(1.0)

## Contributing

다음 조건을 만족하는 규칙만 제안해 주세요.

- objectively correct
- near-zero false positives
- explainable in one sentence

## License

MIT
