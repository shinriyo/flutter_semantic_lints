import 'package:flutter/material.dart';

Widget edgeCases({
  required int flex,
  required double opacity,
  required bool visible,
  required EdgeInsets padding,
  required double scale,
  required int quarterTurns,
  required double radius,
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
      Visibility(
        visible: visible,
        child: const SizedBox(width: 20, height: 20),
      ),
      Padding(
        padding: padding,
        child: const SizedBox(width: 20, height: 20),
      ),
      Transform.scale(
        scale: scale,
        child: const SizedBox(width: 20, height: 20),
      ),
      RotatedBox(
        quarterTurns: quarterTurns,
        child: const SizedBox(width: 20, height: 20),
      ),
      Padding(
        padding: EdgeInsets.all(radius),
        child: const SizedBox(width: 20, height: 20),
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: const SizedBox(width: 20, height: 20),
      ),
    ],
  );
}
