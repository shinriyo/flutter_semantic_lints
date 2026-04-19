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
          ],
        ),
      ),
    );
  }
}
