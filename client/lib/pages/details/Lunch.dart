
import 'package:flutter/material.dart';
import 'package:flutter_limited_checkbox/flutter_limited_checkbox.dart';
import '../Data/NutritionX.dart';
import '../Data/menu.dart';
import '../DisplayMenu.dart';
import 'MessCardDeck.dart';

void main() {
  runApp(const Lunch(day: 0, meal:1));
}

class Lunch extends StatelessWidget {
  final int day;
  final int meal;

  const Lunch({Key? key, required this.day, required this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LunchUtil(title: 'Select Lunch', day: day, meal: meal),
    );
  }
}

class LunchUtil extends StatefulWidget {
  final int day;
  final int meal;

  const LunchUtil({Key? key, required this.day, required this.meal, required this.title}) : super(key: key);
  final String title;
  @override
  State<LunchUtil> createState() => _LunchUtilState();
}

class _LunchUtilState extends State<LunchUtil> {


  List<FlutterLimitedCheckBoxModel> mySingleValueList=[];
  List<FlutterLimitedCheckBoxModel> mySelectedList=[];
  var futureCalorieData;
  int totalLunchCalories = 0;
  var limit=4;



  @override
  void initState() {

    var foodName = "Dal";

    // get food name from menu.dart
    var dayMenu = menu[widget.day];

    if (dayMenu != null) {
      var mealMenu = dayMenu[widget.meal];
      if (mealMenu != null) {
        var i;
        for(i=0;i<mealMenu.length;i++)
        {
          foodName = mealMenu[i];
          // print(foodName);
          mySingleValueList.add(FlutterLimitedCheckBoxModel(isSelected: false,  selectTitle: foodName, selectId: i));
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: FlutterUnlimitedCheckbox(
          activeColor: Colors.red,
          unlimitedCheckList: mySingleValueList,
          onChanged: (List<FlutterLimitedCheckBoxModel> list){
            mySelectedList.clear();
            mySelectedList=[...list];



          },
          titleTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal,),
          mainAxisAlignmentOfRow: MainAxisAlignment.start,
          crossAxisAlignmentOfRow: CrossAxisAlignment.center,
        ),
      ),

      floatingActionButton:
      ElevatedButton(
        onPressed: () async {
          // here is the list of selected items
          totalLunchCalories = 0;
          for (var element in mySelectedList) {
            // print(element.selectId);
            // print(element.selectTitle);
            futureCalorieData = await fetchCalorieData(element.selectTitle);
            var xx = futureCalorieData.nf_calories.toString();
            var yele = int.parse(xx);
            // print(xx.runtimeType);
            // print(yele.runtimeType);
            totalLunchCalories+=yele;
            // print(futureCalorieData.nf_calories);

          }

          print("Total Calories ${totalLunchCalories}");
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Lunch Calorie Intake"),
              content: Text("Total Calories ${totalLunchCalories}"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
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

    );









  }
}