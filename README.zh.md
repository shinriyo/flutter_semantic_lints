# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | 中文

不是样式 lint。不是格式化 lint。

这个包用于检测语义上没有意义的 Flutter 代码。

---

## 为什么存在

大多数 lint 包关注：

- style
- naming
- best practices

但它们可能会漏掉一个更关键的问题。

代码可以运行，但没有意义。

这个包检测：

- conflicting parameters
- useless parameters
- no-effect widgets

---

## 规则

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

设置 `gradient` 时，`color` 会被忽略。

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

`color` 和 `gradient` 只使用其中一个。

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` 与 `decoration` 冲突。

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

使用 `decoration` 时，把颜色放到 `decoration` 里面。

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

默认值已经是 `1`。

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

当值为 `1` 时省略 `flex`。

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

没有视觉效果，只会增加成本。

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

当值为 `1.0` 时移除 `Opacity`。

## 安装

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## 设置

```yaml
analyzer:
  plugins:
    - custom_lint
```

## 运行

```sh
dart run custom_lint
```

## 理念

- correctness over style
- semantics over formatting
- signal over noise

## 规则分类

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

## 未包含

以下候选规则暂不检测：

- `Duration.zero`
- `Text('')`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

它们可能根据 API 或上下文具有实际含义。

## 测试

example project 同时作为 integration coverage。

```sh
cd example
dart run custom_lint
```

positive case 使用 `// expect_lint:`。negative case 和 edge case 在单独文件中，不应产生 lint。

## 非目标

- style lint
- naming rules
- formatting
- architecture opinions

## 状态

MVP

已实现规则：

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

只提交满足以下条件的规则：

- objectively correct
- near-zero false positives
- explainable in one sentence

## License

MIT
