import 'package:flutter/material.dart';

Widget negativeCases() {
  return Column(
    children: [
      // OK: container_color_decoration needs both color and decoration.
      Container(color: Colors.red),
      // OK: container_color_decoration needs both color and decoration.
      Container(decoration: const BoxDecoration()),
      DecoratedBox(
        // OK: box_decoration_color_gradient needs both color and gradient.
        decoration: const BoxDecoration(color: Colors.red),
        child: const SizedBox(width: 20, height: 20),
      ),
      const Expanded(
        // OK: expanded_flex_one only flags flex: 1.
        flex: 2,
        child: SizedBox(width: 20, height: 20),
      ),
      const Opacity(
        // OK: opacity_one only flags opacity: 1.0.
        opacity: 0.5,
        child: SizedBox(width: 20, height: 20),
      ),
      Visibility(
        // OK: visibility_visible_true only flags visible: true.
        visible: false,
        child: const SizedBox(width: 20, height: 20),
      ),
      const Padding(
        // OK: padding_zero only flags EdgeInsets.zero.
        padding: EdgeInsets.all(8),
        child: SizedBox(width: 20, height: 20),
      ),
      Transform.scale(
        // OK: transform_scale_one only flags scale: 1.0.
        scale: 2,
        child: const SizedBox(width: 20, height: 20),
      ),
      const RotatedBox(
        // OK: rotated_box_zero_turns only flags quarterTurns: 0.
        quarterTurns: 1,
        child: SizedBox(width: 20, height: 20),
      ),
      const Padding(
        // OK: edge_insets_all_zero only flags EdgeInsets.all(0).
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(width: 20, height: 20),
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          // OK: border_radius_circular_zero only flags circular(0).
          borderRadius: BorderRadius.circular(8),
        ),
        child: const SizedBox(width: 20, height: 20),
      ),
    ],
  );
}
