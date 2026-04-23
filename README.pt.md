# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md) | Português | [हिन्दी + English](README.hi.md) | [Bahasa Indonesia](README.id.md) | [Türkçe](README.tr.md) | [Español](README.es.md) | [العربية](README.ar.md)

Não é sobre style. Não é sobre formatting.

Este pacote detecta código Flutter sem significado.

---

## Por que existe

A maioria dos pacotes de lint foca em:

- style
- naming
- best practices

Mas eles podem perder algo crítico:

Código que funciona, mas não faz sentido.

Este pacote detecta:

- conflicting parameters
- useless parameters
- no-effect widgets

---

## Regras

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`color` é ignorado quando `gradient` está definido.

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

Use `color` ou `gradient`, não ambos.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` entra em conflito com `decoration`.

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

Ao usar `decoration`, mova a cor para dentro de `decoration`.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

O valor padrão já é `1`.

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

Omita `flex` quando o valor for `1`.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

Não há efeito visual. Apenas adiciona custo.

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

Remova `Opacity` quando o valor for `1.0`.

## Instalação

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## Configuração

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Executar

```sh
dart run custom_lint
```

## Configuração das regras

Todas as regras são ativadas por padrão.

```yaml
custom_lint:
  rules:
    - opacity_one: false
```

## Filosofia

- correctness over style
- semantics over formatting
- signal over noise

## Regras implementadas

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

## Ainda não incluído

- `Duration.zero`
- `Text('')`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

Eles podem ter significado dependendo da API ou do contexto.

## License

MIT
