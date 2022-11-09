import 'indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NutrientChart extends StatefulWidget {
  int carbPercentage;
  int proteinPercentage;
  int vitaminPercentage;
  int fatPercentage;

  NutrientChart(
      {this.carbPercentage = 25,
      this.proteinPercentage = 25,
      this.vitaminPercentage = 25,
      this.fatPercentage = 25,
      Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => NutrientChartState();
}

class NutrientChartState extends State<NutrientChart> {
  Color carbColor = Colors.red;
  Color proteinColor = Colors.green;
  Color vitaminColor = Colors.blue;
  Color fatColor = Colors.orange;

  int curr_index = -1;

  @override
  Widget build(BuildContext context) {
    // print("Building Nutrient Chart");
    // print(widget.carbPercentage);
    // print(widget.proteinPercentage);
    // print(widget.vitaminPercentage);
    // print(widget.fatPercentage);

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            curr_index = -1;
                            return;
                          }
                          curr_index = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(
                        widget.carbPercentage,
                        widget.proteinPercentage,
                        widget.vitaminPercentage,
                        widget.fatPercentage),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: carbColor,
                  text: 'Carbohydrates',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: proteinColor,
                  text: 'Proteins',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: vitaminColor,
                  text: 'Vitamins',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: fatColor,
                  text: 'Fats',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(int carbPercentage,
      int proteinPercentage, int vitaminPercentage, int fatPercentage) {
    return List.generate(4, (i) {
      final isTouched = i == curr_index;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: carbColor,
            value: carbPercentage.toDouble(),
            title: '$carbPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: proteinColor,
            value: proteinPercentage.toDouble(),
            title: '$proteinPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: vitaminColor,
            value: vitaminPercentage.toDouble(),
            title: '$vitaminPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: fatColor,
            value: fatPercentage.toDouble(),
            title: '$fatPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
