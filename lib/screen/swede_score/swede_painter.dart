import 'package:flutter/material.dart';
import 'dart:math';

import 'package:logintimeoutehie/screen/swede_score/swede_touch_model.dart';

class CirclulerChart extends CustomPainter {
  final List<List<Segment>> segments;
  final int centerSum;

  final TextStyle textStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  List<String> titles = ["Lodine staining", "Aceto uptake", "Margin surface", "Vessels", "Lesion size"];



  CirclulerChart({required this.segments, required this.centerSum});

  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill;
    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0XFFEDEDED)
      ..strokeWidth = 2.0;

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


        TextPainter textPainter = TextPainter(
          text: TextSpan(text: centerSum.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        canvas.save();
        canvas.translate(150, 150);
        textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
        canvas.restore();

      }
    }
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/*
import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/swede_score/swede_touch_model.dart';

class PizzaPainter extends CustomPainter {
  final List<List<Segment>> segments;
  final TextStyle textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold); // TextStyle for text

  PizzaPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0XFFEDEDED)
      ..strokeWidth = 2.0;

    for (var slice in segments) {
      for (var segment in slice) {
        fillPaint.color = segment.color;
        canvas.drawPath(segment.path, fillPaint);
        canvas.drawPath(segment.path, borderPaint);

        // Draw text inside the segment
        TextPainter textPainter = TextPainter(
          text: TextSpan(text: segment.text, style: textStyle),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, segment.path.getBounds().center - Offset(textPainter.width / 2, textPainter.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
*/
