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
      Visibility(
        visible: false,
        child: const SizedBox(width: 20, height: 20),
      ),
      const Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(width: 20, height: 20),
      ),
      Transform.scale(
        scale: 2,
        child: const SizedBox(width: 20, height: 20),
      ),
      const RotatedBox(
        quarterTurns: 1,
        child: SizedBox(width: 20, height: 20),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(width: 20, height: 20),
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const SizedBox(width: 20, height: 20),
      ),
    ],
  );
}
