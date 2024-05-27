import 'dart:ui';

class Segment {
  Path path;
  Color color;
  int hierarchy;
  String text;
  Offset center;

  Segment({
    required this.path,
    required this.color,
    required this.hierarchy,
    required this.text,
    required this.center,
  });
}
