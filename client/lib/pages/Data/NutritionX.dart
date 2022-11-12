import 'dart:async';
import 'dart:convert';
import '../../auth/Secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';

//calorie data from nutrionx api

Future<CalorieData> fetchCalorieData(String foodName) async {
  final response = await http.post(
      Uri.parse('https://trackapi.nutritionix.com/v2/natural/nutrients'),
      headers: {
        'x-app-id': '$myAppId',
        'x-app-key': '$myAppKey',
        'x-remote-user-id': '0'
      },
      body: {
        'query': '$foodName',
      });

  if (response.statusCode == 200) {
    return CalorieData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Calorie Data');
  }
}

class CalorieData {
  final String food_name;
  final String serving_unit;
  final int serving_qty;
  final int nf_calories;
  final int nf_total_fat;
  final int nf_saturated_fat;
  final int nf_cholesterol;
  final int nf_sodium;
  final int nf_total_carbohydrate;
  final int nf_dietary_fiber;
  final int nf_sugars;
  final int nf_protein;
  final int nf_potassium;
  final int nf_p;

  CalorieData(
      {required this.food_name,
      required this.serving_unit,
      required this.serving_qty,
      required this.nf_calories,
      required this.nf_total_fat,
      required this.nf_saturated_fat,
      required this.nf_cholesterol,
      required this.nf_sodium,
      required this.nf_total_carbohydrate,
      required this.nf_dietary_fiber,
      required this.nf_sugars,
      required this.nf_protein,
      required this.nf_potassium,
      required this.nf_p});

  factory CalorieData.fromJson(Map<String, dynamic> json) {
    return CalorieData(
      food_name: json['foods'][0]['food_name'],
      serving_unit: json['foods'][0]['serving_unit'],
      serving_qty: json['foods'][0]['serving_qty'],
      nf_calories: json['foods'][0]['nf_calories'].toInt(),
      nf_total_fat: json['foods'][0]['nf_total_fat'].toInt(),
      nf_saturated_fat: json['foods'][0]['nf_saturated_fat'].toInt(),
      nf_cholesterol: json['foods'][0]['nf_cholesterol'].toInt(),
      nf_sodium: json['foods'][0]['nf_sodium'].toInt(),
      nf_total_carbohydrate: json['foods'][0]['nf_total_carbohydrate'].toInt(),
      nf_dietary_fiber: json['foods'][0]['nf_dietary_fiber'].toInt(),
      nf_sugars: json['foods'][0]['nf_sugars'].toInt(),
      nf_protein: json['foods'][0]['nf_protein'].toInt(),
      nf_potassium: json['foods'][0]['nf_potassium'].toInt(),
      nf_p: json['foods'][0]['nf_p'].toInt(),
    );
  }
}

// nutritionx widget with two parameters

class NutritionX extends StatefulWidget {
  final int day;
  final int meal;

  const NutritionX({Key? key, required this.day, required this.meal})
      : super(key: key);

  @override
  _NutritionXState createState() => _NutritionXState();
}

class _NutritionXState extends State<NutritionX> {
  late Future<CalorieData> futureCalorieData;

  @override
  void initState() {
    super.initState();
    var foodName = "Dal";

    // get food name from menu.dart
    var dayMenu = menu[widget.day];

    if (dayMenu != null) {
      var mealMenu = dayMenu[widget.meal];
      if (mealMenu != null) {
        foodName = mealMenu[0];
      }
    }

    futureCalorieData = fetchCalorieData(foodName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CalorieData>(
      future: futureCalorieData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text(
                snapshot.data!.food_name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Calories: ${snapshot.data!.nf_calories}'),
              Text('Total Fat: ${snapshot.data!.nf_total_fat}'),
              Text('Saturated Fat: ${snapshot.data!.nf_saturated_fat}'),
              Text('Cholesterol: ${snapshot.data!.nf_cholesterol}'),
              Text('Sodium: ${snapshot.data!.nf_sodium}'),
              Text(
                  'Total Carbohydrate: ${snapshot.data!.nf_total_carbohydrate}'),
              Text('Dietary Fiber: ${snapshot.data!.nf_dietary_fiber}'),
              Text('Sugars: ${snapshot.data!.nf_sugars}'),
              Text('Protein: ${snapshot.data!.nf_protein}'),
              Text('Potassium: ${snapshot.data!.nf_potassium}'),
              Text('P: ${snapshot.data!.nf_p}'),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
