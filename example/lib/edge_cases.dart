import 'package:flutter/material.dart';

Widget edgeCases({
  required int flex,
  required double opacity,
  required bool visible,
  required EdgeInsets padding,
  required double scale,
  required int quarterTurns,
  required double radius,
  required Key key,
}) {
  return Column(
    children: [
      Container(
        // OK: container_color_decoration ignores an explicit null color.
        color: null,
        decoration: const BoxDecoration(),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(
          // OK: box_decoration_color_gradient ignores an explicit null color.
          color: null,
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
          ),
        ),
        child: const SizedBox(width: 20, height: 20),
      ),
      Expanded(
        // OK: expanded_flex_one only flags a literal 1.
        flex: flex,
        child: SizedBox(
          width: 20,
          height: 20,
          child: Opacity(
            // OK: opacity_one only flags a literal 1.0.
            opacity: opacity,
            child: const SizedBox(width: 20, height: 20),
          ),
        ),
      ),
      Visibility(
        // OK: visibility_visible_true only flags a literal true.
        visible: visible,
        child: const SizedBox(width: 20, height: 20),
      ),
      Padding(
        // OK: padding_zero only flags EdgeInsets.zero.
        padding: padding,
        child: const SizedBox(width: 20, height: 20),
      ),
      Transform.scale(
        // OK: transform_scale_one only flags a literal 1.0.
        scale: scale,
        child: const SizedBox(width: 20, height: 20),
      ),
      RotatedBox(
        // OK: rotated_box_zero_turns only flags a literal 0.
        quarterTurns: quarterTurns,
        child: const SizedBox(width: 20, height: 20),
      ),
      Padding(
        // OK: edge_insets_all_zero only flags a literal all(0).
        padding: EdgeInsets.all(radius),
        child: const SizedBox(width: 20, height: 20),
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          // OK: border_radius_circular_zero only flags a literal circular(0).
          borderRadius: BorderRadius.circular(radius),
        ),
        child: const SizedBox(width: 20, height: 20),
      ),
      // OK: empty_sized_box only flags calls with no arguments.
      SizedBox(key: key),
    ],
  );
}
