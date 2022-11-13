
import 'package:flutter/material.dart';
import 'package:flutter_limited_checkbox/flutter_limited_checkbox.dart';
import '../Data/NutritionX.dart';
import '../Data/menu.dart';
import '../DisplayMenu.dart';
import 'MessCardDeck.dart';

void main() {
  runApp(const Dinner(day: 0, meal:2));
}

class Dinner extends StatelessWidget {
  final int day;
  final int meal;

  const Dinner({Key? key, required this.day, required this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DinnerUtil(title: 'Select Dinner', day: day, meal: meal),
    );
  }
}

class DinnerUtil extends StatefulWidget {
  final int day;
  final int meal;

  const DinnerUtil({Key? key, required this.day, required this.meal, required this.title}) : super(key: key);
  final String title;
  @override
  State<DinnerUtil> createState() => _DinnerUtilState();
}

class _DinnerUtilState extends State<DinnerUtil> {


  List<FlutterLimitedCheckBoxModel> mySingleValueList=[];
  List<FlutterLimitedCheckBoxModel> mySelectedList=[];
  var futureCalorieData;
  int totalDinnerCalories = 0;
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
          totalDinnerCalories = 0;
          for (var element in mySelectedList) {
            // print(element.selectId);
            // print(element.selectTitle);
            futureCalorieData = await fetchCalorieData(element.selectTitle);
            var xx = futureCalorieData.nf_calories.toString();
            var yele = int.parse(xx);
            // print(xx.runtimeType);
            // print(yele.runtimeType);
            totalDinnerCalories+=yele;
            // print(futureCalorieData.nf_calories);

          }

          print("Total Calories ${totalDinnerCalories}");
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Dinner Calorie Intake"),
              content: Text("Total Calories ${totalDinnerCalories}"),
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