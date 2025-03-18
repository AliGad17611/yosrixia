import 'package:flutter/material.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

class InkPainter extends CustomPainter {
  final List<Stroke> strokes;
  final List<StrokePoint> currentPoints;

  InkPainter({required this.strokes, required this.currentPoints});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0
      ..isAntiAlias = true;

    // Draw saved strokes
    for (final stroke in strokes) {
      final points = stroke.points;
      if (points.length < 2) continue;

      // Draw line segments between consecutive points
      for (int i = 0; i < points.length - 1; i++) {
        canvas.drawLine(
          Offset(points[i].x, points[i].y),
          Offset(points[i + 1].x, points[i + 1].y),
          paint,
        );
      }
    }

    // Draw current stroke
    if (currentPoints.length >= 2) {
      for (int i = 0; i < currentPoints.length - 1; i++) {
        canvas.drawLine(
          Offset(currentPoints[i].x, currentPoints[i].y),
          Offset(currentPoints[i + 1].x, currentPoints[i + 1].y),
          paint,
        );
      }
    } else if (currentPoints.length == 1) {
      // For a single point, draw a dot
      canvas.drawCircle(
        Offset(currentPoints[0].x, currentPoints[0].y),
        2.0,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant InkPainter oldDelegate) {
    return oldDelegate.strokes != strokes ||
        oldDelegate.currentPoints != currentPoints;
  }
}
