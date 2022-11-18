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
    return Container(
      padding: const EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
      child: Column(children: [
        InkWell(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => NutrientChart()),
          //   );
          // },
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
                    children: const [
                      Text(
                        "Nutrient Analysis",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "20/30",
                        style: TextStyle(color: Colors.green, fontSize: 20.0),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                  NutrientChart(
                      carbPercentage: 20,
                      proteinPercentage: 4,
                      vitaminPercentage: 36,
                      fatPercentage: 40),
                  //display the calories list
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Calories",
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
                ],
              )),
        )
      ]),
    );
  }
}
