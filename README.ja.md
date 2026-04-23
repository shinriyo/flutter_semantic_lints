# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | 日本語 | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md)

スタイルではありません。フォーマットでもありません。

このパッケージは、意味のない Flutter コードを検出します。

---

## なぜ存在するのか

多くの lint パッケージは次のようなものに注目します。

- style
- naming
- best practices

しかし、もっと重要なものを見落とすことがあります。

動くけれど、意味がないコードです。

このパッケージは次のようなコードを検出します。

- conflicting parameters
- useless parameters
- no-effect widgets

---

## ルール

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`gradient` がある場合、`color` は無視されます。

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

`color` と `gradient` はどちらか一方だけを使います。

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` は `decoration` と競合します。

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

`decoration` を使う場合は、色を `decoration` の中に移動します。

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

デフォルト値はすでに `1` です。

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

値が `1` の場合、`flex` は省略します。

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

見た目に影響がありません。コストだけが増えます。

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

値が `1.0` の場合、`Opacity` を取り除きます。

## インストール

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## セットアップ

```yaml
analyzer:
  plugins:
    - custom_lint
```

## 実行

```sh
dart run custom_lint
```

## 方針

- correctness over style
- semantics over formatting
- signal over noise

## ルールカテゴリ

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

## 未実装

次の候補はまだ lint しません。

- `Duration.zero`
- `Text('')`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

API や文脈によって意味を持つ可能性があるためです。

## テスト

example project は integration coverage も兼ねています。

```sh
cd example
dart run custom_lint
```

positive case は `// expect_lint:` を使います。negative case と edge case は別ファイルにあり、lint が出ないことを確認します。

## 対象外

- style lint
- naming rules
- formatting
- architecture opinions

## ステータス

MVP

実装済みルール:

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
- SizedBox()

## Contributing

次の条件を満たすルールだけを送ってください。

- objectively correct
- near-zero false positives
- explainable in one sentence

## License

MIT
