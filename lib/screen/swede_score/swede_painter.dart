import 'package:flutter/material.dart';
import 'dart:math';

import 'package:logintimeoutehie/screen/swede_score/swede_touch_model.dart';

class CirclulerChart extends CustomPainter {
  final List<List<Segment>> segments;
  final int centerSum;

  final TextStyle textStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  List<String> titles = [  "Vessels", "Lesion size","Iodine staining","Aceto uptake", "Margin surface",];

  CirclulerChart({required this.segments, required this.centerSum});

  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill;
    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0XFFEDEDED)
      ..strokeWidth = 2.0;
    paintScoreInsideSegment(fillPaint,borderPaint,canvas);
    paintCenterSum(canvas);
    paintTitles(canvas,size);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void paintScoreInsideSegment( Paint fillPaint,Paint borderPaint,Canvas canvas) {
    for (var slice in segments) {
      for (var segment in slice) {
        fillPaint.color = segment.color;
        canvas.drawPath(segment.path, fillPaint);
        canvas.drawPath(segment.path, borderPaint);
        if (segment.text.isNotEmpty) {
          TextPainter textPainter = TextPainter(
            text: TextSpan(text: segment.text, style: textStyle),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout();
          canvas.save();
          canvas.translate(segment.center.dx, segment.center.dy);
          textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
          canvas.restore();
        }

      }
    }

  }

  void paintCenterSum(Canvas canvas) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(text: centerSum.toString() + "\n", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
          TextSpan(text: "Normal/\n CIN1", style: TextStyle(color: Color(0xff737373), fontWeight: FontWeight.w400, fontSize: 16)),
        ],
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    canvas.save();
    canvas.translate(150, 150);
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();
  }

  void paintTitles(Canvas canvas,Size size) {
    double radius = 175;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double startAngle = -3*pi/2;


    for (int i = 0; i < titles.length; i++) {
      double angle = startAngle + 2 * pi * i / titles.length;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      TextPainter textPainter = TextPainter(
        text: TextSpan(text: titles[i], style: const TextStyle(color: Color(0xff9A9FA7), fontWeight: FontWeight.w400, fontSize: 14)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      canvas.save();
      canvas.translate(x, y);
      i==0?canvas.rotate(angle-pi/2):canvas.rotate(angle + pi / 2);
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }
}
