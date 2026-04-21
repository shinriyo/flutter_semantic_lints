import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.red,
              // expect_lint: container_color_decoration
              decoration: const BoxDecoration(),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.red,
                // expect_lint: box_decoration_color_gradient
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.blue],
                ),
              ),
              child: const SizedBox(width: 100, height: 100),
            ),
            Expanded(
              // expect_lint: expanded_flex_one
              flex: 1,
              child: Opacity(
                // expect_lint: opacity_one
                opacity: 1.0,
                child: Container(color: Colors.green),
              ),
            ),
            Visibility(
              // expect_lint: visibility_visible_true
              visible: true,
              child: const SizedBox(width: 20, height: 20),
            ),
            Padding(
              // expect_lint: padding_zero
              padding: EdgeInsets.zero,
              child: const SizedBox(width: 20, height: 20),
            ),
            Transform.scale(
              // expect_lint: transform_scale_one
              scale: 1.0,
              child: const SizedBox(width: 20, height: 20),
            ),
            RotatedBox(
              // expect_lint: rotated_box_zero_turns
              quarterTurns: 0,
              child: const SizedBox(width: 20, height: 20),
            ),
            Padding(
              // expect_lint: edge_insets_all_zero
              padding: EdgeInsets.all(0),
              child: const SizedBox(width: 20, height: 20),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                // expect_lint: border_radius_circular_zero
                borderRadius: BorderRadius.circular(0),
              ),
              child: const SizedBox(width: 20, height: 20),
            ),
          ],
        ),
      ),
    );
  }
}
