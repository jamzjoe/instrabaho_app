import 'package:flutter/material.dart';

class GradientBorder extends Border {
  final Gradient borderGradient;
  final double width;

  const GradientBorder({
    this.width = 0.0,
    required this.borderGradient,
  }) : super();

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (isUniform) {
      switch (shape) {
        case BoxShape.circle:
          assert(
            borderRadius == null,
            'A borderRadius can only be given for rectangular boxes.',
          );
          _paintGradientBorderWithCircle(canvas, rect);
          break;
        case BoxShape.rectangle:
          if (borderRadius != null) {
            _paintGradientBorderWithRadius(canvas, rect, borderRadius);
            return;
          }
          _paintGradientBorderWithRectangle(canvas, rect);
          break;
      }
      return;
    }
  }

  void _paintGradientBorderWithRadius(
      Canvas canvas, Rect rect, BorderRadius borderRadius) {
    final Paint paint = Paint();
    final RRect outer = borderRadius.toRRect(rect.inflate(width / 2.0));

    paint.shader = borderGradient.createShader(outer.outerRect);

    if (width == 0.0) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.0;
      canvas.drawRRect(outer, paint);
    } else {
      final RRect inner = outer.deflate(width);
      canvas.drawDRRect(outer, inner, paint);
    }
  }

  void _paintGradientBorderWithCircle(Canvas canvas, Rect rect) {
    final double radius = (rect.shortestSide + width) / 2.0;
    final Paint paint = Paint();
    paint
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..shader = borderGradient
          .createShader(Rect.fromCircle(center: rect.center, radius: radius));

    canvas.drawCircle(rect.center, radius, paint);
  }

  void _paintGradientBorderWithRectangle(Canvas canvas, Rect rect) {
    final Paint paint = Paint();
    paint
      ..strokeWidth = width
      ..shader = borderGradient.createShader(rect.inflate(width / 2.0))
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect.inflate(width / 2.0), paint);
  }

  factory GradientBorder.uniform({
    Gradient gradient = const LinearGradient(colors: [Color(0x00000000)]),
    double width = 1.0,
  }) {
    return GradientBorder._fromUniform(gradient, width);
  }

  const GradientBorder._fromUniform(Gradient gradient, this.width)
      : assert(width >= 0.0),
        borderGradient = gradient;
}
