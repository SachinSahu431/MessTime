import 'package:client/pages/details/NutrientChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MessCard.dart';
import 'package:fl_chart/fl_chart.dart';

class MessCardDeck extends StatelessWidget {
  const MessCardDeck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0),
      child: Column(children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NutrientChart()),
            );
          },
          child: MessCard('Siddhartha G', 'CS20B040', 'NOVEMBER', '2022'),
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
                ],
              )),
        )
      ]),
    );
  }
}
