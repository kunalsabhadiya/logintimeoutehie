
import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/login.dart';
import 'package:logintimeoutehie/screen/swede_score/swede_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<StatefulWidget> createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swede Score'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context,barrierDismissible: false, builder: (context) => AlertDialog(
            content: const Text('Are you sure you want to logout?'),
            title: const Text('Logout'),
            elevation: 24.0,
            actionsPadding: const EdgeInsets.all(8.0),
            actionsOverflowDirection: VerticalDirection.down,
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Cancel')),
              TextButton(onPressed: () async{
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setBool("isLoggedIn", false);
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login(),));
              }, child: const Text('Logout')),
            ]
          ));
        },
        child: const Icon(Icons.logout),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width/1.2,
            height: MediaQuery.of(context).size.height,
            child:  PizzaWidget(),
          ),
        )

      ),
    );
  }

  }

/*
class CircularChart extends StatefulWidget {
  @override
  _CircularChartState createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  List<int> segmentValues = [0, 0, 0, 0, 0];
  int totalScore = 0;

  void _updateSegment(int index) {
    setState(() {
      segmentValues[index] = (segmentValues[index] + 1) % 3;
      totalScore = segmentValues.reduce((a, b) => a + b);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        RenderObject? renderBox = context.findRenderObject();
        Offset localPosition = renderBox?.globalToLocal(details.globalPosition);

        int touchedSegment = _getTouchedSegment(localPosition);
        if (touchedSegment != -1) {
          _updateSegment(touchedSegment);
        }
      },
      child: CustomPaint(
        size: Size(300, 300),
        painter: CircularChartPainter(segmentValues, totalScore),
      ),
    );
  }

  int _getTouchedSegment(Offset position) {
    // Logic to determine which segment was touched based on the position
    double dx = position.dx - 150;
    double dy = position.dy - 150;
    double angle = (dy).atan2(dx);
    double angleInDegrees = angle * (180 / 3.141592653589793);

    if (angleInDegrees < 0) angleInDegrees += 360;

    if (position.distance <= 150 && position.distance >= 100) {
      if (angleInDegrees >= 0 && angleInDegrees < 72) return 0;
      if (angleInDegrees >= 72 && angleInDegrees < 144) return 1;
      if (angleInDegrees >= 144 && angleInDegrees < 216) return 2;
      if (angleInDegrees >= 216 && angleInDegrees < 288) return 3;
      if (angleInDegrees >= 288 && angleInDegrees < 360) return 4;
    }

    return -1;
  }
}*/

/*
class CircularChartPainter extends CustomPainter {
  final List<int> segmentValues;
  final int totalScore;
  final List<Color> colors = [Colors.green, Colors.orange, Colors.red];

  CircularChartPainter(this.segmentValues, this.totalScore);

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 150;
    double innerRadius = 100;
    double angle = (2 * 3.141592653589793) / 5;

    Paint paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 5; i++) {
      paint.color = colors[segmentValues[i]];
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        i * angle,
        angle,
        true,
        paint,
      );
    }

    paint.color = Colors.white;
    canvas.drawCircle(Offset(radius, radius), innerRadius, paint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: totalScore.toString(),
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(radius - textPainter.width / 2, radius - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CircularChartPainter oldDelegate) {
    return oldDelegate.segmentValues != segmentValues || oldDelegate.totalScore != totalScore;
  }
}*/
