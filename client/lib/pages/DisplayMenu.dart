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
              //3 for breakfast, lunch and dinner each having the food items from menu.dart
              for (int i = 0; i < 3; i++)
                ExpansionTile(
                  title: Text(intToMeal(i)),
                  //just display the food items
                  children: [
                    if (getFoodItems(index, i) != null)
                      for (int j = 0; j < getFoodItems(index, i)!.length; j++)
                        ListTile(
                          title: Text(getFoodItems(index, i)![j]),
                          // onTap: () {
                          //   //display the nutrition data of the food item
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => NutritionX(
                          //         foodItem: getFoodItems(index,i)![j],
                          //       ),
                          //     ),
                          //   );
                          // },
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
