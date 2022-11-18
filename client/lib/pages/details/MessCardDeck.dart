import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:client/pages/details/NutrientChart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MessCard.dart';
import 'package:fl_chart/fl_chart.dart';

class MessCardDeck extends StatefulWidget {
  const MessCardDeck({Key? key}) : super(key: key);

  @override
  State<MessCardDeck> createState() => _MessCardDeckState();
}

class _MessCardDeckState extends State<MessCardDeck> {
  List<String> Calories = ['0', '0', '0', '0', '0', '0', '0'];

  Future<void> getCaloriesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Calories = prefs.getStringList('Calories') ??
          ['0', '0', '0', '0', '0', '0', '0'];
    });
  }

  //init
  @override
  void initState() {
    super.initState();
    getCaloriesList();
  }

  @override
  Widget build(BuildContext context) {
    double getVal() {
      return (double.parse(Calories[4])) / 2500;
    }

    return Container(
      padding: const EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
      child: Column(children: [
        InkWell(
          child: MessCard('Ganesh Priyatham', 'CS20B026', 'DEC', '2022'),
        ),
        Card(
          elevation: 0.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: const Text(
                            "Calorie Analysis",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),

                  // NutrientChart(
                  //     carbPercentage: 20,
                  //     proteinPercentage: 4,
                  //     vitaminPercentage: 36,
                  //     fatPercentage: 40),
                  //display the calories list
                  Container(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 0.0, right: 0.0, bottom: 30.0),
                    height: 200,
                    child: Sparkline(
                      data: Calories.map((e) => double.parse(e)).toList(),
                      lineWidth: 3.0,
                      lineColor: Colors.blue,
                      pointsMode: PointsMode.all,
                      pointSize: 10.0,
                      pointColor: Colors.red,
                      fillMode: FillMode.below,
                      fillColor: Colors.blue[200]!,
                      fillGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.lightGreen[200]!,
                          Colors.lightGreen[50]!
                        ],
                      ),
                      gridLineLabelPrecision: 5,
                      enableGridLines: true,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Daily Calorie Intake",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Calories[4],
                          style: const TextStyle(
                              color: Colors.green, fontSize: 20.0),
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 0, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LinearProgressIndicator(
                          backgroundColor: Colors.redAccent,
                          value: getVal(),
                          minHeight: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        )
      ]),
    );
  }
}
