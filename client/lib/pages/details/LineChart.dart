import 'package:flutter/material.dart';

class LineChartPage extends StatelessWidget {
  const LineChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xff262545),
      child: ListView(
        children: const <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 36,
                top: 24,
              ),
              child: Text(
                'Calorie Tracker',
                style: TextStyle(
                  color: Color(
                    0xff6f6f97,
                  ),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 28,
              right: 28,
            ),
            child: CalorieData(),
          ),
          SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}
