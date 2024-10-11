import 'dart:math' as math;

import 'package:flutter/material.dart';

class LeftInputBorder extends InputBorder {
  /// Creates a border that draws a line on the left side of the input.
  ///
  /// Similar to [UnderlineInputBorder], but the line is drawn vertically on the left.
  const LeftInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4.0),
      bottomLeft: Radius.circular(4.0),
    ),
  });

  /// The radius for the top-left and bottom-left corners.
  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  LeftInputBorder copyWith(
      {BorderSide? borderSide, BorderRadius? borderRadius}) {
    return LeftInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(left: borderSide.width);
  }

  @override
  LeftInputBorder scale(double t) {
    return LeftInputBorder(borderSide: borderSide.scale(t));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(Rect.fromLTWH(rect.left, rect.top,
          math.max(0.0, rect.width - borderSide.width), rect.height));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint,
      {TextDirection? textDirection}) {
    canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), paint);
  }

  @override
  bool get preferPaintInterior => true;

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is LeftInputBorder) {
      return LeftInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is LeftInputBorder) {
      return LeftInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    if (borderSide.style == BorderStyle.none) {
      return;
    }

    if (borderRadius.topLeft != Radius.zero ||
        borderRadius.bottomLeft != Radius.zero) {
      // Ajuste de anti-aliasing para evitar fugas de color en esquinas redondeadas
      final BorderRadius updatedBorderRadius = BorderRadius.only(
        topLeft: borderRadius.topLeft
            .clamp(maximum: Radius.circular(rect.width / 2)),
        bottomLeft: borderRadius.bottomLeft
            .clamp(maximum: Radius.circular(rect.width / 2)),
      );

      BoxBorder.paintNonUniformBorder(
        canvas,
        rect,
        textDirection: textDirection,
        borderRadius: updatedBorderRadius,
        left: borderSide.copyWith(strokeAlign: BorderSide.strokeAlignInside),
        color: borderSide.color,
      );
    } else {
      final Offset alignInsideOffset = Offset(borderSide.width / 2, 0);
      canvas.drawLine(rect.topLeft - alignInsideOffset,
          rect.bottomLeft - alignInsideOffset, borderSide.toPaint());
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is LeftInputBorder &&
        other.borderSide == borderSide &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius);
}
