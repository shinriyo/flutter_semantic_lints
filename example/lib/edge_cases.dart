import 'package:flutter/material.dart';

Widget edgeCases({
  required int flex,
  required double opacity,
}) {
  return Column(
    children: [
      Container(
        color: null,
        decoration: const BoxDecoration(),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(
          color: null,
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
          ),
        ),
        child: const SizedBox(width: 20, height: 20),
      ),
      Expanded(
        flex: flex,
        child: SizedBox(
          width: 20,
          height: 20,
          child: Opacity(
            opacity: opacity,
            child: const SizedBox(width: 20, height: 20),
          ),
        ),
      ),
    ],
  );
}
