import 'package:flutter/material.dart';
import 'package:flutter_limited_checkbox/flutter_limited_checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/NutritionX.dart';
import '../Data/menu.dart';
import '../DisplayMenu.dart';
import 'MessCardDeck.dart';
import '../../main.dart';

var calorie = {
  "Omelette": 323,
  "Bread": 77,
  "Butter": 101,
  "Jam": 55,
  "Tea": 50,
  "Coffee": 2,
  "Milk": 122,
  "Banana": 105,
  "Moong": 212,
  "Idli": 58,
  "Vada": 134,
  "Sambhar": 259,
  "Rice": 205,
  "Dal": 221,
  "Salad": 19,
  "Roti": 119,
  "Curd": 69,
  "Mixed veg": 45,
  "Brinjal": 198,
  "Ladyfinger": 50,
  "Egg": 71,
  "Korma": 460,
  "Rasam": 64,
  "Suji halwa": 317,
  "Kheer": 131,
  "Crisps": 148,
  "Upma": 132,
  "Aloo curry": 204,
  "poori": 140,
  "Sprouts": 7,
  "Bitter gourd": 23,
  "Tomato curry": 172,
  "Soya bean": 295,
  "Dum aloo": 50,
  "Ice cream": 273,
  "Pickle": 4,
  "Poha": 157,
  "Rajma": 252,
  "Dal Makhani": 426,
  "Chicken curry": 243,
  "Paneer": 364,
  "Aloo paratha": 300,
  "Beetroot": 22,
  "Aloo matar": 50,
  "Manchurian": 50,
  "Drumstick curry": 136,
  "Khichdi": 238,
  "Pongal": 318,
  "Chutney": 20,
  "Raita": 31,
  "Chole bhature": 510,
  "Chole": 280,
  "Lemon rice": 221,
  "Papaya": 62,
  "Dosa": 167,
  "Malai kofta": 73,
  "Potato": 160,
  "Chana masala": 280,
  "Coconut ladoo": 387,
  "Uttapam": 50,
  "Chicken Biryani": 291,
  "Veg Biryani": 198,
  "Cabbage": 17,
  "Matar masala": 149
};

void main() {
  runApp(const Breakfast(day: 0, meal: 0));
}

class Breakfast extends StatelessWidget {
  final int day;
  final int meal;

  const Breakfast({Key? key, required this.day, required this.meal})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BreakfastUtil(title: 'Select Breakfast', day: day, meal: meal),
    );
  }
}

class BreakfastUtil extends StatefulWidget {
  final int day;
  final int meal;

  const BreakfastUtil(
      {Key? key, required this.day, required this.meal, required this.title})
      : super(key: key);
  final String title;
  @override
  State<BreakfastUtil> createState() => _BreakfastUtilState();
}

class _BreakfastUtilState extends State<BreakfastUtil> {
  List<FlutterLimitedCheckBoxModel> mySingleValueList = [];
  List<FlutterLimitedCheckBoxModel> mySelectedList = [];
  var futureCalorieData;
  int totalBreakfastCalories = 0;
  var limit = 4;

  @override
  void initState() {
    var foodName = "Dal";

    // get food name from menu.dart
    var dayMenu = menu[widget.day];

    if (dayMenu != null) {
      var mealMenu = dayMenu[widget.meal];
      if (mealMenu != null) {
        var i;
        for (i = 0; i < mealMenu.length; i++) {
          foodName = mealMenu[i];
          // print(foodName);
          mySingleValueList.add(FlutterLimitedCheckBoxModel(
              isSelected: false, selectTitle: foodName, selectId: i));
        }
      }
    }

    // mySingleValueList.add(FlutterLimitedCheckBoxModel(isSelected: false,  selectTitle: 'Option-1', selectId: 1));
    // mySingleValueList.add(FlutterLimitedCheckBoxModel(isSelected: false,  selectTitle: 'Option-2', selectId: 2));
    // mySingleValueList.add(FlutterLimitedCheckBoxModel(isSelected: false,  selectTitle: 'Option-3', selectId: 3));
    // mySingleValueList.add(FlutterLimitedCheckBoxModel(isSelected: false,  selectTitle: 'Option-4', selectId: 4));
    // mySingleValueList.add(FlutterLimitedCheckBoxModel(isSelected: false,  selectTitle: 'Option-5', selectId: 5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: FlutterUnlimitedCheckbox(
              activeColor: Colors.red,
              unlimitedCheckList: mySingleValueList,
              onChanged: (List<FlutterLimitedCheckBoxModel> list) {
                mySelectedList.clear();
                mySelectedList = [...list];
              },
              titleTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              mainAxisAlignmentOfRow: MainAxisAlignment.start,
              crossAxisAlignmentOfRow: CrossAxisAlignment.center,
            ),
          ),
          floatingActionButton: ElevatedButton(
            onPressed: () async {
              // here is the list of selected items
              totalBreakfastCalories = 0;
              for (var element in mySelectedList) {
                // print(element.selectId);
                // print(element.selectTitle);
                var xx = calorie[element.selectTitle];
                var xxx = xx.toString();
                var yele = int.parse(xxx);
                // print(xx.runtimeType);
                print(yele);
                totalBreakfastCalories += yele;
                // print(futureCalorieData.nf_calories);

              }

              print("Total Calories ${totalBreakfastCalories}");

              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> Calories = prefs.getStringList('Calories') ??
                  ['0', '0', '0', '0', '0', '0', '0'];
              var temp =
                  int.parse(Calories[widget.day]) + totalBreakfastCalories;
              Calories[widget.day] = temp.toString();
              prefs.setStringList('Calories', Calories);

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Breakfast Calorie Intake"),
                  content: Text("Total Calories ${totalBreakfastCalories}"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ClientApp()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(14),
                        child: const Text("okay"),
                      ),
                    ),
                  ],
                ),
              );

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const DisplayMenu()),
              // );
            },
            child: const Text('Submit'),
          ),
        ));
  }
}
