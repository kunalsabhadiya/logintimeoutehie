import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/login.dart';
import 'package:logintimeoutehie/screen/swede_score/patient_card_data.dart';
import 'package:logintimeoutehie/screen/swede_score/swede_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int score = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Color(0xffF8F8F8),
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                      content: const Text('Are you sure you want to logout?'),
                      title: const Text('Logout'),
                      elevation: 24.0,
                      actionsPadding: const EdgeInsets.all(8.0),
                      actionsOverflowDirection: VerticalDirection.down,
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setBool("isLoggedIn", false);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ));
                            },
                            child: const Text('Logout')),
                      ]));
        },
        child: const Icon(Icons.logout),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(34.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: PizzaWidget(),
              ),
            ),
            DetailPatientCard(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Parameter')),
                  DataColumn(label: Text('Score')),
                  DataColumn(label: Text('Observation')),
                ],
                dataRowMaxHeight: 60,
                columnSpacing: 20,
                dataRowColor: MaterialStateProperty.all(Colors.white),
                dividerThickness: 0,
                headingRowColor:
                    MaterialStateProperty.all(Colors.grey.shade200),
                headingTextStyle: const TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                rows: [
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Row(
                        children: [
                          Image.asset('images/assets/img_1.png',
                              width: 35, height: 35),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Aceto uptake'),
                        ],
                      )),
                      const DataCell(Text('0')),
                      const DataCell(Text('Zero or transparent')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Row(
                        children: [
                          Image.asset(
                            'images/assets/img_2.png',
                            width: 35,
                            height: 35,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Margins/Surface'),
                        ],
                      )),
                      DataCell(Text('1')),
                      DataCell(Text('Sharp, geographical satellites')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Row(
                        children: [
                          Image.asset(
                            'images/assets/img_3.png',
                            width: 35,
                            height: 35,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Vessels'),
                        ],
                      )),
                      DataCell(Text('2')),
                      DataCell(Text('Coarse or atypical')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Row(
                        children: [
                          Image.asset(
                            'images/assets/img_4.png',
                            width: 35,
                            height: 35,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Lesion size'),
                        ],
                      )),
                      DataCell(Text('1')),
                      DataCell(Text('5 - 15mm or 2 quadrants')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Row(
                        children: [
                          Image.asset(
                            'images/assets/img_5.png',
                            width: 35,
                            height: 35,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Iodine staining'),
                        ],
                      )),
                      DataCell(Text('0')),
                      DataCell(Text('Brown')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Summary',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                )),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '4',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 44),
                        ),
                        Text(
                          'Final Score',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                  )),
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Normal1/CNF1',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        (score >= 0 && score <= 4)
                            ? Container(
                                color: Colors.white,
                                height: 20,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  80) /
                                              3,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff00C56F),
                                      ),
                                    ),
                                    Positioned(
                                      left: score *
                                          ((MediaQuery.of(context).size.width -
                                                  80) /
                                              3) /
                                          5,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xff00C56F),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width:
                                    (MediaQuery.of(context).size.width - 80) /
                                        3,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xff00C56F),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        const Center(
                            child: Text(
                          '0 - 4',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        )),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        (score >= 5 && score <= 6)
                            ? Container(
                                color: Colors.white,
                                height: 20,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  80) /
                                              3,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffFF8C00),
                                      ),
                                    ),
                                    Positioned(
                                      left: (score - 5) *
                                          ((MediaQuery.of(context).size.width -
                                                  80) /
                                              3) /
                                          2,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xffFF8C00),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width:
                                    (MediaQuery.of(context).size.width - 80) /
                                        3,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffFF8C00),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        const Center(
                            child: Text(
                          '5 - 6',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        )),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        (score >= 7 && score <= 10)
                            ? Container(
                                color: Colors.white,
                                height: 20,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  80) /
                                              3,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xffE74C3C),
                                      ),
                                    ),
                                    Positioned(
                                      left: (score - 7) *
                                          ((MediaQuery.of(context).size.width -
                                                  80) /
                                              3) /
                                          4,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xffE74C3C),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                              width:
                                  (MediaQuery.of(context).size.width - 80) /
                                      3,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xffE74C3C),
                              ),
                            ),
                        SizedBox(
                          height: 10,
                        ),
                        const Center(
                            child: Text(
                          '7 - 10',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(  16.0, 0, 16.0, 0),
              child: Text(
                textAlign: TextAlign.justify,
                '«Normal» indicates that there are no significant abnormalities observed in the colposcopic examination. The cervical tissues appear to be within the normal range. Cervical Intraepithelial Neoplasia 1 suggests the presence of mild dysplasia or mild abnormal changes in the cells of the cervix. CIN1 is considered a low-grade lesion, and it often indicates early, mild abnormalities that may resolve on their own. Monitoring or further evaluation may be recommended rather than immediate treatment.',
                style: TextStyle(color: Color(0xff9A9FA7), fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff72C9FE),
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.download_for_offline_outlined,), iconSize: 24,),
                IconButton(onPressed: (){}, icon: Icon(Icons.share), iconSize: 24,),

              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
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
