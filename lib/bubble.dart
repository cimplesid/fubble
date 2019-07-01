import 'package:flutter/material.dart';
import 'package:fubble/model_logic.dart';

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  Offset offset;
  AnimationController controller;

  BubblePainter({
    this.bubbles,
    this.controller,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    bubbles.forEach((bubble) {
      bubble.draw(canvas, canvasSize);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
