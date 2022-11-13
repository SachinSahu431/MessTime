//display the complete menu from menu.dart using accordion widget

import 'package:flutter/material.dart';
import 'package:client/pages/Data/menu.dart';
import 'package:client/pages/Data/NutritionX.dart';

//int to day
String intToDay(int day) {
  switch (day) {
    case 0:
      return 'Monday';
    case 1:
      return 'Tuesday';
    case 2:
      return 'Wednesday';
    case 3:
      return 'Thursday';
    case 4:
      return 'Friday';
    case 5:
      return 'Saturday';
    case 6:
      return 'Sunday';
    default:
      return 'Monday';
  }
}

//int to meal

String intToMeal(int meal) {
  switch (meal) {
    case 0:
      return 'Breakfast';
    case 1:
      return 'Lunch';
    case 2:
      return 'Dinner';
    default:
      return 'Breakfast';
  }
}

//get the list of fooditems for a particular day and meal from menu.dart
List<String>? getFoodItems(int day, int meal) {
  return menu[day]![meal];
}

class DisplayMenu extends StatefulWidget {
  const DisplayMenu({Key? key}) : super(key: key);

  @override
  _DisplayMenuState createState() => _DisplayMenuState();
}

class _DisplayMenuState extends State<DisplayMenu> {
  var curMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            title: Text(intToDay(index)),
            children: [
              //title for breakfast
              Text(intToMeal(0),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              //table of fooditems for breakfast containing 4 items in each row
              //add color to the table

              Table(
                border: TableBorder.all(),
                children: [
                  for (int i = 0; i < getFoodItems(index, 0)!.length; i += 4)
                    TableRow(
                      children: [
                        for (int j = i; j < i + 4; j++)
                          if (j < getFoodItems(index, 0)!.length)
                            //display the nutrition data when the fooditem is clicked
                            GestureDetector(
                              onTap: () {
                                //navigate to nutritionx page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NutritionX(
                                        day: index, meal: 0, index: j),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(getFoodItems(index, 0)![j]),
                              ),
                            )
                      ],
                    ),
                ],
              ),

              //title for lunch
              Text(intToMeal(1),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              //table of fooditems for lunch containing 4 items in each row

              Table(
                border: TableBorder.all(),
                children: [
                  for (int i = 0; i < getFoodItems(index, 1)!.length; i += 4)
                    TableRow(
                      children: [
                        for (int j = i; j < i + 4; j++)
                          if (j < getFoodItems(index, 1)!.length)
                            //display the nutrition data when the fooditem is clicked
                            GestureDetector(
                              onTap: () {
                                //navigate to nutritionx page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NutritionX(
                                        day: index, meal: 1, index: j),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(getFoodItems(index, 1)![j]),
                              ),
                            )
                      ],
                    ),
                ],
              ),

              //title for dinner
              Text(intToMeal(2),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),

              //table of fooditems for dinner containing 4 items in each row

              Table(
                border: TableBorder.all(),
                children: [
                  for (int i = 0; i < getFoodItems(index, 2)!.length; i += 4)
                    TableRow(
                      children: [
                        for (int j = i; j < i + 4; j++)
                          if (j < getFoodItems(index, 2)!.length)
                            //display the nutrition data when the fooditem is clicked
                            GestureDetector(
                              onTap: () {
                                //navigate to nutritionx page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NutritionX(
                                        day: index, meal: 2, index: j),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(getFoodItems(index, 2)![j]),
                              ),
                            )
                      ],
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
//ListTile(
//   title: const Text('Breakfast'),
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NutritionX(
//           day: index,
//           meal: 0,
//         ),
//       ),
//     );
//   },
// ),
// Table(
// children: [
// for (var food in getFoodItems(index, 0)!)
// TableRow(children: [
// //button to display nutrition data
// ElevatedButton(
// onPressed: () {
// //display nutrition data
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// NutritionX(day: index, meal: 0),
// ),
// );
// },
// child: Text(food),
// ),
// ]),
// ],
