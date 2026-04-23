# flutter_semantic_lints

[pub.dev](https://pub.dev/packages/flutter_semantic_lints)

[English](README.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Tiếng Việt](README.vi.md) | [中文](README.zh.md) | [Português](README.pt.md) | [हिन्दी + English](README.hi.md) | [Bahasa Indonesia](README.id.md) | [Türkçe](README.tr.md) | Español | [العربية](README.ar.md)

No es un lint de style. No es un lint de formatting.

Este paquete detecta código Flutter sin significado semántico.

---

## Por qué existe

La mayoría de los paquetes de lint se enfocan en:

- style
- naming
- best practices

Pero pueden perder algo crítico:

Código que funciona, pero no tiene sentido.

Este paquete detecta:

- conflicting parameters
- useless parameters
- no-effect widgets

---

## Reglas

### `box_decoration_color_gradient`

Bad:

```dart
BoxDecoration(
  color: Colors.red,
  gradient: LinearGradient(...),
)
```

`color` se ignora cuando `gradient` está definido.

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

Usa `color` o `gradient`, no ambos.

### `container_color_decoration`

Bad:

```dart
Container(
  color: Colors.red,
  decoration: BoxDecoration(...),
)
```

`color` entra en conflicto con `decoration`.

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

Cuando uses `decoration`, mueve el color dentro de `decoration`.

### `expanded_flex_one`

Bad:

```dart
Expanded(flex: 1)
```

El valor predeterminado ya es `1`.

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

Omite `flex` cuando el valor sea `1`.

### `opacity_one`

Bad:

```dart
Opacity(
  opacity: 1.0,
  child: ...,
)
```

No tiene efecto visual. Solo añade costo.

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

Elimina `Opacity` cuando el valor sea `1.0`.

## Instalación

```yaml
dev_dependencies:
  custom_lint:
  flutter_semantic_lints:
```

## Configuración

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Ejecutar

```sh
dart run custom_lint
```

## Configuración de reglas

Todas las reglas están activadas por defecto.

```yaml
custom_lint:
  rules:
    - opacity_one: false
```

## Filosofía

- correctness over style
- semantics over formatting
- signal over noise

## Reglas implementadas

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

## Todavía no incluido

- `Duration.zero`
- `Text('')`
- `foregroundDecoration` combinations
- `InputDecoration` combinations

Pueden tener significado según la API o el contexto.

## License

MIT
