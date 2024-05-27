
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/swede_score/swede_painter.dart';
import 'package:logintimeoutehie/screen/swede_score/swede_touch_model.dart';

class _PizzaWidgetState extends State<PizzaWidget> {
  List<List<Segment>> segments = [];

  List<int> segmentValues = [0, 1, 2, 1, 0];


  List<String> titles = ["Lodine staining", "Aceto uptake", "Margin surface", "Vessels", "Lesion size"];

  // String tappedText = '';
  List<Color> segmentColors = const [
    Color(0xff00C56F),
    Color(0xffFF8C00),
    Color(0xffE74C3C),
  ];

  int centerSum =0;


  @override
  void initState() {
    super.initState();
    _initializeSegments();
    _updateSegments(segmentValues);

  }

  void _initializeSegments() {
    double centerX = 150;
    double centerY = 150;
    double r1 = 150;
    double difference = r1 / 4;
    double r2 = r1 - difference;
    double r3 = r2 - difference;
    double r4 = r3 - difference;
    double startAngle = -pi / 2;

    for (int i = 0; i < 5; i++) {
      double angle1 = startAngle + 2 * pi * i / 5;
      double angle2 = startAngle + 2 * pi * (i + 1) / 5;
      double angleCenter = (angle1 + angle2) / 2;


      segments.add([
        Segment(
          path: Path()
            ..moveTo(centerX + r4 * cos(angle1), centerY + r4 * sin(angle1))
            ..lineTo(centerX + r3 * cos(angle1), centerY + r3 * sin(angle1))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r3),
                angle1,
                angle2 - angle1,
                false)
            ..lineTo(centerX + r4 * cos(angle2), centerY + r4 * sin(angle2))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r4),
                angle2,
                angle1 - angle2,
                false)
            ..close(),
          color: Colors.white,
          hierarchy: 0,
          text: '',
          center: Offset(centerX + (r4 + r3) / 2 * cos(angleCenter), centerY + (r4 + r3) / 2 * sin(angleCenter)),
        ),
        Segment(
          path: Path()
            ..moveTo(centerX + r3 * cos(angle1), centerY + r3 * sin(angle1))
            ..lineTo(centerX + r2 * cos(angle1), centerY + r2 * sin(angle1))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r2),
                angle1,
                angle2 - angle1,
                false)
            ..lineTo(centerX + r3 * cos(angle2), centerY + r3 * sin(angle2))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r3),
                angle2,
                angle1 - angle2,
                false)
            ..close(),
          color: Colors.white,
          hierarchy: 1,
          text: '',
          center: Offset(centerX + (r3 + r2) / 2 * cos(angleCenter), centerY + (r3 + r2) / 2 * sin(angleCenter)),
        ),
        Segment(
          path: Path()
            ..moveTo(centerX + r2 * cos(angle1), centerY + r2 * sin(angle1))
            ..lineTo(centerX + r1 * cos(angle1), centerY + r1 * sin(angle1))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r1),
                angle1,
                angle2 - angle1,
                false)
            ..lineTo(centerX + r2 * cos(angle2), centerY + r2 * sin(angle2))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r2),
                angle2,
                angle1 - angle2,
                false)
            ..close(),
          color: Colors.white,
          hierarchy: 2,
          text: '',
          center: Offset(centerX + (r2 + r1) / 2 * cos(angleCenter), centerY + (r2 + r1) / 2 * sin(angleCenter)),
        ),
      ]);
    }
  }

  void _updateSegments(List<int> segmentValues) {
    setState(() {
      for (int i = 0; i < segmentValues.length; i++) {
        int hierarchy = segmentValues[i];
        for (int j = 0; j < segments[i].length; j++) {
          if (segments[i][j].hierarchy <= hierarchy) {
            segments[i][j].color = segmentColors[hierarchy];
            segments[i][j].text = '';
          } else {
            segments[i][j].color = Colors.white;
            segments[i][j].text = '';
          }
        }
        segments[i][hierarchy].text = hierarchy.toString();
      }
      _calculateCenterSum();
    });
  }

  void _calculateCenterSum() {
    centerSum = 0;
    for (int i = 0; i < segments.length; i++) {
      for (int j = 0; j < segments[i].length; j++) {
        if (segments[i][j].text.isNotEmpty) {
          centerSum += int.parse(segments[i][j].text);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children:[
        CustomPaint(
          size: const Size(300, 300),
          painter: CirclulerChart(segments: segments,centerSum:  centerSum),

        ),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double radius = 170;
              double centerX = 150;
              double centerY = 150;
              double startAngle = -pi / 2;
              return Stack(
                children: List.generate(titles.length, (index) {
                  double angle = startAngle + 2 * pi * index / titles.length;
                  double x = centerX + (radius + 20) * cos(angle);
                  double y = centerY + (radius + 20) * sin(angle);
                  return Positioned(
                    left: x - 20,
                    top: y - 10,
                    child: Text(
                      titles[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),

      ],
    );
  }
}

class PizzaWidget extends StatefulWidget {
  @override
  _PizzaWidgetState createState() => _PizzaWidgetState();
}


//  Below code is circluler chart with clickable events
/*
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/swede_score/swede_painter.dart';
import 'package:logintimeoutehie/screen/swede_score/swede_touch_model.dart';

class PizzaWidget extends StatefulWidget {
  @override
  _PizzaWidgetState createState() => _PizzaWidgetState();
}

class _PizzaWidgetState extends State<PizzaWidget> {
  List<List<Segment>> segments = [];
 // String tappedText = '';
  List<Color> segmentColors = const [
    Color(0xff00C56F),
    Color(0xffFF8C00),
    Color(0xffE74C3C),
  ];

  int centerSum =0;


  @override
  void initState() {
    super.initState();
    _initializeSegments();
  }

  void _initializeSegments() {
    double centerX = 150;
    double centerY = 150;
    double r1 = 150;
    double difference = r1 / 4;
    double r2 = r1 - difference;
    double r3 = r2 - difference;
    double r4 = r3 - difference;
    double startAngle = -pi / 2;

    for (int i = 0; i < 5; i++) {
      double angle1 = startAngle + 2 * pi * i / 5;
      double angle2 = startAngle + 2 * pi * (i + 1) / 5;
      double angleCenter = (angle1 + angle2) / 2;


      segments.add([
        Segment(
          path: Path()
            ..moveTo(centerX + r4 * cos(angle1), centerY + r4 * sin(angle1))
            ..lineTo(centerX + r3 * cos(angle1), centerY + r3 * sin(angle1))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r3),
                angle1,
                angle2 - angle1,
                false)
            ..lineTo(centerX + r4 * cos(angle2), centerY + r4 * sin(angle2))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r4),
                angle2,
                angle1 - angle2,
                false)
            ..close(),
          color: Colors.white,
          hierarchy: 0,
          text: '',
          center: Offset(centerX + (r4 + r3) / 2 * cos(angleCenter), centerY + (r4 + r3) / 2 * sin(angleCenter)),
        ),
        Segment(
          path: Path()
            ..moveTo(centerX + r3 * cos(angle1), centerY + r3 * sin(angle1))
            ..lineTo(centerX + r2 * cos(angle1), centerY + r2 * sin(angle1))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r2),
                angle1,
                angle2 - angle1,
                false)
            ..lineTo(centerX + r3 * cos(angle2), centerY + r3 * sin(angle2))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r3),
                angle2,
                angle1 - angle2,
                false)
            ..close(),
          color: Colors.white,
          hierarchy: 1,
          text: '',
          center: Offset(centerX + (r3 + r2) / 2 * cos(angleCenter), centerY + (r3 + r2) / 2 * sin(angleCenter)),
        ),
        Segment(
          path: Path()
            ..moveTo(centerX + r2 * cos(angle1), centerY + r2 * sin(angle1))
            ..lineTo(centerX + r1 * cos(angle1), centerY + r1 * sin(angle1))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r1),
                angle1,
                angle2 - angle1,
                false)
            ..lineTo(centerX + r2 * cos(angle2), centerY + r2 * sin(angle2))
            ..arcTo(
                Rect.fromCircle(center: Offset(centerX, centerY), radius: r2),
                angle2,
                angle1 - angle2,
                false)
            ..close(),
          color: Colors.white,
          hierarchy: 2,
          text: '',
          center: Offset(centerX + (r2 + r1) / 2 * cos(angleCenter), centerY + (r2 + r1) / 2 * sin(angleCenter)),
        ),
      ]);
    }
  }

  void _onTapSegment(int sliceIndex, int segmentIndex) {
    setState(() {
      int clickedHierarchy = segments[sliceIndex][segmentIndex].hierarchy;

      bool isSelected =
          segments[sliceIndex][segmentIndex].color == segmentColors[segmentIndex];

      switch (clickedHierarchy) {
        case 0:
          segments[sliceIndex][segmentIndex].text = '0';
          break;
        case 1:
          segments[sliceIndex][segmentIndex].text = '1';
          break;
        case 2:
          segments[sliceIndex][segmentIndex].text = '2';
          break;
        default:
          segments[sliceIndex][segmentIndex].text = '';
      }

      for (int i = 0; i < segments[sliceIndex].length; i++) {
        if (i == clickedHierarchy) {
          segments[sliceIndex][i].text = clickedHierarchy == 0
              ? '0'
              : clickedHierarchy == 1
              ? '1'
              : '2';

          segments[sliceIndex][i].color = segmentColors[clickedHierarchy];

        } else {
          segments[sliceIndex][i].text = '';
          segments[sliceIndex][i].color = Colors.white;
        }
      }

      for (var i = 0; i <= clickedHierarchy; i++) {
        if (!isSelected || i == clickedHierarchy) {
          segments[sliceIndex][i].color =
              isSelected ? Colors.white : segmentColors[clickedHierarchy];
        }
      }

      for (var i = clickedHierarchy + 1; i < segments[sliceIndex].length; i++) {
        segments[sliceIndex][i].color = Colors.white;
        segments[sliceIndex][i].text = '';
      }
      centerSum = 0;
      for (int i = 0; i < segments.length; i++) {
        for (int j = 0; j < segments[i].length; j++) {
          if (segments[i][j].text.isNotEmpty) {
            centerSum += segments[i][j].hierarchy;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(details.globalPosition);

        for (int i = 0; i < segments.length; i++) {
          for (int j = 0; j < segments[i].length; j++) {
            if (segments[i][j].path.contains(localPosition)) {
              _onTapSegment(i, j);
              return;
            }
          }
        }
      },
      child: CustomPaint(
        size: const Size(300, 300),
        painter: CirclulerChart(segments: segments,centerSum:  centerSum),
      ),
    );
  }
}


*/
