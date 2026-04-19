import 'package:flutter/material.dart';

Widget negativeCases() {
  return Column(
    children: [
      Container(color: Colors.red),
      Container(decoration: const BoxDecoration()),
      DecoratedBox(
        decoration: const BoxDecoration(color: Colors.red),
        child: const SizedBox(width: 20, height: 20),
      ),
      const Expanded(
        flex: 2,
        child: SizedBox(width: 20, height: 20),
      ),
      const Opacity(
        opacity: 0.5,
        child: SizedBox(width: 20, height: 20),
      ),
    ],
  );
}
